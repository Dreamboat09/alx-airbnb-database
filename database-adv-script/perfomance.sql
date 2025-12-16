-- =====================================
-- INITIAL (UNOPTIMIZED) QUERY
-- Retrieves all bookings with user, property, and payment details
-- =====================================

SELECT 
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,

    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.email,

    p.id AS property_id,
    p.name AS property_name,
    p.location,

    pay.id AS payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_status,
    pay.created_at AS payment_date
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON pay.booking_id = b.id;

-- =====================================
-- PERFORMANCE ANALYSIS
-- =====================================

EXPLAIN
SELECT 
    b.id,
    u.id,
    p.id,
    pay.id
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON pay.booking_id = b.id;

-- =====================================
-- IDENTIFIED INEFFICIENCIES
-- 1. Selecting unnecessary columns (SELECT *) increases I/O
-- 2. LEFT JOIN on payments without filtering
-- 3. No filtering condition (full table scan)
-- 4. Missing indexes on foreign keys cause slow joins
-- =====================================

-- =====================================
-- REFACTORED (OPTIMIZED) QUERY
-- =====================================

SELECT 
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    b.total_price,

    u.first_name,
    u.last_name,

    p.name AS property_name,

    pay.amount,
    pay.payment_status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON pay.booking_id = b.id
WHERE b.status = 'confirmed'
  AND b.created_at >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
ORDER BY b.created_at DESC;

-- =====================================
-- EXPLAIN AFTER OPTIMIZATION
-- =====================================

EXPLAIN
SELECT 
    b.id,
    u.first_name,
    p.name
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
WHERE b.status = 'confirmed'
ORDER BY b.created_at DESC;

-- =====================================
-- RECOMMENDED INDEXES (to be created separately)
-- =====================================
-- bookings(user_id)
-- bookings(property_id)
-- bookings(status, created_at)
-- payments(booking_id)