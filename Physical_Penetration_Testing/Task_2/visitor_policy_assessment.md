# Visitor Policy Assessment

**Assessment:** SDS-AC-001 | **Version:** 1.0 | **Date:** 22 October 2026

**FICTIONAL ACADEMIC EXERCISE — NO HARDWARE OR LIVE TESTING.** Sentinel Defense Systems is the assignment's fictional defense contractor. No real contractor, employee, credential, database, door or biometric system was accessed. `G-` denotes supplied descriptions, `A-` explicit assumptions and `SIM-` invented tabletop events. Procedures below describe only an owner-controlled training setup; they are not test results or permission to act on real facilities.

## 1. Policy baseline and evidence limits

The assignment requests a visitor-policy assessment but does not supply an actual Sentinel policy or test results. The following baseline and weakness cases are **explicit modelling assumptions**, not observed failures. They define what a controller should evaluate during the approved training scenario.

## 2. Visitor information and registration

The model requires visitor name, organization, purpose, host, appointment time, approved zones, arrival/departure and a way to verify the visitor and host through trusted channels. Inspect genuine ID under an approved process; do not automatically copy identity documents or retain unnecessary identifiers. A paper or electronic log can work if it is accurate, access-controlled and reconciled. Walk-ins wait in a public visitor area until approved.

Record appropriate notice, retention, correction and access arrangements for any real personal data under the applicable jurisdiction. No actual visitor identity data is collected in this exercise.

## 3. Badge, access and escort policy

| Dimension | Assumed secure policy | What evidence would demonstrate enforcement? |
| --- | --- | --- |
| Badge identification | Visitor badge visibly distinct; photograph where justified and lawfully handled | Issuance record and approved badge sample; no conclusion from colour alone |
| Expiry | Badge expires at appointment/session end and is revoked on checkout | Test controller decisions before/after expiry and revocation |
| Door permissions | Only approved visitor/meeting areas; no employee, defense-program, lab or server-room rights | Configured door list and allowed/denied test-credential events |
| Host verification | Reception calls the known host through its own directory | Callback/approval record, not merely a printed delivery contact |
| Escort | Named escort accepts, stays with visitor and formally hands over if necessary | Controller observation of the complete journey and return |
| Monitoring | Cameras/alarms support, but do not replace, staff response | Authorized image/alert review plus a documented responder action |
| No-go zones | Clearly defined restricted boundary and escalation procedure | Training map, posted policy and denied test-door event |
| Checkout | Badge collected/revoked, log closed and host confirms departure | Reconciled issue/return record and disabled credential |

**Whether escort is actually enforced: UNKNOWN / NOT TESTED.** No real policy review or live journey occurred. An expected policy is not evidence of implementation.

## 4. Hypothetical weaknesses, bounded validation and remedies

The 'exploitation' element is represented below as a controlled validation, not unrestricted movement or actual access claims.

| Case | Hypothetical weakness | How an adversary could benefit / approved exercise validation | Impact and confidence | Recommendation |
| --- | --- | --- | --- | --- |
| VP-01 | Host is accepted solely from a visitor's statement or supplied phone number | Unverified visitors might be approved. In role-play, the controller checks whether the receptionist uses an independent directory; no entry without actual test authorization | Potential unauthorized visitor admission; **hypothesis only** | Independent callback and explicit appointment approval; hold visitors in public area |
| VP-02 | Badge expiry is printed but not technically enforced | A retained badge might remain usable. Review an expired/revoked **lab** credential at an isolated test controller; never retain/use a real badge | Potential continued access; **hypothesis only** | Enforce expiry/revocation in the access system and reconcile checkout |
| VP-03 | Visitor badge inherits employee door permissions | A visitor might reach unnecessary internal zones. Compare approved access policy with lab door allow/deny events; no attempt at operational restricted doors | Potential excessive privilege; **hypothesis only** | Separate least-privilege visitor profiles and periodic access review |
| VP-04 | Escort responsibility becomes unclear during handover | Visitor could become unescorted. Controller stages a handover; participant waits at the approved stop line if escort is absent | Potential loss of visitor accountability; **hypothesis only** | Named escort transfer and no departure until another escort accepts |
| VP-05 | Log/badge issue and return records are not reconciled | Missing badges or overdue visitors might not trigger a response. Use a synthetic record and check whether staff identify the discrepancy | Potential persistence of unexplained access; **hypothesis only** | Badge inventory, outstanding-visitor checks, automatic expiry and defined responder |

No risk rating is presented as measured. Prioritize according to actual zone sensitivity, verification results and compensating controls after the model is validated.

## 5. Report and next steps

Record each case as planned / executed / denied / inconclusive, with time, control expectation, actual controller record, access boundary, supporting evidence and corrective owner. Do not claim camera presence proves intervention or that a visitor reached a sensitive room because an outer door opened.

Next steps: obtain an authorized real policy if the instructor adds one; reconcile assumptions; perform the approved tabletop role-play; document outcomes; retest remedies with dedicated lab identities. Current submission is a theory-based assessment plan, not an assertion that Sentinel's security failed.
