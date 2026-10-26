# SET Analysis

## Which SET menu option creates a payload?

Under **1) Social-Engineering Attacks**, select **4) Create a Payload and Listener**.

For PowerShell payloads, select **9) PowerShell Attack Vectors**, then **2) PowerShell Reverse Shell**.

## Which SET menu option sends emails?

Under **1) Social-Engineering Attacks**, select **5) Mass Mailer Attack**. Choose **E-Mail Attack Single Email Address** to send to one recipient.

## Why host the payload instead of attaching it directly?

Hosting lets the email contain a download link instead of an executable attachment. This keeps the message small and avoids attachment restrictions that may block executable file types.

However, hosting does not guarantee delivery or execution. Email filters can inspect links, and browser or endpoint protections can block the download or execution.
