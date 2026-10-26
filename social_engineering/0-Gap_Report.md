# NovaTech Email Security Gap Analysis

## Overview

The supplied evidence shows that Campaign A triggered authentication and spam warnings, while Campaign B passed authentication and prompted users to submit data.

## Campaign Comparison

| Check | Campaign A: VPN Update | Campaign B: Pizza Party |
|---|---|---|
| SPF | Softfail: sending IP not authorized | Pass: sending IP authorized |
| DKIM | Fail: signature verification failed | Pass: signature verified |
| DMARC | Fail; policy requests rejection | Pass; policy is monitoring-only |
| Spam score | 8.5, above the 5.0 threshold | 0.1, below the threshold |
| Spam classification | Flagged as spam | Not flagged as spam |

Campaign A's authentication failures and high spam score support the scenario's reported blocking. However, the headers alone do not confirm final rejection; mail-server logs are needed.

Campaign B authenticated successfully for `trusted-vendor-news.com`. This confirms domain authentication, not message safety or a legitimate business relationship. Its `p=none` policy did not cause the pass. Changing it to `reject` would not block an already passing message through DMARC alone.

## Engagement and Risk

The CSV contains four HR recipients: three submitted data and one clicked the link. Therefore, the observed HR submission rate is **75%**, not the scenario's stated 40%.

Across all six recipients, three submitted data (**50%**). One IT recipient reported the email.

Submitted data indicates form interaction; it does not establish valid credential theft or account compromise.

## Recommendations

- Maintain correct SPF/DKIM configuration and enforce DMARC for NovaTech-controlled domains.
- Inspect links, attachments, and sender impersonation even when authentication passes.
- Train employees to verify unexpected requests and report suspicious messages.
- Use phishing-resistant MFA to reduce credential-phishing impact.
- Review delivery logs and reconcile the conflicting campaign percentages.

## Conclusion

Campaign A demonstrates authentication-based detection. Campaign B exposes the remaining risk: authenticated email can still contain a deceptive request.
