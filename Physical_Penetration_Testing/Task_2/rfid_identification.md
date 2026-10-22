# RFID and Access-Control Identification

**Assessment:** SDS-AC-001 | **Version:** 1.0 | **Date:** 22 October 2026

**FICTIONAL ACADEMIC EXERCISE — NO HARDWARE OR LIVE TESTING.** Sentinel Defense Systems is the assignment's fictional defense contractor. No real contractor, employee, credential, database, door or biometric system was accessed. `G-` denotes supplied descriptions, `A-` explicit assumptions and `SIM-` invented tabletop events. Procedures below describe only an owner-controlled training setup; they are not test results or permission to act on real facilities.

## Supplied observations and qualified identification

| Reader | Supplied description | Likely technology / frequency | Additional factor / protocol | Cloning difficulty and confidence |
| --- | --- | --- | --- | --- |
| R-1 | Black rectangular reader, waist height, one LED, no keypad; card held 2–3 inches away | Legacy LF proximity, potentially HID Prox at 125 kHz, is a plausible hypothesis. HF or multi-technology readers cannot be excluded | No visible keypad; no protocol positively identified | If an identifier-only legacy HID Prox credential is confirmed, compatible duplication/emulation may be feasible. Actual difficulty **unknown**. Low confidence from appearance/range alone |
| R-2 | Gray reader, illuminated logo, direct card tap and a ten-digit keypad | HF smart card at 13.56 MHz is plausible, but LF/multi-technology devices remain possible | Keypad could accept a PIN. Ten digits on a keypad do not imply a ten-digit PIN or that PIN is required. Verify policy and use | Unknown until card family, authentication and reader policy are identified. Card plus enforced PIN may add a knowledge factor; neither the keypad nor frequency establishes resistance |
| R-3 | Slim white wall unit, phone held near it, NFC symbol | NFC mobile credential at 13.56 MHz is strongly suggested, not confirmed | Potential ISO/IEC 14443-based card emulation, possibly ISO-DEP/application exchange. Product-specific; BLE or multi-technology operation may coexist | Copying an identifier alone generally cannot reproduce cryptographic mobile authentication. Exact protection, device binding and clone resistance are **unknown** |

G-01 is the assignment's three descriptions. The table is inference from those descriptions, not a radio scan, manufacturer identification or successful clone. Do not turn the three examples into a claim that actual Sentinel badges use all three technologies.

## Identification workflow — theoretical

1. Obtain the model number, credential family and authorized configuration from the owner or manufacturer; do not open/tamper with a live reader.
2. Separate **frequency**, **RF/card protocol**, **credential application**, **key management** and **reader-to-controller transport**.
3. For a permitted lab card, identify its actual family with appropriate equipment and record tool/firmware versions. No hardware was used here.
4. Confirm whether decisions use a static identifier or authenticated application data, and whether a PIN is enforced for that door.
5. Record allowed, denied, expired and revoked test-credential behavior at an isolated test controller. A live reader is not implied by the visual observations.

## Access-control layers

```text
Credential ⇄ Reader → Reader/controller link → Access panel → Lock
                                         ↕
                             Provisioning database / policy
```

The task's `Card > Reader (Wiegand) > Access Panel > Database` is a simplified logical flow. Wiegand normally refers to the **reader-to-panel link**, not the RF exchange with the card. A panel may make decisions locally using cached policy; every badge presentation need not query a central database.

## Recommended controls

- Prefer authenticated credential applications and managed keys to UID/identifier-only admission.
- Enforce additional factors where justified; confirm a keypad is actually used.
- Protect and monitor readers, wiring, panels, lock circuits and enrollment/database administration separately.
- Review OSDP Secure Channel for protected reader-to-panel communication; support for OSDP alone does not prove secure configuration.
- Test revocation, expiry, least privilege and offline-controller policy in a controlled setup.

References: [Proxmark3 project](https://github.com/RfidResearchGroup/proxmark3), [Flipper LF RFID documentation](https://docs.flipper.net/zero/rfid), [Flipper NFC documentation](https://docs.flipper.net/zero/nfc), [SIA OSDP](https://www.securityindustry.org/industry-standards/open-supervised-device-protocol/).
