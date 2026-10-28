# Technical Remediation — SQL Injection

**Affected endpoint:** `/login.php`  
**Primary fix:** Prepared statements with bound parameters.

## 1. Secure Code

The original query directly inserts user input into SQL. The replacement treats the username as data and verifies the password against a stored hash.

**Prerequisites:** `$conn` is an existing MySQLi connection. The `users` table contains `id`, a unique `username`, and a `password_hash` column.

```php
<?php
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    header('Allow: POST');
    exit('Method not allowed.');
}

$username = $_POST['username'] ?? null;
$password = $_POST['password'] ?? null;

if (
    !is_string($username) ||
    !is_string($password) ||
    $username === '' ||
    $password === '' ||
    strlen($username) > 255 ||
    strlen($password) > 4096
) {
    http_response_code(400);
    exit('Invalid input.');
}

try {
    $conn->set_charset('utf8mb4');

    $stmt = $conn->prepare(
        'SELECT id, password_hash FROM users WHERE username = ? LIMIT 1'
    );
    $stmt->bind_param('s', $username);
    $stmt->execute();
    $stmt->bind_result($userId, $storedHash);

    $found = $stmt->fetch();
    $stmt->close();
} catch (mysqli_sql_exception $e) {
    // Do not expose SQL details or credentials.
    error_log('Login database operation failed.');
    http_response_code(500);
    exit('Unable to process login.');
}

if (!$found || !password_verify($password, $storedHash)) {
    http_response_code(401);
    exit('Invalid username or password.');
}

// Continue the application's successful-login flow:
// regenerate the session ID and store the authenticated user ID.
```

Do not compare plaintext passwords inside the SQL query.

## 2. Implementation Steps

1. **Replace unsafe queries**
   - Use prepared statements wherever SQL includes user-supplied values.
   - Do not concatenate input into SQL.
   - Use explicit allowlists for dynamic identifiers such as column names.

2. **Migrate password storage**
   - Store password hashes in a `VARCHAR(255)` column.
   - Generate hashes during registration and password reset.
   - For PHP installations supporting Argon2id:

   ```php
   $hash = password_hash($password, PASSWORD_ARGON2ID);
   ```

   - Save the hash using a prepared statement.
   - Migrate existing accounts through a controlled process or require password resets.
   - Remove plaintext password storage after migration.

3. **Validate input**
   - Reject missing fields, arrays, and oversized values.
   - Align length limits with the application's schema and password policy.
   - Treat validation as an additional control, not a substitute for parameterization.

4. **Apply least privilege**
   - Use a dedicated database account.
   - Grant only the operations required by the application.
   - Avoid administrative privileges such as `FILE`, `GRANT OPTION`, and schema modification unless specifically required.

5. **Configure safe logging**
   - Log authentication outcomes and database errors in access-controlled logs.
   - Never log passwords, password hashes, or complete login request bodies.
   - Keep detailed database errors out of HTTP responses.
   - Enable database auditing selectively; unrestricted query logging can expose sensitive information.

6. **Deploy safely**
   - Complete password migration before enabling the replacement login flow.
   - Test in staging before production deployment.
   - Use HTTPS and apply session security and login rate limiting.

## 3. Verification

### Check PHP Syntax

```bash
php -l login.php
```

Expected result:

```text
No syntax errors detected in login.php
```

### Test for SQL Injection

Run against the authorized test environment:

```bash
sqlmap -u "http://target/login.php" \
  --data="username=admin&password=test" \
  -p username,password \
  --batch \
  --flush-session
```

Expected result: SQLmap does not identify either parameter as injectable.

### Test Authentication Bypass

```bash
curl -i "http://target/login.php" \
  --data-urlencode "username=admin' OR '1'='1' -- " \
  --data-urlencode "password=wrong"
```

Expected result: HTTP 401 with a generic authentication failure and no SQL error.

### Functional Checks

- Valid credentials complete the normal login flow.
- An incorrect password is rejected.
- An unknown username is rejected with the same generic message.
- Array inputs and missing fields are rejected.
- Passwords containing quotes work correctly when valid.
- No passwords or SQL details appear in responses or logs.

A clean automated scan supports verification but does not prove that every SQL injection path has been eliminated. Review the code and test other database-backed endpoints.

## References

- [PHP MySQLi Prepared Statements](https://www.php.net/manual/en/mysqli.quickstart.prepared-statements.php)
- [PHP Password Verification](https://www.php.net/manual/en/function.password-verify.php)
