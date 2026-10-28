# Security Incident Report and Future Mitigations

## 1. Introduction

Log analysis helps identify suspicious activity, investigate unauthorized access, and develop protective measures.

This investigation examined `auth.log` and `dmesg` to identify the service used for access, the targeted operating system, suspicious logins, account creation, and firewall activity.

## 2. Incident Findings

### Service and Operating System

The authentication logs show SSH login activity through the `sshd` service.

The system startup log identifies Ubuntu running Linux kernel `2.6.24-26-server`. This is an outdated kernel that requires migration to a supported platform.

### Suspected Account Compromise

The `root` account recorded a failed SSH password login followed by a successful login from the same IP address six seconds later.

This sequence is suspicious and identifies `root` as the suspected compromised account in this investigation. Failed attempts followed by success alone do not conclusively prove unauthorized access.

### Successful Access Sources

Successful SSH logins were recorded from multiple IP addresses. Under the project's assumption, each distinct source represents a different attacker.

The final source count should be verified against successful logins to the compromised account. A successful login alone does not establish that a source was malicious.

### Account Creation

Account creation entries should be reviewed to distinguish legitimate service accounts from unauthorized users.

Names such as `mysql`, `sshd`, and `messagebus` may represent legitimate system services. Their presence alone does not establish malicious activity. Unexpected accounts require investigation of their creation time, privileges, and subsequent activity.

### Firewall Activity

The investigation searched authentication logs for commands that add firewall rules.

Logged commands show attempted configuration changes, but do not prove that the commands succeeded or that the rules remained active. The effective firewall configuration must be checked separately.

### Potential Impact

If unauthorized root access occurred, an attacker could:

- Read, modify, or delete application data.
- Create accounts and establish persistent access.
- Change firewall rules and other security controls.
- Access credentials stored on the system.

These are potential consequences. Data theft, application modification, and service disruption have not been established by the available findings.

## 3. Recommended Security Measures

- Replace the outdated system with a supported operating system.
- Disable direct SSH login as root.
- Use individual administrator accounts with controlled `sudo` privileges.
- Enable SSH key authentication and disable password authentication after testing access.
- Restrict SSH access to trusted administration networks or a VPN.
- Apply connection controls and tools such as Fail2ban to reduce repeated login attempts.
- Remove confirmed unauthorized accounts and review privileged access.
- Rotate potentially exposed passwords, SSH keys, and application secrets.
- Centralize logs and protect them against unauthorized modification.

## 4. Implementation Plan

1. **Preserve evidence**
   - Retain copies of authentication and system logs.
   - Record file hashes and maintain an investigation timeline.
   - Capture active sessions, accounts, SSH keys, and firewall rules.

2. **Contain suspected access**
   - Restrict administrative access to trusted sources.
   - Investigate suspicious sessions and disable confirmed unauthorized accounts.
   - Preserve evidence before making changes where practical.

3. **Recover the system**
   - If root compromise is confirmed, rebuild from a trusted image.
   - Use a supported operating system and install security updates.
   - Restore verified application data and rotate exposed credentials from a trusted device.

4. **Harden SSH**
   - Create a named administrator account with an SSH key.
   - Test its login and `sudo` access.
   - Set `PermitRootLogin no`.
   - Disable password and keyboard-interactive authentication if they are not required.
   - Validate the SSH configuration before reloading the service.
   - Keep a recovery session available until access is verified.

5. **Apply firewall controls**
   - Allow only required services.
   - Limit SSH to approved administration sources.
   - Confirm the active rules and ensure they persist after restart.
   - Test access before closing the recovery session.

6. **Validate the changes**
   - Confirm that authorized administration still works.
   - Verify that direct root login and unwanted authentication methods are rejected.
   - Confirm that monitoring receives the relevant events.

## 5. Monitoring Protocol

### Continuous Monitoring

Collect and alert on:

- Repeated SSH authentication failures.
- Successful logins following repeated failures from the same source.
- Root login attempts and unexpected privileged activity.
- Account creation, privilege changes, and SSH key modifications.
- Firewall changes and interruptions in log collection.

### Daily Review

Review security alerts, unusual successful logins, and unexpected account activity. Investigate suspicious sources using timestamps, account names, and session activity.

### Weekly Review

Check active accounts, administrative privileges, firewall rules, and pending security updates. Review blocked connections and false positives.

### Monthly Evaluation

Test alert delivery, review access requirements, and confirm that backups can be restored. Adjust detection thresholds using observed legitimate activity.

### Effectiveness Criteria

The controls should prevent direct root SSH access, restrict administration to approved sources, and produce timely alerts for suspicious authentication and account changes.

## 6. Conclusion

The logs show suspicious SSH activity involving the root account on an outdated Ubuntu system. Further investigation is required to establish the full extent of unauthorized activity.

The priorities are to preserve evidence, restrict access, recover from a trusted platform if compromise is confirmed, harden SSH, and maintain continuous monitoring.
