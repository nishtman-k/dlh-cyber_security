# CyberCorp Industries — Engagement Report

**Status:** Partial Kali/Ubuntu engagement. **Prepared:** 2026-10-20. **Windows endpoint phase:** Not performed.

## Executive Summary
The isolated academy lab demonstrated Ubuntu SSH and firewall hardening, non-root Sliver service configuration, HTTPS reverse proxying, local DNS cover records, User-Agent filtering, and mock Graph-style HTTP responses. Tasks 1 and 2 were reported as fully validated. There is **no evidence of a Windows implant, active beacon, screenshot, or file exfiltration**. This document does not claim to satisfy the full Windows-oriented attack chain.

## Scope
- Kali operator: `192.168.56.10`
- Ubuntu teamserver: `192.168.56.20`
- Windows target `192.168.56.30`: **Not installed / not assessed**
- Lab-only DNS aliases: `update-microsoft.com`, `api.office365-verify.com` (local DNS context; no public targets).

## Timeline (2026-10-20, UTC from terminal outputs)
| Time | Event | Observed evidence |
|---|---|---|
| 13:34:01 | Cover page created | HTML file Last-Modified header |
| 13:36:49 | Ubuntu localhost `GET /` | Nginx access log: HTTP 200 |
| 13:36:56 | Ubuntu localhost `GET /beacon` | Nginx access log: HTTP 404; not proof of active beacon |
| 13:38:45 | Kali connected to Ubuntu cover and proxy | Curl: HTTP 200 and 404 |
| 14:00:09 | Scanner User-Agent test triggered monitor | Burn log `Nikto`, HTTP 403, source `192.168.56.10`; decoy later HTTP 302 |
| 20:16:14 | HTTPS frontend checked | HTTP 200, `X-CDN-Node: edge-01`, `X-Cache: HIT`, no Nginx Server header |
| 20:23:51 | Graph-style local endpoint tested | `/v1.0/me`: 401 JSON without token, 200 JSON with synthetic Bearer token |

## Findings
### F-01 — Requests are attributable in reverse-proxy logs
**Evidence:** The actual burn-notice line read: `2026-10-20T14:00:09+00:00 BURN NOTICE: 192.168.56.10 - - [20/Oct/2026:14:00:09 +0000] "GET /beacon HTTP/1.1" 403 162 "-" "Nikto"`.
**Impact:** Source IP, endpoint and scanner-identifying UA were observable. **Recommendation:** Collect and correlate reverse-proxy and firewall telemetry; set alerts for unusual UA and paths.

### F-02 — Backend localhost binding observed
**Evidence:** Ubuntu `ss -lntp` showed Sliver on `127.0.0.1:8443` and Nginx on `0.0.0.0:443`. This supports localhost binding, but no independently archived remote scan is included. **Recommendation:** Retain restricted firewall rules and repeat external visibility scans for final evidence.

### F-03 — Mock Graph responses are not evidence of C2 session
**Evidence:** The custom Nginx endpoint returned `application/json`, 401 for missing bearer, and 200 for example bearer; D4 validator passed 3/3. **Limit:** No Windows-generated traffic or implant connection shown.

## Execution and evidence inventory
| Required phase | Result |
|---|---|
| Rules of Engagement | Drafted; approval fields remain pending |
| APT29 mapping | Researched and documented |
| Windows initial access / implant execution | **Not executed** (no Windows VM) |
| Live Sliver beacon / session | **Not proven**; a listener is not a beacon |
| Windows `whoami`, network/process/file enumeration | **Not executed** |
| Windows desktop screenshot | **Not captured** |
| Download ≥2 planted Windows files | **Not performed**; no exfiltrated files |
| Post-mortem | Partial Kali/Ubuntu evidence-based review |

## Recommendations
1. Approve the exact environment, schedule and contacts before future tests.
2. Capture UTC-stamped raw logs, command output, and packet traces; keep originals.
3. Restrict backend ports to localhost and monitor Nginx and firewall access logs.
4. Use **synthetic** endpoint objective files if a Windows lab host becomes available.
5. Distinguish validator passes from proof of a completed kill chain.

## Reviewer limitations
This report relies on actual outputs shared during prior lab steps. It has no Windows endpoint telemetry, Sliver beacon results, screenshots, or transfer hashes. Consequently **Step 3 cannot be represented as completed**; it requires instructor acceptance of a reduced-scope submission or future evidence.
