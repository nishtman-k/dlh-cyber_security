# Theoretical Credential Duplication and Wiegand Assessment

**Assessment:** SDS-AC-001 | **Version:** 1.0 | **Date:** 22 October 2026

**FICTIONAL ACADEMIC EXERCISE — NO HARDWARE OR LIVE TESTING.** Sentinel Defense Systems is the assignment's fictional defense contractor. No real contractor, employee, credential, database, door or biometric system was accessed. `G-` denotes supplied descriptions, `A-` explicit assumptions and `SIM-` invented tabletop events. Procedures below describe only an owner-controlled training setup; they are not test results or permission to act on real facilities.

## 1. Scope and terminology

No equipment is required or used for this submission. No badge data, keys, dumps, screenshots of live equipment or successful access results exist. A hypothetical demonstration would use an instructor-owned lab card and an isolated test reader/controller, never an operational defense-contractor badge.

**Read** means obtain supported information. **Dump** means save accessible card data. **Emulate** means have a device reproduce supported card behavior. **Clone** means reproduce enough of a credential on a compatible medium to satisfy the particular verifier. None of these automatically implies the others. Cloning an identifier does not copy cryptographic secrets or privileges stored only in a controller.

## 2. Proxmark3 and a confirmed 125 kHz HID Prox lab card

These are theoretical steps, not a transcript. Commands belong in the **Proxmark3 client console**, not an ordinary shell. Syntax varies by firmware/client; check local help and use matched versions.

1. Register the lab card, owner consent, permitted test controller and compatible blank tag. Back up lab records; never write to the original.
2. Confirm LF protocol first. Only use the HID command family once the sample is identified as compatible HID Prox; 125 kHz alone is insufficient.
3. Read the lab credential using the client's supported read command and save only approved lab data. The task says `lf hid read`; the current reviewed Iceman client uses **`lf hid reader`**.
4. Compare the interpreted format and raw identifier against the lab inventory. A misread or unsupported format is not a usable copy.
5. Consult the clone command help and select the correct supported writable **lab blank**; a random RFID card is not interchangeable. The example below shows a placeholder, not actual credential data.
6. Read the destination back, compare it with the source and test only against the isolated lab controller. Record both the card comparison and the controller decision. Stop if either is unsupported or ambiguous.
7. Clear/revoke test copies as agreed, inventory all cards and securely delete unneeded data.

```text
lf hid reader
lf hid clone -h
lf hid clone -r <LAB_RAW_ID>
```

The clone example requires the correct blank-tag support and options for the installed client. Do not paste angle-bracket placeholders into a shell. Current LF command behavior was checked against the [official client source](https://github.com/RfidResearchGroup/proxmark3/blob/master/client/src/cmdlfhid.c); no command was executed for this exercise.

## 3. Flipper Zero LF workflow — theoretical

1. Use the same owner-approved compatible LF lab credential.
2. In **125 kHz RFID → Read**, identify the supported card; keep its record under a lab-only name.
3. Save it, then select the saved record and **Emulate**. Menu details vary by firmware.
4. Present the device only to the lab reader and record whether that reader accepts the emulation. Emulation does not write a second physical card.
5. A physical duplicate additionally needs the **Write** function and a supported writable blank. Read-back and isolated-reader validation are still required.
6. Recover all training items and remove/revoke the saved test identity after the demonstration.

The task's `Read > Emulate` shorthand omits saving/choosing the record; it also describes emulation, not necessarily physical-card cloning. [Official Flipper LF menu](https://docs.flipper.net/zero/rfid)

## 4. 13.56 MHz: branch by card family

The three named command families are **not one universal cloning sequence**. First identify the family and confirm the authorized lab scope. No universal procedure for bypassing secure credentials follows from the frequency.

### A. MIFARE Classic lab sample

1. Confirm MIFARE Classic rather than DESFire, another NFC application or a mobile credential.
2. Review authorized sample information with `hf mf info`; record that some checks may actively interact with the lab card, rather than being passive observation.
3. For a specifically approved vulnerable Classic training card, `hf mf autopwn` can attempt automated key recovery and, if successful, a dump. Failure or incomplete recovery is a valid outcome, not evidence the card was fully cloned.
4. Check recovered lab keys, sector access and dump completeness against the instructor's known sample. Protect dumps and keys as sensitive test data.
5. Only if compatible cloning/emulation is supported and expressly permitted, use the installed client's documented restore/emulator workflow with a sacrificial destination. Do not alter sector trailers or manufacturer blocks of the source card.
6. Validate the destination against the isolated verifier. A copied UID or readable dump is insufficient proof of working authentication. Record unsupported/failed results honestly and clear test material.

```text
hf mf info -h
hf mf autopwn -h
```

The command's scope is MIFARE Classic; it is not a general attack on all 13.56 MHz systems. [Official MIFARE client source](https://github.com/RfidResearchGroup/proxmark3/blob/master/client/src/cmdhfmf.c)

### B. iCLASS / PicoPass lab sample

1. Confirm the actual iCLASS/PicoPass family and generation; do not classify it as MIFARE Classic.
2. Review the installed iCLASS information and dump help. Use only lab keys or access granted by the sample owner.
3. `hf iclass dump` reads accessible card memory under the supported authentication/configuration. Saving a dump alone does not establish that secrets, secure application data or required authentication can be reproduced.
4. Assess whether the exact sample supports an authorized lab copy/emulation with suitable material and documented tooling. If secure authentication cannot be reproduced, report the limit rather than claiming a clone.
5. Use the isolated verifier to compare actual behavior, then recover copies, revoke lab privileges and protect/delete the evidence appropriately.

```text
hf iclass info -h
hf iclass dump -h
```

Do not apply `hf mf autopwn` to iCLASS or treat iCLASS as equivalent to every HID product. [Official iCLASS client source](https://github.com/RfidResearchGroup/proxmark3/blob/master/client/src/cmdhficlass.c)

### C. Other cryptographic HF/mobile credentials

DESFire and cryptographic mobile credentials require their own supported authentication and key-management assessment. They are not covered by the Classic/iCLASS steps. An NFC logo, UID, memory dump, or generic emulator is not evidence their authentication was defeated.

## 5. Wiegand and the four attack surfaces

Traditional Wiegand reader-to-panel signalling lacks modern cryptographic authentication/encryption; bit parity is not a cryptographic integrity check. Protecting the RF credential does not automatically protect the downstream wire or controller.

| Surface from the task | Actual layer / assessment question | Countermeasures |
| --- | --- | --- |
| Clone the card | Credential/RF: is authorization based on a reproducible static identifier? | Authenticated credentials, diversified/managed keys, revocation and relevant additional factors |
| Intercept Wiegand signal | Reader-to-panel transport: can exposed wiring disclose or accept untrusted credential messages? | Protected wiring, tamper alarms and correctly provisioned OSDP Secure Channel where supported |
| Manipulate the lock directly | Lock/relay/power hardware: can release occur independently of a valid access decision? | Secure-side relays/panels, supervised circuits, installation review and safe alarm response |
| Bypass the database | Enrollment/policy/admin layer: can unauthorized privilege changes or stale local policy affect access? | Restricted administration, MFA, change approval, audit logs, segmentation and verified panel synchronization |

The last two are not inherent Wiegand-protocol flaws. Do not infer a database exploit or lock defect from the presence of Wiegand. No interception, replay, electrical manipulation or database access is proposed or performed here. Secure Channel protects the communication link, not every aspect of the physical door. [SIA OSDP reference](https://www.securityindustry.org/industry-standards/open-supervised-device-protocol/)

## 6. Expected evidence and conclusion

A future lab record should include sample owner/scope, tool and firmware version, sample family, allowed operations, read/dump completeness, destination compatibility, isolated-verifier results, limitations and cleanup. **Actual outcome of this assignment: theory only; no clone, recovered key or successful access is claimed.**
