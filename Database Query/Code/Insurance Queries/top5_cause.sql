WITH claims_100k AS (
SELECT
    cause_of_loss
    , COUNT(*) as value_counts
    , ROUND(AVG(total_incurred), 2) avg_total_incurred
FROM table1
WHERE cost > 100000
AND cause_of_loss IS NOT NULL
GROUP BY cause_of_loss
)
SELECT *
FROM claims_100k
ORDER BY claim_counts DESC