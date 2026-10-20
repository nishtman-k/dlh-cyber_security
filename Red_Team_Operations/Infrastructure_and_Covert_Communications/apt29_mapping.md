# APT29 Threat-Actor Emulation — MITRE ATT&CK Mapping

**Prepared:** 2026-10-20. **Threat group:** APT29 / Cozy Bear / Midnight Blizzard (G0016). **Primary source:** [MITRE ATT&CK APT29 group profile](https://attack.mitre.org/groups/G0016/).

## Research and scope
APT29 is a state-linked espionage threat group; MITRE associates the following techniques with its reported campaigns. These are **researched tactics**, not actions claimed to have been performed in this lab. Sliver is a test framework, not the threat actor's actual toolset.

## Technique mappings (12)
| Tactic | ID | APT29-associated technique | Potential Sliver capability or lab equivalent | Observed in Task 4? |
|---|---|---|---|---|
| Initial Access | T1566.001 | Phishing: Spearphishing Attachment | Manual simulated delivery; Sliver itself does not send phishing emails | No |
| Execution | T1059.001 | PowerShell | `shell` for approved, harmless PowerShell inventory | No |
| Execution | T1059.003 | Windows Command Shell | `shell` for authorized cmd.exe checks | No |
| Discovery | T1057 | Process Discovery | `ps` | No |
| Discovery | T1087.002 | Domain Account Discovery | `shell` with approved domain inventory commands; not native AD discovery | No |
| Collection | T1005 | Data from Local System | `download` limited to planted synthetic files | No |
| Collection | T1560.001 | Archive via Utility | `shell` with an approved archive utility; not Sliver-native | No |
| Command and Control | T1071.001 | Web Protocols | Sliver HTTP/HTTPS listener, Nginx proxy | Local listener/proxy tested, no beacon proven |
| Command and Control | T1090.001 | Internal Proxy | Sliver SOCKS or manual proxy tooling; not identical to Nginx reverse proxy | Not demonstrated as SOCKS |
| Command and Control | T1105 | Ingress Tool Transfer | `upload` of benign test data | No |
| Defense Evasion | T1036.005 | Match Legitimate Resource Name or Location | Manual simulated artifact naming; no claim of undetected execution | No |
| Defense Evasion | T1070.004 | File Deletion | Authorized cleanup of disposable lab files, preserving security logs | No Task 4 execution |

All 12 technique IDs are documented on MITRE's APT29 group profile. These span **six tactics**. A hypothetical capability is not evidence of execution.

## Proposed implant profile — design only
| Setting | Proposed value | Rationale |
|---|---|---|
| Transport | HTTPS, lab-local destination | Exercises ATT&CK web C2 visibility |
| Sleep / beacon interval | 300 seconds (5 minutes) | Slow cadence for telemetry comparison; not a unique APT29 signature |
| Jitter | 60% | Randomized cadence for comparison; not a documented precise APT29 setting |
| Kill date | 2026-10-31 23:59 UTC, subject to approval | Prevent indefinite operation |
| Data | Synthetic only | No real personal/company information |

**Execution status:** Not generated or executed in Task 4. Kali/Ubuntu service validation in earlier tasks does not prove a Windows implant, callback, or post-exploitation session. A Windows VM was not installed.

## Sources
- [MITRE ATT&CK — APT29 (G0016)](https://attack.mitre.org/groups/G0016/)
- [MITRE ATT&CK — SoreFang (S0516), APT29-linked software](https://attack.mitre.org/software/S0516/)
