Threat Modeling an IoT Smart Thermostat

1. IoT-specific threats not common in web apps
* Physical tampering: The device is in the home and an attacker can touch it, open it, or connect to its ports. Web servers are usually locked away in data centers.
* Weak default credentials: Many IoT devices ship with default passwords like admin/admin that users never change, making them easy to access.
* Unencrypted communication: Some IoT devices send data in plaintext over the network, so an attacker on the same Wi-Fi can read or change it.
* Firmware vulnerabilities: The device runs firmware that is often outdated and hard to patch, leaving known flaws open for a long time.
* Insecure OTA updates: If firmware updates are not signed or encrypted, an attacker can push fake malicious firmware to the device.

2. Attacker gains physical access
If an attacker can physically reach the thermostat, the attack chain looks like this:
* Step 1: The attacker opens the device case and looks for debug ports (like UART or JTAG) used by developers.
* Step 2: They connect to these ports to access the system, read the firmware, or get a root shell.
* Step 3: They extract the memory or storage chip to read sensitive data, such as Wi-Fi passwords or API keys stored on the device.
* Step 4: With these secrets, they can access the home network or clone the device.
* Step 5: They may install malicious firmware to keep control of the device.

Potential impacts:
* Stolen Wi-Fi credentials give access to the whole home network.
* The attacker controls the heating and cooling, which can damage the home or harm the resident.
* The device becomes a backdoor into the network for further attacks.

3. Security controls for the OTA update process
The essential security requirements:
* Code signing: Every firmware update must be digitally signed by the manufacturer. The device checks the signature and only installs updates that are real and not changed.
* Encrypted channel: Send updates over HTTPS/TLS so an attacker cannot read or modify the firmware while it downloads.
* Secure boot: The device checks that the firmware is trusted before it runs. This stops malicious firmware from starting.
* Rollback protection: Do not allow downgrading to an old firmware version. Attackers could use an old version with known flaws.
* Integrity check: Verify the firmware with a hash to confirm it was not corrupted or tampered during download.
