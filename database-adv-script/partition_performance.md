# Brief Report: Booking Table Partitioning Performance
## Problem

The bookings table had grown very large, causing slow query performance when filtering by start_date, especially for date-range queries. Full table scans were occurring despite indexing.

## Solution Implemented

Range partitioning was applied to the bookings table based on the year of start_date.
Each partition stores bookings for a specific year.
A p_future partition handles upcoming years.
Primary key was updated to include start_date (required for partitioning).
This allows the database to use partition pruning, scanning only relevant partitions.

## Performance Testing
Before Partitioning
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';


## Observed behavior:

Full table scan
High number of rows examined
Slower execution time

## After Partitioning
EXPLAIN ANALYZE
SELECT *
FROM bookings_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';


## Observed behavior:

Only the p2024 partition was scanned
Significantly fewer rows examined
Faster execution time
🚀 Improvements Observed
✅ Reduced I/O operations
✅ Faster query execution for date-based queries
✅ Better scalability as data grows
✅ Improved query predictability

Partition pruning ensured that only relevant partitions were accessed instead of scanning the entire dataset.

## Conclusion
Partitioning the bookings table by start_date significantly improved performance for date-range queries on large datasets. This approach is particularly effective for time-series data and aligns well with real-world booking systems.