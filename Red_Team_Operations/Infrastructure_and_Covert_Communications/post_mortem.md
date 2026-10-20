# CyberCorp Industries — OPSEC Post-Mortem

**Prepared:** 2026-10-20. **Review scope:** Kali + Ubuntu observations only; no Windows VM.

## 1. Timeline
Labels: **Clean** = normal lab test; **Detected** = logged/alerted; **Mistake** = avoidable fingerprint or exposure. These labels describe observability, not proof of a real Blue Team alert.

| UTC, 2026-10-20 | Classification | Action / observed outcome |
|---|---|---|
| 13:36:49 | Clean | Local `GET /`, HTTP 200, access-log entry |
| 13:36:56 | Clean | Local `GET /beacon`, HTTP 404, access-log entry |
| 13:38:45 | Clean | Kali tested Nginx; HTTP 200/404 |
| 14:00:09 | **Detected / Mistake** | `Nikto` UA to `/beacon` logged with Kali IP and HTTP 403, triggered burn monitor |
| After 14:00:09 | Detected | Decoy response HTTP 302 observed |
| 20:16:14 | Clean | HTTPS 200, CDN-style headers present |
| 20:23:51 | Clean | Synthetic Graph API endpoint returned 401/200 JSON |
| 20:30 approx. | Clean | Logrotate dry-run diagnostics completed |

## 2. OPSEC Failures Found
### Failure 1 — Tool fingerprint and source IP exposed
**Actual evidence:**

```text
2026-10-20T14:00:09+00:00 BURN NOTICE: 192.168.56.10 - - [20/Oct/2026:14:00:09 +0000] "GET /beacon HTTP/1.1" 403 162 "-" "Nikto"
```

**What a defender could see:** Operator IP `192.168.56.10`, requested path, HTTP status and a scanner-identifying User-Agent. The decoy switch is additional evidence of inspection. **Improvement:** Plan telemetry checks explicitly, correlate Nginx/firewall logs, and treat synthetic probe results as visible to defenders rather than assuming stealth.

### Failure 2 — Original server identification exposed
**Actual evidence:** Initial R1 HTTP response contained `Server: nginx/1.24.0 (Ubuntu)`. Later D2 HEAD output no longer displayed that header after `headers-more` was configured. **Defender view:** Web server/version fingerprint in the initial phase. **Improvement:** Inspect response metadata after every proxy configuration change.

## 3. Lessons Learned
**Worked:** VM snapshots before major work, `nginx -t` checks, localhost backends, restricted lab IPs, and incremental testing with curl/dig and validator outputs.

**Improve:** Design port layout before editing listeners; preserve original UTC evidence; measure external port exposure; document the difference between a Sliver listener and an actual implant connection; validate scope and sign-offs before any future endpoint work.

## 4. Cleanup and Verification
| Checklist item | Status |
|---|---|
| Windows implant removal | Not applicable: no Windows implant used |
| Windows Event Log / Prefetch review | Not applicable: Windows VM absent |
| Active Sliver beacon absence | **Not independently verified** (only listeners observed) |
| Ubuntu Nginx / auth / Sliver log review | Partial excerpt-based review; complete export not available |
| Kali shell history / temporary directory review | **Not yet evidenced** |
| Task 3 `/opt/cleanup/post_op_wipe.sh` | Exists and passed O1 validator; observed dry-run, not a Task 4 execution record |
| Removal of temporary, operator-created lab files | **Pending final inventory and approved cleanup** |
| Destruction of security audit logs | **Not done; retain through peer review** |

**Closeout procedure:** Retain and hash peer-review evidence; inventory disposable lab artifacts and running listeners; stop unused lab-only services where approved; remove explicitly disposable files; record cleanup timestamp and results. Do not claim completed cleanup until evidenced.

## 5. Final Assessment
At least one real lab OPSEC mistake is documented with source and timestamp. Written review can proceed on Kali/Ubuntu. No Windows execution, file transfers, screenshots, or beacon/implant cleanup can truthfully be reported for Task 4.
