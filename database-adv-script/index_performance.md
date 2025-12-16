# Identify High-Usage Columns (Reasoning)

## Users table
### Common usage:
WHERE email = ? → login & authentication
JOIN bookings ON users.id = bookings.user_id
ORDER BY created_at

### High-usage columns:
email
id (already indexed as PRIMARY KEY)
created_at

## Properties table
### Common usage:
JOIN bookings ON properties.id = bookings.property_id
WHERE user_id = ? (host → properties)
ORDER BY created_at

### High-usage columns:
user_id
created_at

## Bookings table
### Common usage:
JOIN users ON bookings.user_id = users.id
JOIN properties ON bookings.property_id = properties.id
WHERE status = ?
ORDER BY created_at
Analytics queries (COUNT per user/property)

### High-usage columns:
user_id
property_id
status
created_at
(user_id, created_at) → composite index

# Index Creation 
You now have single-column + composite indexes saved in:

These indexes:
Speed up joins
Reduce full table scans
Improve ORDER BY performance
Optimize analytics queries

# Measure Performance (Before & After Indexing)
### Example Query (Before Index)
EXPLAIN
SELECT *
FROM bookings
WHERE user_id = 5
ORDER BY created_at DESC;

### Before Index (Typical Output)
type: ALL
rows: large number
Extra: Using filesort

This means full table scan (slow).

### After Index Applied
EXPLAIN
SELECT *
FROM bookings
WHERE user_id = 5
ORDER BY created_at DESC;

### After Index (Expected Output)
type: ref
key: idx_bookings_user_created
rows: small number
Extra: Using index

This means indexed lookup (fast).

#  Using ANALYZE (If Supported)
ANALYZE
SELECT *
FROM bookings
WHERE property_id = 10;


This shows:
Execution time
Rows examined
Actual performance cost