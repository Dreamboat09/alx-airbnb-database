-- =====================================
-- TABLE PARTITIONING ON bookings.start_date
-- =====================================

-- 1. CREATE PARTITIONED BOOKINGS TABLE
-- (If bookings already exists, this would normally require
--  creating a new table and migrating data)

CREATE TABLE bookings_partitioned (
    id INT NOT NULL,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20),
    created_at DATETIME,
    PRIMARY KEY (id, start_date)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- =====================================
-- 2. MIGRATE DATA (example)
-- =====================================

INSERT INTO bookings_partitioned
SELECT * FROM bookings;

-- =====================================
-- 3. PERFORMANCE TEST (BEFORE PARTITIONING)
-- =====================================

EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';

-- =====================================
-- 4. PERFORMANCE TEST (AFTER PARTITIONING)
-- =====================================

EXPLAIN ANALYZE
SELECT *
FROM bookings_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';

-- =====================================
-- 5. PARTITION PRUNING CHECK
-- =====================================

EXPLAIN
SELECT *
FROM bookings_partitioned
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';