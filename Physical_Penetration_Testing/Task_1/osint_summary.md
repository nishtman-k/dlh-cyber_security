# OSINT Summary

**Assessment:** MT-RECON-001 | **Version:** 1.0 | **Prepared:** 22 October 2026

**FICTIONAL ACADEMIC EXERCISE.** No real facility, employee, security system or patrol was observed. `G-` identifies facts supplied in the assignment; `A-` identifies modelling assumptions; `SIM-` identifies invented observation records used to demonstrate analysis. A hypothetical weakness is not a verified weakness of a real building. All times are illustrative local scenario time.

## Fictional target profile

| Field | Profile / confidence |
| --- | --- |
| Name / sector | Meridian Technologies; mid-size software company — supplied scenario |
| Campus | Main Building and Annex, employee badge-gated lot, open visitor lot — supplied modelling requirements |
| Location | Luxembourg City, no real street address — A-01 assumption |
| Personnel / hours | 100 staff; office hours 08:00–18:00 — A-01 assumption |
| Security duty | Guard 07:00–18:00, specified patrols and lunch — G-02/G-03 |
| Badge vendor / VMS / alarm platform | Unknown; no products inferred from appearance |
| Website / registered entity / employee roster | Not established; no similarly named real company researched |

## Five OSINT source groups and intended intelligence

| Source group | What it could establish | Validation / restraint |
| --- | --- | --- |
| 1. Google Maps satellite imagery and Street View | Visible footprint, parking, approaches, entrances, signage and dated exterior features | Record capture date, image date, viewpoint and limits. A visible feature does not prove current operation; do not publish real coverage gaps |
| 2. Official company website and public announcements | Office address, opening hours, reception instructions and organizational roles | Use only the actual verified entity; distinguish marketing text from confirmed access procedures |
| 3. Public professional profiles, job postings and employer-review pages | Role categories, support workflows and possible technology references | Treat vendor mentions and employee statements as leads; never infer current deployment from a single vacancy or review |
| 4. Applicable official company/property/permit records | Legal entity, owner/tenant distinction, approved building use and any lawfully published plans | Luxembourg equivalents replace US 'county records'. Do not access restricted building plans or treat ownership data as test consent |
| 5. Passive domain registration and public DNS information | Entity/domain linkage and public contact infrastructure | No scans, brute-force enumeration, login attempts or contact with staff. Website/registrant links do not establish physical access rights |

This is a source plan for a fictional target, not a claim that these sources returned Meridian-specific evidence. Preserve URLs, timestamps, search scope and uncertainty for any later real exercise. Avoid private accounts, personal geolocation histories or non-public records.

## Optional public-building imagery practice

The task's opening expressly permits theory-only completion and says remote map practice **may** use a public building. This package therefore uses the fictional campus map, not a live target. No Google Maps or Street View imagery was reviewed, and no real entrance/camera counts or photographs are claimed.

If your instructor requires the imagery component separately, use an instructor-approved public library or university building without on-site observation. Save permitted screenshots with imagery dates/URLs and record:

- Building footprint and visible parking areas.
- Number and type of entrances actually visible; unknown sides remain unknown.
- Adjacent public spaces and lawful observation points, without intruding on private property.
- Visible doors, reader-like devices, signs and camera-like devices, clearly marked uncertain where resolution is inadequate.
- Roof access, waste areas, employee gathering points and other features as unknown unless legitimately visible; no active probing.

Do not present the fictional Main Building/Annex geometry as imagery of the chosen public building. A separately completed practice appendix must distinguish real image observations from the scenario analysis. If local photography/observation rules are uncertain, stop and consult the instructor.

## Employee-role selection

See behavior_summary.md for five invented role profiles and their control-assessment rationale. No real employees were profiled, approached or selected.

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
