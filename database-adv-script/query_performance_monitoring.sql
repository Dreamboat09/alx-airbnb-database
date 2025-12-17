-- ==================================================
-- QUERY PERFORMANCE MONITORING & OPTIMIZATION
-- ==================================================
-- Assumption: MySQL 8+ (EXPLAIN ANALYZE supported)

-- --------------------------------------------------
-- QUERY 1: Fetch bookings for a user (frequently used)
-- --------------------------------------------------

EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = 10
ORDER BY created_at DESC;

-- Identified Bottleneck:
-- - Full table scan or filesort if no composite index exists

-- Optimization: Composite index on (user_id, created_at)
CREATE INDEX idx_bookings_user_created_at
ON bookings(user_id, created_at);

-- Re-test after optimization
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = 10
ORDER BY created_at DESC;


-- --------------------------------------------------
-- QUERY 2: Count bookings per property (analytics)
-- --------------------------------------------------

EXPLAIN ANALYZE
SELECT property_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY property_id
ORDER BY total_bookings DESC;

-- Identified Bottleneck:
-- - Temporary table creation
-- - High cost GROUP BY

-- Optimization: Index on property_id
CREATE INDEX idx_bookings_property_id
ON bookings(property_id);

-- Re-test after optimization
EXPLAIN ANALYZE
SELECT property_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY property_id
ORDER BY total_bookings DESC;


-- --------------------------------------------------
-- QUERY 3: Filter confirmed bookings in a date range
-- --------------------------------------------------

EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE status = 'confirmed'
  AND start_date BETWEEN '2024-01-01' AND '2024-06-30';

-- Identified Bottleneck:
-- - Range scan without optimal index

-- Optimization: Composite index on (status, start_date)
CREATE INDEX idx_bookings_status_start_date
ON bookings(status, start_date);

-- Re-test after optimization
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE status = 'confirmed'
  AND start_date BETWEEN '2024-01-01' AND '2024-06-30';
