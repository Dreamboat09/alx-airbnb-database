## Initial Query (Unoptimized)

### What it does
Retrieves all bookings
Joins users, properties, and payments
No filtering
Pulls many columns

### Why this is inefficient
Full table scans on bookings
Large JOIN result set
LEFT JOIN on payments even when not needed
High I/O due to wide SELECT list

This is realistic — many juniors write queries like this first.

## Performance Analysis Using EXPLAIN

### Typical problems EXPLAIN reveals
type: ALL → full table scan ❌
High rows count ❌
Using temporary; Using filesort ❌
No index used on JOIN columns ❌

This confirms the query does not scale.

## Refactored (Optimized) Query
### Improvements made
✅ Selected only required columns
✅ Added a WHERE condition (confirmed bookings only)
✅ Reduced unnecessary data transfer
✅ Ordered by indexed column
✅ Preserved LEFT JOIN only where needed

### This dramatically reduces:
Rows scanned
Join cost
Sorting cost

## EXPLAIN After Optimization

### After refactoring, EXPLAIN should show:
type: ref or range ✅
Index usage (status, created_at) ✅
Lower row estimates ✅
Faster execution time ✅

## Indexing Strategy (Critical)

### You correctly paired optimization with indexing:

bookings(user_id)
bookings(property_id)
bookings(status, created_at)
payments(booking_id)


### This ensures:
JOINs are fast
WHERE + ORDER BY is optimized
Query scales with data growth