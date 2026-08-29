#!/usr/bin/python3
"""Find an ASCII string in the heap of a running process and replace it.

Usage: read_write_heap.py pid search_string replace_string

Silent on success. Set RWH_VERBOSE=1 for diagnostics on stdout.
"""
import os
import sys

VERBOSE = os.environ.get("RWH_VERBOSE") is not None


def log(message):
    """Print a diagnostic line only when RWH_VERBOSE is set."""
    if VERBOSE:
        print(message)


def fail(message):
    """Print an error message on stdout and exit with status 1."""
    print(message)
    sys.exit(1)


def find_heap(pid):
    """Return (start, end, perms) of the [heap] region of `pid`."""
    path = "/proc/{}/maps".format(pid)
    try:
        with open(path, "r") as maps:
            for line in maps:
                fields = line.split()
                if fields[-1] == "[heap]":
                    start, end = (int(x, 16) for x in fields[0].split("-"))
                    return start, end, fields[1]
    except FileNotFoundError:
        fail("Error: no such process: {}".format(pid))
    except PermissionError:
        fail("Error: permission denied reading {} (try sudo)".format(path))
    fail("Error: no [heap] region found for pid {}".format(pid))


def main():
    """Parse arguments, locate the string in the heap, overwrite it."""
    if len(sys.argv) != 4:
        fail("Usage: read_write_heap.py pid search_string replace_string")

    pid, search, replace = sys.argv[1], sys.argv[2], sys.argv[3]

    if not pid.isdigit() or int(pid) <= 0:
        fail("Usage: pid must be a positive integer")
    if search == "":
        fail("Usage: search_string must not be empty")
    try:
        search = search.encode("ASCII")
        replace = replace.encode("ASCII")
    except UnicodeEncodeError:
        fail("Usage: search_string and replace_string must be ASCII")
    if len(replace) > len(search):
        fail("Usage: replace_string must not be longer than search_string")

    start, end, perms = find_heap(pid)
    log("[*] heap: {:#x}-{:#x} ({} bytes, perms {})"
        .format(start, end, end - start, perms))

    path = "/proc/{}/mem".format(pid)
    try:
        with open(path, "rb+", buffering=0) as mem:
            mem.seek(start)
            heap = mem.read(end - start)

            offset = heap.find(search)
            if offset == -1:
                fail("Error: {} not found in the heap".format(search))
            addr = start + offset
            log("[*] found {} at {:#x} (heap offset {:#x})"
                .format(search, addr, offset))

            payload = replace + b"\0" * (len(search) - len(replace))
            mem.seek(addr)
            mem.write(payload)
            log("[*] wrote {} plus {} NUL byte(s) at {:#x}"
                .format(replace, len(payload) - len(replace), addr))
    except PermissionError:
        fail("Error: permission denied on {} (try sudo)".format(path))
    except FileNotFoundError:
        fail("Error: no such process: {}".format(pid))
    except OSError as err:
        fail("Error: {}".format(err))


if __name__ == "__main__":
    main()
