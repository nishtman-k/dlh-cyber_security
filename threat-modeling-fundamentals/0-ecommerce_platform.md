Threat Modeling an E-commerce Platform

1. Three STRIDE threats for the checkout process

Threat 1: Tampering
* STRIDE category: Tampering
* Description: A user changes the product price in the frontend request before sending it to the server. For example, changing a 100 dollar item to 1 dollar.
* Potential impact: The business loses money because users pay less than the real price.
* Mitigation: Never trust prices sent from the frontend. The server must check the real price from the database before charging the user.

Threat 2: Information Disclosure
* STRIDE category: Information Disclosure
* Description: An attacker intercepts the payment data while it travels between the user and the server, stealing card details.
* Potential impact: User payment information is stolen, leading to fraud and loss of trust.
* Mitigation: Use HTTPS (TLS) to encrypt all traffic. Let Stripe handle the card data directly so it never touches your own server.

Threat 3: Spoofing
* STRIDE category: Spoofing
* Description: An attacker pretends to be another user by stealing their session token or login, then checks out using their account.
* Potential impact: The attacker makes purchases or accesses someone else's saved data.
* Mitigation: Use strong session management (ie: JWT), user loging limits, secure cookies, and require authentication before any checkout action.

2. Trust boundaries in the system
A trust boundary is the point where data moves from an untrusted zone (like the user's browser) into a trusted zone (the server). 

Here are hree examples:
* Between the React frontend and the Node.js API. The browser is untrusted, so all input coming from it must be checked on the server.
* Between the Node.js API and the PostgreSQL database. Queries must be safe so untrusted input cannot reach the database directly.
* Between the Node.js API and Stripe. Payment data crosses from your system to an external payment service, so this connection must be secure and verified.

3. DREAD score for SQL injection in product search
DREAD rates a threat from 1 to 10 on five factors.
* Damage: 9. A successful SQL injection can expose or destroy the whole database, including user data.
* Reproducibility: 9. Once found, the attack works every time with the same input.
* Exploitability: 7. It needs some skill, but tools like sqlmap make it easy to automate.
* Affected Users: 9. A database breach affects all users, not just one.
* Discoverability: 8. The product search is public and easy to find, and injection points are common targets.

Average score: (9 + 9 + 7 + 9 + 8) / 5 = 8.4
This is a high risk. The product search is public, easy to find, and a successful attack impacts every user, so it should be fixed with high priority using parameterized queries.
