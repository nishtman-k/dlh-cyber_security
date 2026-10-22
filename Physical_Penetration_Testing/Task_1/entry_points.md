# Entry Points and Campus Map

**Assessment:** MT-RECON-001 | **Version:** 1.0 | **Prepared:** 22 October 2026

**FICTIONAL ACADEMIC EXERCISE.** No real facility, employee, security system or patrol was observed. `G-` identifies facts supplied in the assignment; `A-` identifies modelling assumptions; `SIM-` identifies invented observation records used to demonstrate analysis. A hypothetical weakness is not a verified weakness of a real building. All times are illustrative local scenario time.

## Facility model

Meridian Technologies is a fictional mid-size software company. The narrative assumes 100 personnel and 08:00–18:00 office hours in Luxembourg City. Neither staffing nor business hours were supplied; guard duty is separately specified as 07:00–18:00. The Main Building and Annex share a campus; the employee lot is badge-gated and visitor parking is open.

## Annotated site plan

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

Observation points are invented lawful public vantage points for the model, not verified places or advice to conceal surveillance. OP-1 has a plausible public-cafe use; OP-2 is a public path. Do not use a business premises, parked vehicle, roof or private boundary without permission. No climbing, entry attempts or photography was performed.

The task asks about roof access, waste and adjacent buildings: these are **unknown in the supplied scenario**, not assumed usable routes. Mark them for later authorized validation rather than inventing access.

## Entry-point inventory

| EP-ID | Location / type | Access control | Assumed cameras | Simulated traffic | Tailgate risk / overall risk | Guard presence / evidence |
| --- | --- | --- | --- | --- | --- | --- |
| EP-1 | Main south reception; visitor entrance | Visitor sign-in and staffed reception in the model; interior door permissions unknown | CAM-1 covers approach, recording/response unknown | High at arrival; moderate otherwise (assumed, no measured counts) | Medium / **High at lunch**, conditional on access beyond lobby | Lobby unmanned 12:00–12:30: G-03, SIM-01 |
| EP-2 | Main east employee door from badge-gated lot | Individual employee badge required in model | CAM-2, assumed door view | High 08:00–09:00 (assumed) | High / **High**, based on simulated held-door event | No fixed door guard assumed; A-02, SIM-02 |
| EP-3 | Main north loading/delivery entrance | Delivery acceptance and staff release in model | CAM-3, assumed loading view | Low and intermittent (assumed) | Medium / **Medium**, requires process validation | Guard response/escort unknown; A-02, SIM-03 |
| EP-4 | Main west service door | Normally locked; maintenance key control assumed | CAM-4, assumed doorway view | Low (assumed) | Low / **Low on current model**, limited evidence | No fixed post assumed; no simulated failure observed |
| EP-5 | Annex south entrance | Employee badge required in model | CAM-5, assumed entrance view | Low–moderate (assumed) | Medium / **Uncertain** until Annex policy/coverage confirmed | Guard visits not specified; A-02/A-03 |

## Risk scale and limits

High = stronger evidence of a consequential control gap in this model; Medium = plausible weakness needing validation; Low = no supported failure currently modelled; Uncertain = insufficient evidence. Ratings prioritize follow-up, not a claim of successful intrusion.

For a real survey, record actual door IDs, accessibility, closer/latch condition, sign-in/escort requirements, credential presentation, alarms and camera response from permitted locations. A visible door or reader does not establish a working access policy. Unknown or unviewed doors mean the count is incomplete; this model has five doors by assignment, not an actual census.

## Evidence and assumption register

| ID | Basis |
| --- | --- |
| G-01 | Assignment: fictional Meridian Technologies campus has a Main Building and Annex; EP-1–EP-5, badge-gated employee parking and an open visitor lot must be mapped. |
| G-02 | Assignment: guard arrives 07:00; exterior patrols begin 07:30, 09:30, 11:30, 13:30, 15:30; each lasts 15 minutes. |
| G-03 | Assignment: guard lunch 12:00–12:30; lobby explicitly unmanned during lunch; guard leaves 18:00. |
| A-01 | Model: Luxembourg City jurisdiction/location for narrative only; no real address; 100 employees, office hours 08:00–18:00. These were not supplied by the assignment. |
| A-02 | Model: Main Building has two floors; Annex one floor; positions, five door functions and access methods are assumed. |
| A-03 | Model: CAM-1–CAM-5 are assumed camera positions, not provided or verified camera inventory. IR capability, image quality, recording and remote monitoring are unknown. |
| SIM-01 | Invented scenario record: no replacement lobby guard between 12:00 and 12:30; this applies the supplied lunch fact to assumed EP-1. |
| SIM-02 | Invented scenario record, 08:10–08:20: employees at EP-2 hold the badge door open for three following people without an individual credential presentation. |
| SIM-03 | Invented scenario record, 10:20: a delivery is accepted at EP-3 based on a visible label; no independent verification is observed in the model. Back-office checks remain unknown. |
| SIM-04 | Invented counter-detection record, 10:05: guard looks toward OP-1 twice; observation stops and the team relocates to OP-2. No confrontation or actual detection is claimed. |
| SIM-05 | Invented scenario record: courtyard walking route is partly hidden by the Annex wall from the assumed CAM-2 viewpoint. Other camera coverage is unknown. |

The supplied data establishes only the guard schedule and required campus elements. Other operational details are assumptions or deliberately simulated observations. A real assessment would need authorized observation, records and independent validation.
