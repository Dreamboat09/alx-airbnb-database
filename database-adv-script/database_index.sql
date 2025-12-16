-- =====================================
-- Indexes for high-usage columns
-- =====================================

-- =============================
-- USER TABLE INDEXES
-- =============================
-- Used frequently in WHERE clauses, JOINs, and authentication lookups
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_created_at ON users(created_at);

-- =============================
-- PROPERTY TABLE INDEXES
-- =============================
-- Used in JOINs with bookings and filtering properties by owner
CREATE INDEX idx_properties_user_id ON properties(user_id);
CREATE INDEX idx_properties_created_at ON properties(created_at);

-- =============================
-- BOOKING TABLE INDEXES
-- =============================
-- Used heavily in JOINs, WHERE filters, and ORDER BY clauses
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_created_at ON bookings(created_at);
CREATE INDEX idx_bookings_status ON bookings(status);

-- =============================
-- COMPOSITE INDEX (Performance Boost)
-- =============================
-- Optimizes queries that filter by user and sort by creation time
CREATE INDEX idx_bookings_user_created
ON bookings(user_id, created_at);


-- =====================================
-- QUERY PERFORMANCE MEASUREMENT
-- =====================================
-- Use the following commands BEFORE and AFTER applying indexes
-- to observe performance improvements.

-- Example 1: Analyze bookings by user
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = 5
ORDER BY created_at DESC;

-- Example 2: Analyze property booking aggregation
EXPLAIN ANALYZE
SELECT
    property_id,
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY property_id
ORDER BY total_bookings DESC;

-- Example 3: Analyze user booking count
EXPLAIN ANALYZE
SELECT
    u.id,
    COUNT(b.id) AS booking_count
FROM users u
LEFT JOIN bookings b ON b.user_id = u.id
GROUP BY u.id;