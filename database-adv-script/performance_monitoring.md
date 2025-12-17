## Observed Bottlenecks
Queries filtering by user_id, status, or start_date caused full table scans
Sorting by created_at triggered filesort operations
Aggregation queries (COUNT + GROUP BY) used temporary tables

## mprovements Implemented
### Added composite indexes:
(user_id, created_at)
(status, start_date)

### Added aggregation-supporting index:
(property_id)

## Performance Improvements
Execution plans changed from table scan → index scan
Reduced query cost and execution time
Eliminated unnecessary temporary tables and filesorts