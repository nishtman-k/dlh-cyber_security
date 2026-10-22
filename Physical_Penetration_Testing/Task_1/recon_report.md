# Reconnaissance Summary Report

**Meridian Technologies — MT-RECON-001**  
**Academic simulation, version 1.0, 22 October 2026**

This report contains fictional modelling only. The supplied guard schedule is scenario evidence; invented observations are labelled SIM. No actual building, employee or security system was surveyed. The report is arranged as six planned print pages; actual pagination depends on the Markdown renderer, font and margins.

## 1. Executive Summary

The fictional campus assessment identifies an explicitly unstaffed lobby during the guard's 12:00–12:30 lunch, a simulated individual-badge enforcement failure at the employee entrance, and an unverified delivery-verification weakness requiring follow-up. The first follows the supplied scenario; the latter two are clearly invented observation records used for the exercise. Priorities are continuity of reception coverage, safe individual access verification, and consistent delivery/escort checks. Camera operation, alarms, Annex procedures and after-hours coverage remain unknown. No access attempt, live observation or technical exploitation occurred, and no real-world vulnerability is claimed.

## 2. Facility Overview

The supplied scenario describes a fictional mid-size software company with a Main Building, Annex, badge-gated employee lot and open visitor lot. For this example only, the Main Building has two floors, the Annex one floor, the campus is placed generically in Luxembourg City, and staffing/office hours are assumed to be 100 employees and 08:00–18:00. No real address exists. Guard duty is separately supplied as 07:00–18:00.

The map and five doors are defined in entry_points.md. EP-1 is the visitor entrance, EP-2 the employee entrance, EP-3 the loading entrance, EP-4 the service door and EP-5 the Annex entrance. These door functions and their controls are modelling assumptions, not facts provided with a floor plan.

### Method and provenance

G-01–G-03 identify supplied campus requirements and guard schedule. A-01–A-03 identify layout, staffing and camera assumptions. SIM-01–SIM-05 are expressly fictional observations. A role/source plan was developed for OSINT; no public-building imagery or real-employee research was performed. A negative observation or absent image is never treated as proof a control does not exist.

<div style="break-after: page; page-break-after: always;"></div>

## 3. Entry Point Analysis

| EP-ID | Location / type | Access control | Assumed cameras | Simulated traffic | Tailgate risk / overall risk | Guard presence / evidence |
| --- | --- | --- | --- | --- | --- | --- |
| EP-1 | Main south reception; visitor entrance | Visitor sign-in and staffed reception in the model; interior door permissions unknown | CAM-1 covers approach, recording/response unknown | High at arrival; moderate otherwise (assumed, no measured counts) | Medium / **High at lunch**, conditional on access beyond lobby | Lobby unmanned 12:00–12:30: G-03, SIM-01 |
| EP-2 | Main east employee door from badge-gated lot | Individual employee badge required in model | CAM-2, assumed door view | High 08:00–09:00 (assumed) | High / **High**, based on simulated held-door event | No fixed door guard assumed; A-02, SIM-02 |
| EP-3 | Main north loading/delivery entrance | Delivery acceptance and staff release in model | CAM-3, assumed loading view | Low and intermittent (assumed) | Medium / **Medium**, requires process validation | Guard response/escort unknown; A-02, SIM-03 |
| EP-4 | Main west service door | Normally locked; maintenance key control assumed | CAM-4, assumed doorway view | Low (assumed) | Low / **Low on current model**, limited evidence | No fixed post assumed; no simulated failure observed |
| EP-5 | Annex south entrance | Employee badge required in model | CAM-5, assumed entrance view | Low–moderate (assumed) | Medium / **Uncertain** until Annex policy/coverage confirmed | Guard visits not specified; A-02/A-03 |

Risk ratings use only modelled controls and observations. High means priority follow-up with potential consequential access; Medium means a plausible concern; Low means no supported failure is currently modelled, not proven security. EP-5 remains uncertain because its procedures and coverage were not supplied.

### Traffic and scope limits

Arrival traffic at EP-2 and variable delivery traffic at EP-3 are invented modelling context, not measured counts. No one entered any door. Door visibility alone cannot prove permitted access, alarm behavior, interior reach or access to information. The employee parking gate P-E is distinct from the five building entry points.

## 4. Security Controls

- **Access control:** employee badges at EP-2/EP-5 and visitor/delivery release procedures are assumed. Reader vendor, authentication strength, revocation and anti-passback are unknown.
- **CCTV:** five modelled cameras have approximate areas only. Recording, IR, resolution, timestamps, retention, operator attention and response are unknown. A possible courtyard occlusion is not a confirmed blind route.
- **Guards:** the schedule supplies duty, patrol starts, duration, lunch and departure. Patrol route and any backup/remote monitoring are unknown. Only the lunch interval explicitly states the lobby is unmanned.
- **Alarms:** door-held-open, forced-door and intrusion alarms were not specified or tested. Do not assert their absence.

Recommended validation is an authorized facilities review, not a bypass attempt. Confirm actual access policy, camera overlap and alarm/guard response before assigning final real-world risk.

<div style="break-after: page; page-break-after: always;"></div>

## 5. Identified Vulnerabilities

### F-01 — Lunch-time lobby guard coverage gap

**Evidence:** G-03 explicitly states the lobby is unmanned from 12:00 to 12:30. SIM-01 applies that statement to modelled EP-1. **Likelihood: Possible. Impact: Moderate, conditional. Priority: High for continuity review.** An unstaffed guard position may weaken challenge/verification, but reception staff, locked inner doors or remote monitoring may compensate. No unauthorized access was demonstrated.

**Recommendation:** provide clear break-relief ownership or maintain a controlled visitor boundary with a reliable response channel. **Retest:** an approved test visitor is either verified/escorted or held outside restricted space during the break.

### F-02 — Individual badge presentation not consistently enforced

**Evidence:** SIM-02 invents an 08:10–08:20 event in which three followers pass the modelled EP-2 door without separate credential presentation. This is a scenario observation, not a fact about a real door. **Likelihood: Likely within this simulation. Impact: High if the door opens into restricted offices. Priority: High.** Badge-gated parking does not necessarily establish each occupant's right to enter the building.

**Recommendation:** reinforce safe one-person/one-credential behavior, visitor escort and an accessible challenge/reporting process; evaluate suitable entrance controls while preserving egress. **Retest:** the approved multi-person test produces individual access decisions and appropriate staff response.

### F-03 — Delivery verification is not evidenced

**Evidence:** SIM-03 invents label-based delivery acceptance at EP-3 with no independent check visible. A private or back-office verification could still exist, so this is a **provisional process finding**. **Likelihood: Possible. Impact: Moderate if it permits unescorted access. Priority: Medium pending validation.**

**Recommendation:** confirm a delivery appointment/contact through an independent trusted channel, assign escort responsibility and restrict release to the delivery zone. **Retest:** an approved test delivery is verified or held without access to internal offices.

### Unresolved lead — camera overlap around the Annex

SIM-05 suggests partial modelled occlusion of a courtyard route from CAM-2, but CAM-5 or other cameras may cover it. Record as a visibility question, not a fourth confirmed vulnerability. Validate image quality, overlap and response with the facility owner.

<div style="break-after: page; page-break-after: always;"></div>

## 6. Recommended Attack Vectors

These are ranked **controlled validation scenarios for a later separately authorized test**, not completed intrusions or permission to exploit. Each ends at a predefined harmless marker or denied-access event. No force, lock bypass, real credential collection or interference with staff is proposed.

1. **Primary — EP-1 visitor-control continuity:** evaluate whether the approved visitor process remains effective during the supplied 12:00–12:30 guard break. The key question is compensating control effectiveness, not whether the front door can be opened.
2. **Secondary — EP-2 individual access:** evaluate staff response and individual badge enforcement during the simulated group-arrival interval. Stop if challenged; no person is pushed, obstructed or pressured.
3. **Tertiary — EP-3 delivery validation:** evaluate whether the nominated delivery contact and escort are independently verified. Confirm actual delivery scheduling first; no courier identity or hazardous goods are used without explicit approval.

### Three candidate windows

| Candidate window | Entry point | Rationale within the fictional model | Counter-detection / limiting factors |
| --- | --- | --- | --- |
| 12:00–12:30 | EP-1 | Supplied guard lunch creates an explicit unstaffed lobby interval; assess continuity of visitor control | Reception staff, CCTV, locked interior doors or remote monitoring may still prevent/record access; response staffing is not fully known |
| 08:10–08:20 | EP-2 | SIM-02 models group arrivals and door holding without individual badge checks | Employees are present and can challenge an unfamiliar person; camera and badge logs may exist; timing is invented, not supplied |
| 09:30–09:45 | EP-3 | Exterior patrol is scheduled while a delivery-process review could test staff verification and escort consistency | A patrolling guard may approach the loading area; guard absence from the lobby is not established; delivery timing would need confirmation |

These are **candidate times for later authorized validation**, not permission to enter, bypass controls or evade guards. A patrol interval is not automatically a guard-free interval. Do not infer vulnerability after 18:00 merely because the scheduled guard leaves; alarms, other personnel and remote monitoring are unknown.

## 7. Risk Assessment

| Vector | Likelihood | Conditional impact | Basis and uncertainty |
| --- | --- | --- | --- |
| EP-1 visitor control | Possible | Moderate | Guard gap supplied; interior access and compensating controls unknown |
| EP-2 individual credential enforcement | Likely in the invented model | High | SIM-02 supplies repeated follower passage; actual interior reach untested |
| EP-3 delivery verification | Possible | Moderate | SIM-03 suggests a check gap; non-visible verification remains possible |

This is qualitative prioritization, not a validated numeric score. Higher impact requires additional access beyond the observed/modelled boundary. None of the vectors establishes theft, system access or compromise of the company.

<div style="break-after: page; page-break-after: always;"></div>

## 8. Counter-Detection Incidents

**SIM-04, 10:05, OP-1:** a fictional guard looks toward the observation point twice. This could be ordinary awareness; it does not prove that the exercise was detected. Following the task's response rule, the observer stops immediately, notifies the exercise handler and moves normally to pre-approved OP-2. OP-1 is not revisited during the same session. No actual guard, vehicle or employee was observed, and no real confrontation occurred.

If approached during any later real exercise, stop and cooperate. Do not relocate as a means of evading authorities or continue covert observation after a safety/legal challenge. A persistent vehicle or repeated looks are indicators to document, not grounds to identify a person as hostile.

### Behavior and role selection

SIM-02 models group arrivals; SIM-03 models delivery processing. Dress, smoking area and arrival volume are assumptions. No actual worker was tracked or profiled. The hypothetical assessment list uses five invented roles: receptionist, facilities coordinator, IT support lead, delivery coordinator and Annex office coordinator. Selection tests organizational verification and escort controls rather than personal weaknesses. See behavior_summary.md for names, rationale and limits.

### Confidence, coverage and next steps

The guard schedule is the strongest scenario evidence. Camera health, field-of-view overlap, alarm operation, internal doors, delivery checks, actual traffic volume and security coverage after 18:00 need confirmation. A single supplied schedule cannot establish a repeated predictable patrol pattern.

Next steps are to validate these assumptions with the instructor or authorized client, confirm legal scope and permissions, then select a narrowly bounded test with an agreed stop condition. Track whether each lead is confirmed, refuted or left unresolved; do not turn every unknown into a finding.

### Source discipline

The five OSINT source groups are Maps/Street View, official company publications, public professional/job information, official business/property records, and passive domain/registration information. No Meridian-specific result is claimed. Vendor references in job postings, reader-like shapes in imagery, or domain ownership are leads requiring corroboration.

The optional public-building mapping practice was not carried out. It must remain separate from this fictional campus analysis and cannot be claimed as completed OSINT in a report or submission. If an instructor requires it, add approved imagery, URLs, dates and actual visible-feature counts without live observation of private premises.

<div style="break-after: page; page-break-after: always;"></div>

## 9. Appendices

### Appendix A — fictional campus map

```text
                            NORTH ↑
+---------------------------------------------------------------------+
| Loading/service area                                                |
|                         EP-3 ★CAM-3      Employee lot: BADGE GATE P-E |
|                 +--------------------------+           |             |
| EP-4 ★CAM-4 --->| MAIN                     |           |             |
|  west service  |                     EP-2 |<----------+             |
|                 |                   ★CAM-2 | east employee door      |
|                 |                reception |                         |
|                 +-------------EP-1---------+                         |
|                              ★CAM-1                                  |
| Smoking area S-A                  courtyard     +-----------------+  |
| Visitor lot: OPEN                               | ANNEX           |  |
|                                                 +--EP-5 ★CAM-5----+  |
+------------------------ Public frontage -----------------------------+
| ●OP-1: fictional public cafe      ●OP-2: fictional public path        |
+---------------------------------------------------------------------+
Legend: EP = Entry Point; ★ = assumed Camera; ● = Observation Point
P-E = employee parking gate (not an additional EP building door)
Not to scale. All geometry and device positions are fictional.
```

### Appendix B — supplied patrol schedule

| Event | Time / duration |
| --- | --- |
| Guard arrival / departure | 07:00 / 18:00 |
| Exterior patrol 1 | 07:30–07:45 |
| Exterior patrol 2 | 09:30–09:45 |
| Exterior patrol 3 | 11:30–11:45 |
| Lunch; lobby unmanned | 12:00–12:30 |
| Exterior patrol 4 | 13:30–13:45 |
| Exterior patrol 5 | 15:30–15:45 |

### Appendix C — supporting files and sources

- **entry_points.md:** complete five-door inventory, risk limits and G/A/SIM register.
- **camera_map.md:** five assumed cameras, coverage limits, unknown IR capability and validation needs.
- **patrol_timeline.md:** full-day timeline, arithmetic and three candidate windows.
- **behavior_summary.md:** behaviour assumptions, five fictional role profiles and incident SIM-04.
- **osint_summary.md:** five source groups, fictional profile, evidence register and optional public-building practice checklist.

**Primary source:** the assignment text supplied by the student on 22 October 2026. No external source has been used to substantiate the invented campus, employees or simulated observations. The linked academy concept was not required to establish these scenario facts; no claim is made that its content was retrieved or reviewed.

**Print note:** five explicit page breaks define six planned pages. Font size, wrapping and margins may create additional pages in a particular renderer; the Markdown file is not a verified six-page PDF. Use an A4/Letter preview and adjust formatting before submission if a strict 4–8 rendered-page limit is enforced.
