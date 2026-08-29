# Buffer Overflow: The Bug That Refuses to Die

Nearly forty years after it was first weaponised at internet scale, the buffer overflow is still with us. It is the reason C and C++ codebases get memory-safety CVEs every month, the reason your CPU has a bit that marks pages non-executable, and the reason Rust exists as a systems language. This post walks through what a buffer overflow actually is, how one is exploited, what it has cost the industry historically, and what genuinely works to prevent it.

---

## 1. What a buffer overflow is, and why it matters

A **buffer** is a contiguous, fixed-size block of memory allocated to hold data — a string, a network packet, a decoded image. A **buffer overflow** happens when a program writes more data into that block than it was sized for. The excess does not vanish and it does not raise an error. It lands in whatever memory sits immediately after the buffer.

The critical detail is that C and C++ perform no bounds checking. `char buf[64]` is not an object that knows it holds 64 bytes; it is an address. Writing `buf[100]` is a perfectly valid instruction that the compiler will emit and the CPU will execute. Whether that address belongs to your buffer, to another variable, or to the machinery the CPU uses to return from a function is not the language's concern.

That is what makes the class dangerous. A buffer overflow is not merely a crash — it is an **arbitrary memory write**, and in the worst case an attacker chooses both the destination and the contents.

### Why it matters in security terms

Memory-safety bugs of this family have consistently accounted for around two thirds of the serious vulnerabilities in large C/C++ products. Microsoft's security engineering team and Google's Chromium project have both published figures in that range, and the pattern has held for over a decade. It is the single most productive vulnerability class in the history of software security.

### What an attacker gains

The consequences scale with how much control the attacker has over the overflowing data:

| Level of control | Outcome |
|---|---|
| Overflow crosses into unmapped memory | **Denial of service** — the process segfaults |
| Overflow reaches an adjacent variable | **Logic corruption** — a privilege flag, a length field, a loop counter is silently changed |
| Overflow reaches a saved return address or function pointer | **Control-flow hijack** — the attacker redirects execution |
| Overflow reaches heap metadata | **Arbitrary write** — the allocator itself is turned into a write primitive |

Control-flow hijack is the prize. It means remote code execution with the privileges of the vulnerable process — historically often `root` or `SYSTEM`, because network daemons ran privileged. From there the attacker gets data theft, persistence, lateral movement, or a worm that repeats the whole process on the next host automatically.

---

## 2. How overflows occur: the mechanics

### The memory layout

A running process is divided into regions. The **stack** holds function-local variables and, crucially, bookkeeping: the saved frame pointer and the **return address** — where the CPU should jump when the current function finishes. The **heap** holds dynamically allocated memory (`malloc`, `new`) along with allocator metadata describing chunk sizes and free-list links.

On x86-64 and ARM64 the stack grows toward *lower* addresses, but a `strcpy` writes toward *higher* addresses. A local buffer therefore sits *below* the saved return address in memory, and overflowing it writes *upward*, straight into that return address. This mismatch of directions is the accident of architecture that makes stack smashing so effective. The diagram at the top of this post shows exactly this.

### The unsafe primitives

The classic offenders are C library functions that copy until they hit a terminator, with no idea how large the destination is:

```c
char buf[64];

gets(buf);                    // no length parameter exists at all
strcpy(buf, user_input);      // copies until '\0', however far that is
sprintf(buf, "%s", user_input);
strcat(buf, user_input);
```

`gets()` was so indefensible that it was deprecated in C99 and **removed outright from the C11 standard**. If you see it, the code is broken.

Modern equivalents take a size:

```c
char buf[64];

// Bounded, but strncpy does NOT guarantee termination — you must do it yourself
strncpy(buf, user_input, sizeof(buf) - 1);
buf[sizeof(buf) - 1] = '\0';

// Preferred: always bounded, always terminated, returns the length it wanted
snprintf(buf, sizeof(buf), "%s", user_input);
```

Note the trap in the middle case. `strncpy` does not append a null terminator if the source fills the buffer, so a naive "fix" swapping `strcpy` for `strncpy` can convert an overflow into an unterminated string — and the *next* read of that buffer runs off the end. Bounding the write is only half the job.

### Where bounds checks go missing

Real-world overflows rarely look like a bare `strcpy`. They hide in:

- **Off-by-one errors.** `for (i = 0; i <= n; i++)` writes one element past the end. A single byte is enough to corrupt a saved frame pointer — the "off-by-one" or "single-byte overflow" family.
- **Integer overflow feeding an allocation.** `malloc(count * size)` where the multiplication wraps around, producing a tiny allocation that the subsequent copy loop happily overfills.
- **Signed/unsigned confusion.** A length field read as a signed `int` and validated with `if (len > MAX)` passes the check when `len` is negative, then gets converted to a huge `size_t` at the copy.
- **Trusting an attacker-supplied length field.** The caller claims the payload is *N* bytes; the code copies *N* bytes without confirming *N* bytes actually arrived. This is Heartbleed, and it's covered below.

---

## 3. A simplified example of exploitation

Consider a login check written the way a lot of 1990s code was written:

```c
#include <stdio.h>
#include <string.h>

int check_login(void)
{
    int authenticated = 0;     /* sits adjacent to buf on the stack */
    char buf[16];

    printf("Password: ");
    gets(buf);                 /* no bound whatsoever */

    if (strcmp(buf, "correct-horse") == 0)
        authenticated = 1;

    return (authenticated);
}
```

The developer's mental model is that `authenticated` can only change by passing the `strcmp`. But `buf` and `authenticated` are neighbours in the same stack frame. Typing **20 characters** overflows `buf` by 4 bytes, and those 4 bytes land on `authenticated`. Any non-zero value there means the function returns "yes" without the password ever being correct.

No shellcode, no assembly, no debugger. Just an input longer than the developer imagined. This is the whole idea in miniature: **overflowing data does not stay in its lane, and what it lands on has meaning.**

### Escalating to control-flow hijack

The classic escalation targets the saved return address instead of a neighbouring variable. Conceptually, the attacker:

1. **Finds the offset.** How many bytes from the start of the buffer to the saved return address? Determined by sending a long, non-repeating pattern and observing which four or eight bytes end up in the instruction pointer when the process crashes.
2. **Crafts input of exactly that length**, then appends the address they want the CPU to jump to.
3. **Waits for the function to return.** The `ret` instruction pops whatever is at that stack slot into the instruction pointer. It has no way to know the value is forged.

Where that address points has changed over the decades, and the change *is* the history of the defences. In the 1990s it pointed at attacker-supplied machine code sitting in the buffer itself. Once memory was marked non-executable, that stopped working, and attackers moved to **return-oriented programming** — chaining together short instruction sequences that already exist in the program's own legitimate code. The bug is the same; only the payload strategy evolved.

### A hands-on version

You can observe the underlying principle without writing a single exploit. In a lab exercise I recently completed, a small C program does `strdup("Holberton")` and prints the string in a loop forever. A separate Python script parses `/proc/<pid>/maps` to locate the `[heap]` region, opens `/proc/<pid>/mem`, searches the heap for the ASCII bytes, and overwrites them in place:

```
$ sudo ./read_write_heap.py $(pgrep -x main) Holberton maroua
[*] heap: 0xaaaac15d5000-0xaaaac15f6000 (135168 bytes, perms rw-p)
[*] found b'Holberton' at 0xaaaac15d5310 (heap offset 0x310)
[*] wrote b'maroua' plus 3 NUL byte(s) at 0xaaaac15d5310
```

The running program immediately starts printing `maroua` — at the *same* pointer. That last detail is the lesson: nothing about the program changed except bytes in memory that the program trusted. One constraint is instructive — the replacement cannot be longer than the original, because `strdup("Holberton")` reserved exactly ten bytes and writing past them would corrupt the next heap chunk's metadata. That constraint *is* the buffer overflow condition, seen from the attacker's side.

---

## 4. Historical significance

### The Morris Worm (November 1988)

The first internet worm, written by Robert Tappan Morris, then a graduate student at Cornell. One of its propagation vectors exploited a stack buffer overflow in the BSD `fingerd` daemon, which used `gets()` to read a network-supplied string into a 512-byte stack buffer. Sending a longer string overwrote the return address and executed the worm's code on the target.

It spread further and faster than intended, and contemporary estimates put the number of affected machines at several thousand — a substantial share of everything connected at the time. The fallout was structural rather than technical: it prompted the creation of the CERT Coordination Center at Carnegie Mellon, and Morris became the first person convicted under the US Computer Fraud and Abuse Act. It also established a pattern that repeated for thirty years — a memory bug in a privileged network daemon, turned into automated self-propagating code.

### "Smashing the Stack for Fun and Profit" (1996)

Not an attack but a turning point. Elias Levy, writing as Aleph One, published a step-by-step tutorial in *Phrack* magazine, issue 49. It took stack smashing from folklore known to a handful of researchers to a documented, reproducible technique. Exploitation of this class became widespread almost immediately afterwards.

### Code Red (2001) and SQL Slammer (2003)

**Code Red** exploited a buffer overflow in the indexing service ISAPI extension of Microsoft IIS (CVE-2001-0500), infecting hundreds of thousands of web servers and defacing them.

**SQL Slammer** exploited a stack overflow in the Microsoft SQL Server Resolution Service. Its payload fit into a **single 376-byte UDP packet**, which meant it needed no handshake and no round trip — it spread as fast as networks could physically carry packets. It doubled its infected population roughly every 8.5 seconds and saturated large parts of the internet backbone within about ten minutes, disrupting ATMs and, in one widely reported case, degrading monitoring at a nuclear plant's business network. It remains the canonical demonstration of what a memory bug in a UDP service can do.

### Heartbleed (2014)

CVE-2014-0160, in OpenSSL's implementation of the TLS heartbeat extension. Worth including precisely because it is the *inverse* case and is frequently miscategorised.

The heartbeat protocol lets a client send a small payload with a stated length, and the server echoes it back. OpenSSL took the client's claimed length at face value and copied that many bytes out of the buffer — without checking that the client had actually sent that much. A client could claim 64 KB while sending one byte, and receive 64 KB of whatever happened to be adjacent in the server's memory: session cookies, usernames and passwords, and in some cases the server's **private TLS key**.

So Heartbleed is a buffer over-**read**, not an over-write. It corrupts nothing and crashes nothing. That is exactly why it was so severe: exploitation left no trace in any log, the bug had been present for roughly two years before disclosure, and it affected an estimated 17% of the internet's secure web servers. It forced a global certificate reissuance and password reset, and it is the reason the industry started seriously funding audits of critical open-source infrastructure. The lesson generalises: **a length field supplied by the other side of a connection is attacker-controlled data, not a fact.**

### Stagefright (2015)

Multiple overflows in Android's media processing library, triggerable by an MMS message that the target never had to open. Roughly 950 million devices were affected. Its lasting effect was to change Android's release engineering: it prompted monthly security patches and, later, the isolation of media parsing into a heavily sandboxed process.

---

## 5. Practical mitigation

No single control solves this. Effective defence is layered, and the layers fall into four groups.

### Write code that cannot overflow

- **Prefer memory-safe languages for new work.** Rust, Go, Java, C#, and Python bounds-check by construction. This is the only measure that eliminates rather than mitigates the class, and it is increasingly the formal recommendation of national cybersecurity agencies. Where a full rewrite is unrealistic, rewriting the parts that touch untrusted input — parsers, decoders, network-facing code — captures most of the benefit.
- **Ban the unsafe primitives.** No `gets`, `strcpy`, `strcat`, or `sprintf`. Enforce it in CI, not in a style guide nobody reads.
- **Use bounded functions correctly.** `snprintf` over `strncpy` where you can, and always terminate explicitly. Consider `strlcpy`/`strlcat` where available.
- **Validate lengths at the trust boundary.** Check that the data you actually received matches the length the sender claimed. Heartbleed is one `if` statement away from never having happened.
- **Watch the arithmetic.** Check for integer overflow before any `malloc(a * b)`, and be deliberate about signed/unsigned conversions in size calculations.

### Let the compiler defend you

These cost almost nothing and should be default in every build:

```bash
gcc -Wall -Wextra -Werror \
    -fstack-protector-strong \
    -D_FORTIFY_SOURCE=2 -O2 \
    -fPIE -pie \
    -Wl,-z,relro,-z,now \
    -Wl,-z,noexecstack \
    program.c -o program
```

- **`-fstack-protector-strong`** inserts a **stack canary**: a random value placed between local buffers and the saved return address, verified before the function returns. A linear overflow must destroy the canary to reach the return address, so the mismatch is detected and the process aborts. It converts a code-execution bug into a crash.
- **`-D_FORTIFY_SOURCE=2`** with optimisation enabled makes glibc substitute bounds-checked variants of common functions wherever the destination size is known at compile time.
- **`-fPIE -pie`** produces a position-independent executable, which is what lets ASLR randomise the main binary and not just the libraries.
- **`-Wl,-z,relro,-z,now`** makes the GOT read-only after linking, removing a classic overwrite target.

### Let the operating system defend you

- **NX / DEP** (the No-eXecute bit) marks the stack and heap non-executable, so injected shellcode cannot run. Attackers answered with ROP, so this is a raise of cost rather than a cure.
- **ASLR** randomises the base addresses of the stack, heap, and libraries at each execution, so the attacker cannot reliably hardcode a jump target. Its effectiveness depends on entropy — 32-bit systems have too little — and it is defeated by any bug that leaks an address, which is why info-leak vulnerabilities are valued so highly.
- **Control-flow integrity** (Intel CET's shadow stack, ARM Pointer Authentication and BTI, Clang's CFI) validates indirect branches and return addresses in hardware or via compiler instrumentation. This is the most meaningful recent development, because it targets ROP directly.
- **Least privilege.** A daemon running as an unprivileged user in a container or under seccomp gives a successful exploit far less to work with. Assume the bug will be found; constrain what it buys.

### Find the bugs before shipping

- **Sanitizers.** Build tests with `-fsanitize=address` (ASan) to catch out-of-bounds reads and writes at the moment they happen, with a full stack trace, rather than as a mysterious crash later. Add `-fsanitize=undefined` for the integer-overflow class.
- **Fuzzing.** Coverage-guided fuzzers such as AFL++ and libFuzzer generate malformed input and mutate toward new code paths. Combined with ASan, fuzzing is the highest-yield technique available for this bug class, and it is what Google's OSS-Fuzz has used to find tens of thousands of bugs in open-source projects.
- **Static analysis.** `clang-tidy`, Coverity, CodeQL and similar tools flag suspicious patterns in CI before review.
- **Targeted code review.** Focus human attention on the places where untrusted input first meets a fixed-size buffer. That is where the bugs are.

---

## Conclusion

The buffer overflow persists not because it is subtle but because the assumptions that produce it are convenient. C's speed comes precisely from omitting the bounds check, and every layer of mitigation since — canaries, NX, ASLR, CFI — is a way of paying for that omission at a different point in the stack. Each one raised the cost of exploitation without removing the underlying bug, which is why the same class of vulnerability connects a 1988 worm to a 2015 mass-market phone flaw.

What changes the trajectory is not another mitigation but the elimination of the bug class at the language level, combined with the discipline to find what remains — sanitizers, fuzzing, and honest review — before someone else does. Until the legacy C is gone, that is the work.

---

*Written as part of the DLH Cybersecurity Academy offensive security programme, Luxembourg.*
