# Web Application Incident Report

## 1. Introduction

This investigation analyzed `logs.txt` to identify the main source of requests, the most requested endpoint, and the tool or library indicated by the source's User-Agent.

One IP address generated 5,000 requests. The activity was investigated as a suspected Denial of Service (DoS) attempt.

The available findings do not confirm a slowdown, service outage, or resource exhaustion. The main recommendation is to implement rate limiting to control excessive requests.

## 2. Detailed Attack Analysis

### Findings

| Item | Result |
|---|---|
| Suspected attack source | Source A — IP anonymized |
| Requests from Source A | 5,000 |
| Most requested endpoint overall | `/` |
| Most common User-Agent from Source A | `python-requests/2.31.0` |
| Suspected activity | Automated HTTP requests |
| Service impact | Not established |

### Source Identification

The script `0-attack_ip.sh` identified the IP address responsible for the highest number of requests. This address is represented as **Source A** to anonymize the report.

The address identifies the apparent request source, not necessarily an individual. It could belong to a shared connection or proxy.

### Targeted Endpoint

The script `1-endpoint.sh` identified `/`, the application's root path, as the most frequently requested endpoint across the log.

This result does not establish that all requests from Source A targeted `/`. A separate count filtered by both source and endpoint would be required.

### Request Volume

The script `2-count_attack.sh` counted **5,000 requests** from Source A.

The duration and peak request rate have not been established. Therefore, the total alone cannot demonstrate that the requests exceeded the application's capacity.

### Tool or Library

The script `3-library.sh` identified the following User-Agent as the most common among requests from Source A:

`python-requests/2.31.0`

This suggests automation using the Python Requests library. However, User-Agent strings can be changed, and the library also has legitimate uses. This value alone does not prove malicious intent or confirm the actual software used.

### Additional Security Weaknesses

No additional vulnerability was confirmed during these tasks. The following potential weaknesses should be reviewed:

- Missing or ineffective request rate limits.
- Insufficient connection limits and request timeouts.
- Missing alerts for abnormal request activity.
- Incorrect client IP handling when operating behind a proxy.

These are areas for verification, not confirmed findings.

## 3. Proposed Mitigation Strategy

### Rate Limiting

Implement rate limiting at the reverse proxy, API gateway, or edge service.

Rate limiting restricts the number of requests a client can make within a defined period. Requests exceeding the configured allowance should receive **HTTP 429 Too Many Requests**.

Thresholds should reflect normal traffic and application capacity. Allow reasonable bursts and use stricter limits for expensive operations.

For anonymous traffic, limits can use the client IP address. For authenticated operations, additional limits should use a verified account or API identity.

### Supporting Controls

- Temporarily block verified abusive sources when immediate containment is needed.
- Configure connection limits, request timeouts, and request size limits.
- Cache suitable public responses to reduce application workload.
- Consider upstream DoS protection if traffic could overwhelm the server or network.
- Avoid relying on User-Agent blocking because clients can easily change this value.

## 4. Justification for the Proposed Solution

Rate limiting directly addresses excessive request frequency. It reduces the amount of repeated work reaching the application while allowing legitimate traffic within the configured allowance.

OWASP recommends rate limiting to reduce unrestricted resource consumption and advises tuning limits to business needs.

Rate limiting is more sustainable than blocking a single IP because an abusive client can change its address. However, it is one layer of protection and cannot prevent every type of DoS attack.

Careful tuning is necessary because multiple legitimate users may share one public IP address.

## 5. Steps for Implementation

1. **Preserve the evidence**
   - Keep an unchanged copy of `logs.txt`.
   - Record its SHA-256 hash.
   - Restrict access to the original source IP information.

2. **Validate the analysis**
   - Confirm that the scripts match the actual log format.
   - Examine timestamps to establish the activity period.
   - Count Source A's requests by endpoint and response status.

3. **Establish normal traffic levels**
   - Measure typical request rates and legitimate traffic bursts.
   - Review response times and server capacity.
   - Choose initial limits based on these measurements.

4. **Configure rate limiting**
   - Apply limits at the application's entry point.
   - Configure HTTP 429 for rejected requests.
   - When using a proxy, trust client IP headers only from approved proxies.

5. **Test the configuration**
   - Use a controlled test environment.
   - Verify that normal requests continue to succeed.
   - Confirm that excessive requests receive HTTP 429.
   - Check that shared-network users and essential application functions remain usable.

6. **Deploy and review**
   - Back up the existing configuration.
   - Validate the new configuration before deployment.
   - Monitor rejected requests and legitimate user errors.
   - Adjust thresholds or roll back if necessary.

## 6. Post Implementation Monitoring

Centralize access logs and monitor:

- Requests per second or minute by source and endpoint.
- HTTP 429 responses and rate-limit decisions.
- HTTP 5xx errors.
- Application response times.
- CPU, memory, network usage, and active connections.
- Application availability through health checks.

A centralized log platform, such as Elastic, can support investigation. Infrastructure monitoring tools, such as Prometheus and Grafana, can help correlate request spikes with server health.

Configure alerts for sustained deviations from normal activity. Review false positives and update limits as application usage changes.

Success should be measured by excessive requests being limited while legitimate users retain acceptable response times and availability.

## 7. Conclusion

Source A generated 5,000 requests, and its most common User-Agent was `python-requests/2.31.0`. The root endpoint `/` received the highest number of requests across the log.

These findings suggest automated activity requiring investigation. They do not establish malicious intent, a successful DoS attack, or service disruption.

Rate limiting is the primary recommended mitigation, supported by resource controls, centralized logging, and ongoing monitoring.

## References

- [OWASP API4 Unrestricted Resource Consumption](https://owasp.org/API-Security/editions/2023/en/0xa4-unrestricted-resource-consumption/)
- [NGINX Request Rate Limiting](https://nginx.org/en/docs/http/ngx_http_limit_req_module.html)
