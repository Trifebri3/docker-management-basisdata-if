-- 1. Membuat skema
CREATE SCHEMA SALAM;

-- 2. Membuat tabel mahasiswas di dalam skema salam
CREATE TABLE SALAM.mahasiswas (
    id SERIAL PRIMARY KEY,                          -- Constraint: Primary Key
    nim VARCHAR(10) UNIQUE NOT NULL,                -- Constraint: Unique cek nim agar tidak sama
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,                      -- Constraint: Unique cek email agar tidak sama
    ipk NUMERIC(3, 2) CHECK (ipk >= 0.00 AND ipk <= 4.00) -- Constraint: Cek batasan ip nanti
);

-- === 1. User: backend_dev = (CRUD) ===

CREATE ROLE backend_dev LOGIN PASSWORD 'backend123';

-- Beri izin read-only schema salam
GRANT USAGE ON SCHEMA SALAM TO backend_dev;

-- Beri izin CRUD pada tabel yang ada di schema salam
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA SALAM TO backend_dev;

-- Beri izin CRUD 
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM
   GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO backend_dev;


-- === 2. User: bi_dev = Read-Only ===
CREATE ROLE bi_dev LOGIN PASSWORD 'bi123';

-- Beri izin read-only schema SALAM
GRANT USAGE ON SCHEMA SALAM TO bi_dev;

-- Beri izin Read-Only (SELECT) pada tabel yang ada
GRANT SELECT ON ALL TABLES IN SCHEMA SALAM TO bi_dev;

-- Beri izin Read-Only pada schema salam
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM
   GRANT SELECT ON TABLES TO bi_dev;


-- User: data_engineer  = Full Control ===

CREATE ROLE data_engineer LOGIN PASSWORD 'de123';

-- akses atau izin penuh buat schema SALAM
GRANT ALL PRIVILEGES ON SCHEMA SALAM TO data_engineer;

-- akses atau izin penuh pada semua tabel yang ada
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA SALAM TO data_engineer;

-- akses atau izin penuh buat crud
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA SALAM TO data_engineer;

-- akses atau izin untuk tabel dll yang dibuat nanti
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM
   GRANT ALL PRIVILEGES ON TABLES TO data_engineer;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM
   GRANT ALL PRIVILEGES ON SEQUENCES TO data_engineer;