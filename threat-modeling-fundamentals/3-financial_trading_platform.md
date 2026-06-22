Threat Modeling a Financial Trading Platform:

1. Most critical CIA component and the performance conflict:
The most critical component is Integrity.
In a trading platform, the worst case is data being changed in a wrong way. If trades, prices, or account balances are modified, users lose money and the platform breaks trust and laws. A data leak is bad, and downtime is bad, but wrong or changed financial data causes direct loss and is hard to fix. Regulators like SEC and FINRA also require accurate and trustworthy records.
Availability is also very important here because of the 99.99 percent uptime need, but integrity comes first because a fast system that gives wrong results is useless and dangerous.

Can security conflict with performance?
Yes. Security controls like encryption, multi-factor checks, and logging add small delays. The system needs trades under 100ms, so heavy security can slow it down. The solution is to balance both, using strong but efficient controls so the platform stays both safe and fast.

2. Threat model for "automated trading rules"

Top three risks and mitigations:
- Risk 1: Logic flaws in the rules. A bug or bad rule logic can cause many wrong trades automatically and very fast.

Mitigation: Test rules carefully, add limits on trade size and frequency, and use a safety check before executing.


- Risk 2: Race conditions. Two actions happen at the same time and cause double trades or wrong balances.

Mitigation: Use proper locking and atomic transactions so each action completes fully before the next one starts.


- Risk 3: Unauthorized rule modification. An attacker changes a user's trading rules to move money or make harmful trades.

Mitigation: Require authentication and re-verification before any rule change, and log every change with audit trails.



3. Defense-in-depth after an account is compromised
If an attacker takes over a user account, these layers limit the damage:

- Multi-factor authentication (MFA): Even with the password, the attacker is blocked at sensitive actions like fund transfers because they need a second factor.
- Transaction limits: Set maximum amounts and limits per day. This caps how much an attacker can move even if they get in.
- Anomaly detection: Watch for strange behavior, like sudden large trades or logins from a new location, and flag or block them.
- Session management: Use short session timeouts and detect multiple logins, so a stolen session does not stay active for long.
- Audit trails: Log all actions with time and user. This helps detect the attack, stop it, and recover money or undo damage.
