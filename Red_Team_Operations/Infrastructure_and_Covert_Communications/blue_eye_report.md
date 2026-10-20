# Task 3 — O3: Blue Eye Report

## Objective
Evaluate the red-team infrastructure from a defender's perspective, identify observable activity, and recommend security improvements.

## Infrastructure
- Kali operator: 192.168.56.10
- Ubuntu teamserver: 192.168.56.20
- Nginx: HTTPS reverse proxy on port 443
- Sliver: localhost HTTP listener on port 8443
- dnsmasq: internal lab DNS service

## Defender Visibility

### 1. Network Traffic
- HTTPS connections to the teamserver may appear in firewall and network logs.
- DNS queries may reveal the configured laboratory domains.
- Repeated HTTP requests can produce recognizable timing patterns.

### 2. Server Evidence
- Nginx access logs record incoming HTTP requests.
- Authentication and systemd logs record service activity.
- Listening ports can reveal externally accessible services.

### 3. Detection Opportunities
- Monitor unusual DNS domains and repetitive connections.
- Inspect HTTP request paths and User-Agent values.
- Review unexpected listening services and outbound connections.
- Correlate DNS, network, and host telemetry.

## Security Recommendations
- Restrict management interfaces to authorized operators.
- Keep internal backend listeners bound to localhost.
- Apply firewall rules and maintain audit logging.
- Use monitoring to identify unauthorized activity.
- Stop testing when the authorized engagement ends.

## Lab Observations
The HTTPS frontend returned CDN-like response headers.
The Sliver backend was observed listening on localhost.
No independent defender-side detection test has been documented yet.

## Conclusion
The lab demonstrates how reverse proxies and DNS configurations
affect network visibility. A full defensive assessment requires
packet captures, service enumeration, and log analysis.
