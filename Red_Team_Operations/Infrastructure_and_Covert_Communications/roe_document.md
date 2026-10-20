# CyberCorp Industries — Rules of Engagement

**Type:** Red Team Assessment (isolated academy lab)  
**Status:** Draft pending instructor/client approval  
**Prepared:** 2026-10-20

## 1. Engagement Overview
Client: CyberCorp Industries (fictional). Duration: [instructor-approved start/end dates and time zone]. Aim: assess an isolated environment through network configuration, controlled tests, and defensible evidence review.

## 2. Scope
| Target | Status | Role |
|---|---|---|
| 192.168.56.10 | In scope | Kali operator VM |
| 192.168.56.20 | In scope | Ubuntu teamserver, Nginx, dnsmasq |
| update-microsoft.com; api.office365-verify.com | Local lab DNS only | Resolve internally to Ubuntu |
| 192.168.56.30 | **Not available / not tested** | Optional future Windows lab VM, subject to approval |

Out of scope: actual Microsoft services, all public IPs, unrelated VMs, production services, personal devices, real identities and PII. Allowed: lab-only DNS, TLS, proxy, service tests, host configuration, non-destructive reconnaissance, synthetic data. Prohibited: DoS, destructive actions, unauthorized persistence, real phishing, stealing actual data, and disabling security protections outside separately approved test systems.

## 3. Rules
- Working hours: [agreed window, to be completed].
- Notify the client POC at start, significant phase changes, and any incident.
- No real PII. Only synthetic files and test accounts.
- Preserve UTC timestamps, original commands, logs and screenshots through peer review; restrict access to evidence.
- Stop if unexpected traffic, an out-of-scope host, or service degradation occurs.

## 4. Communication
Client/emergency POC: [instructor / approved contact]. Red team lead: [student/operator]. Approved communication channel: [channel]. Status reports: after each phase and at least daily during active testing. Emergency escalation: stop → preserve evidence → notify POC → obtain clearance before restart.

## 5. Deconfliction
Proposed deconfliction phrase: `CYBERCORP-LAB-2026` (POC approval pending). Maintain a UTC event ledger identifying operator, source/destination and planned action. Blue Team detection triggers a pause; POC checks against the ledger; unknown events are investigated as possible genuine incidents.

## 6. Legal, Retention and Authorization
Testing is limited to explicit written instructor/client authorization; this draft does not itself grant permission. Liability and responsibilities are governed by academy rules. Retain evidence through review, then dispose of approved temporary test artifacts under an agreed schedule. Do not delete security logs merely to conceal activity.

**Authorization / signature:** [pending]  
**Approved dates:** [pending]  
**Client POC:** [pending]  
**Red team lead:** [pending]
