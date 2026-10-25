<?php
declare(strict_types=1);
// Hosted database connection. Supply the password through server environment configuration.
return [
    'host' => getenv('BARANGAY_DB_HOST') ?: 'sql309.infinityfree.com',
    'port' => getenv('BARANGAY_DB_PORT') ?: '3306',
    'name' => getenv('BARANGAY_DB_NAME') ?: 'if0_43266472_BarangayGo',
    'user' => getenv('BARANGAY_DB_USER') ?: 'if0_43266472',
    'password' => getenv('BARANGAY_DB_PASSWORD') ?: '',
];
