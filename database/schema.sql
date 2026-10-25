-- Select if0_43266472_BarangayGo in phpMyAdmin before importing.
-- The hosting control panel creates the database.
SET NAMES utf8mb4;
CREATE TABLE IF NOT EXISTS residents (
 id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(255) NOT NULL,
 address TEXT NOT NULL,
 birthdate DATE NOT NULL,
 phone VARCHAR(100) NOT NULL DEFAULT '',
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS users (
 id INT AUTO_INCREMENT PRIMARY KEY,
 resident_id INT NULL,
 name VARCHAR(255) NOT NULL,
 email VARCHAR(254) NOT NULL UNIQUE,
 password VARCHAR(255) NOT NULL,
 role ENUM('staff','resident') NOT NULL,
 FOREIGN KEY (resident_id) REFERENCES residents(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS types (
 id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(255) NOT NULL,
 fee INT NOT NULL CHECK (fee >= 0),
 requirements TEXT NOT NULL,
 active TINYINT NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS requests (
 id INT AUTO_INCREMENT PRIMARY KEY,
 resident_id INT NOT NULL,
 type_id INT NOT NULL,
 purpose TEXT NOT NULL,
 fee INT NOT NULL CHECK (fee >= 0),
 status ENUM('Pending','Ready for Pickup','Claimed') NOT NULL DEFAULT 'Pending',
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (resident_id) REFERENCES residents(id),
 FOREIGN KEY (type_id) REFERENCES types(id),
 INDEX idx_request_status (status),
 INDEX idx_request_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS payments (
 id INT AUTO_INCREMENT PRIMARY KEY,
 request_id INT NOT NULL UNIQUE,
 amount INT NOT NULL CHECK (amount >= 0),
 reference VARCHAR(255) NOT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (request_id) REFERENCES requests(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS logs (
 id INT AUTO_INCREMENT PRIMARY KEY,
 user_id INT NULL,
 action TEXT NOT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS login_attempts (
 ip VARCHAR(45) PRIMARY KEY,
 attempts INT NOT NULL,
 last_attempt BIGINT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
