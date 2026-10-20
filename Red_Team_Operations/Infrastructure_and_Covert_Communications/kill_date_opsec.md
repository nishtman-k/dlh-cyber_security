# Task 3 — O2: Kill Date & Jitter

## Kill Date
A kill date defines when a red-team agent must stop operating.

Purpose:
- Limit an engagement's operational lifetime.
- Prevent agents from remaining active after authorization expires.
- Reduce unnecessary exposure.

Example planned expiration: 2026-10-31 23:59 UTC.

## Sleep and Jitter
Sleep controls the interval between agent callbacks.
Jitter introduces randomness into that interval.

Example:
- Base sleep: 60 seconds
- Jitter: 20%
- Illustrative callback range: 48–72 seconds

## OPSEC Considerations
- Respect the authorized engagement window.
- Avoid unnecessarily frequent network connections.
- Stop operations at the agreed expiration date.
- Document configuration and verification results.

## Verification
The example values above illustrate the concepts.
Actual agent configuration and callback verification have
not yet been recorded in this document.
