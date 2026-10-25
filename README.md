# BarangayGo

PHP 8.1+ community services application. Uses MySQL / MariaDB with PDO MySQL and InnoDB transactions. No Composer packages required.

## Run

The application now targets the hosting database **if0_43266472_BarangayGo** on **sql309.infinityfree.com:3306**, using username **if0_43266472**.

Connection settings are in `database/config.php`. The database password must be supplied through the server environment variable `BARANGAY_DB_PASSWORD`; it is not saved in the source files. Other connection overrides are `BARANGAY_DB_HOST`, `BARANGAY_DB_PORT`, `BARANGAY_DB_NAME`, and `BARANGAY_DB_USER`.

For hosting: open the database's phpMyAdmin from the hosting control panel, select **if0_43266472_BarangayGo**, and import `database/schema.sql`. This file creates all seven InnoDB tables without trying to create or select a different database. Upload the application files, configure the password on the server, then open the hosted website to initialize the demo accounts. This schema import does not transfer local records; export those separately from local phpMyAdmin if needed.

For local XAMPP use, override the host to `127.0.0.1`, port to `3307`, name to `barangaygo`, user to `root`, and password to an empty string. The local database from the earlier setup remains available at http://localhost/phpmyadmin/index.php?route=/database/structure&db=barangaygo .

For a fresh installation run `C:\xampp\php\php.exe database/setup.php` from this folder, or import `database/schema.sql` through phpMyAdmin. The setup command also migrates the former SQLite database if present and the destination tables are empty. Existing MySQL data is preserved. Open the app to initialize demo accounts if no accounts have been migrated. The original `storage/barangay.sqlite` is retained as a backup and is no longer used by the application.

Initial local demo accounts:

| Role | Email | Password |
| --- | --- | --- |
| Staff | admin@barangay.local | BarangayAdmin!2026 |
| Resident | resident@barangay.local | Resident!2026 |

Change both demo passwords through My profile before deployment. Use HTTPS and a dedicated database user in production. The storage and database folders must remain inaccessible over HTTP; their Apache `.htaccess` files deny access. For other servers configure equivalent deny rules. Back up MySQL through phpMyAdmin Export or mysqldump.

## Included

Resident CRUD with linked-record protection; password-hashed login; staff/resident authorization; 30-minute idle sessions; session regeneration; CSRF tokens; login throttling; dashboard statistics; name/type/status filtering; sequential Pending → Ready for Pickup → Claimed request workflow; document types, fees and requirements; full-payment tracking with duplicate protection; profile updates; activity log; Excel-compatible XML workbook export and browser Print / Save as PDF reports. Resident accounts see only their own requests. Staff administer records and payments. The initial resident account is linked to the sample resident; additional accounts require administrator provisioning in the database (public registration is intentionally unavailable).

Fees are stored in integer centavos and captured on each request. Claiming a paid document requires a recorded payment. Daily dashboard totals use Philippine time; database event timestamps and table timestamps use UTC.

## Transactions and sessions

`db.php` configures secure session options, regeneration, timeout, and the transaction helper. `index.php` explicitly identifies three required database transactions: resident write + audit; request creation + captured fee + audit; validated payment + audit. Status changes, type edits, account changes, and deletions also use transactions. Exceptions roll back all writes in each operation.

Reports respect the name/type and status filters. Excel exports contain text cells to prevent formula execution. PDF output uses the browser print dialog; select Save as PDF. Fonts use Google Fonts with local Arial fallbacks.
