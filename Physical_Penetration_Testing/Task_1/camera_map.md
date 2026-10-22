# Camera Map and Surveillance Limits

**Assessment:** MT-RECON-001 | **Version:** 1.0 | **Prepared:** 22 October 2026

**FICTIONAL ACADEMIC EXERCISE.** No real facility, employee, security system or patrol was observed. `G-` identifies facts supplied in the assignment; `A-` identifies modelling assumptions; `SIM-` identifies invented observation records used to demonstrate analysis. A hypothetical weakness is not a verified weakness of a real building. All times are illustrative local scenario time.

## Camera-position map

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

## Camera inventory

| CAM-ID | Assumed location | Assumed type | Modelled coverage | Blind spots / limits | IR capability |
| --- | --- | --- | --- | --- | --- |
| CAM-1 | Above Main reception / EP-1 | Fixed camera | Visitor approach and reception door | Interior corridors and occupant recognition not established | Unknown |
| CAM-2 | Main east facade / EP-2 | Fixed camera | Employee-door approach | Annex wall may occlude part of courtyard in SIM-05; other views unknown | Unknown |
| CAM-3 | Loading frontage / EP-3 | Fixed camera | Loading approach | Vehicles may obstruct views as a hypothesis; no actual obstruction measured | Unknown |
| CAM-4 | Main west service side / EP-4 | Fixed camera | Service doorway | Extent beyond the doorway unknown | Unknown |
| CAM-5 | Annex above EP-5 | Fixed camera | Annex entrance | Annex interior and inter-building route not established | Unknown |

## Assessment limits

A visible device is not proof of recording, good image quality, correct retention, live monitoring or response. Camera absence from a Street View image is not proof that no camera exists. The model does not establish actual fields of view, blind-zone dimensions, IR capability, recorder brand, retention settings or camera health.

SIM-05 identifies a possible modelled courtyard occlusion; it is **not** a verified unmonitored route. Check overlap from CAM-5 or other devices, and authorization for any validation, before asserting a blind spot.

Recommended validation: facilities staff should review camera inventory, timestamp accuracy, day/night image quality, recording retention and alert response using authorized test activity. A later test must preserve privacy and emergency egress. No camera tampering, sensor defeat or disabling is in scope.
