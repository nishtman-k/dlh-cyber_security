Threat Modeling a Healthcare Mobile App

1. Most critical asset using the CIA Triad
The most critical asset is the patient medical records.

Using the CIA Triad to explain why:
* Confidentiality: Medical records are very private. If leaked, it harms the patient and breaks laws like HIPAA. Keeping this data secret is the top concern.
* Integrity: The records must be correct. If someone changes a diagnosis or prescription, it can lead to wrong treatment and serious harm to the patient.
* Availability: Doctors need access to records at the right time. If the data is not available during an emergency, it can delay care.
All three matter, but confidentiality is the most important here because of how sensitive and protected health data is.

2. STRIDE applied to "message healthcare providers"
* Spoofing: An attacker pretends to be a doctor and sends fake messages to a patient, or pretends to be a patient to get private information.
* Tampering: A message is changed while being sent. For example, changing the dose in a prescription instruction.
* Repudiation: A user denies sending a message. Without logs, there is no proof of who sent what.
* Information Disclosure: An attacker reads private messages between a patient and a doctor by intercepting the traffic.
(One more if useful)
* Elevation of Privilege: A normal user gains access to the messaging system of other patients or providers.

3. Five security controls in order of priority
* Strong authentication: Make sure only the real patient or provider can log in. Use multi-factor authentication so a stolen password is not enough. This comes first because everything depends on knowing who the user really is.
* Encryption: Encrypt data both in transit (HTTPS/TLS) and at rest in the database. This protects records and messages even if traffic is intercepted or the database is stolen.
* Access controls: Apply least privilege so each user only sees what they are allowed to. A patient should not access another patient's records.
* Audit logging: Keep logs of who accessed or changed data and when. This gives proof of actions and helps detect attacks. It also supports HIPAA compliance.
* Input validation: Check all input from the mobile client to prevent injection and other attacks against the API and database.
