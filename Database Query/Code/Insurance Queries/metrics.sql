WITH all_xyz_claims AS (
    SELECT
        account_id
        , client_name
        , attorney_involved
        , litigation_involved
        , CASE 
            WHEN claim_status = 'closed' THEN DATE_DIFF('day', accident_date, closed_date)
            ELSE DATE_DIFF('day', accident_date, valuation_date)
            END AS claim_duration
        , CASE
            WHEN accident_date > report_date THEN NULL
            ELSE DATE_DIFF('day', accident_date, valuation_date)
            END AS claim_report_lag
        , total_incurred
    FROM table1
    WHERE upper(state_id) IN ('CA', 'NY', 'FL')
    AND YEAR(accident_date) BETWEEN 2000 AND 2010
    AND claim_status IN ('Open', 'Closed')
    AND claim_type IN ('abc', 'xyz')
)
SELECT
    SUM(CASE WHEN claim_status = 'closed' THEN 1 ELSE 0 END) * 1.0000 / COUNT(*) AS closed_claims_percentage
    , ROUND(AVG(total_incurred), 2) AS average_total_incurred
    , ROUND(AVG(LEAST(total_incurred, 250000)), 2) AS average_total_incurred_capped_250k
    , ROUND(AVG(claim_duration), 2) AS average_claim_duration
    , SUM(CASE WHEN total_incurred > 250000 THEN 1 ELSE 0 END) AS claim_count_total_incurred_greater_250k 
    , SUM(CASE WHEN total_incurred > 250000 THEN total_incurred END) * 1.0000 / SUM(total_incurred) AS total_incurred_ratio_greater_250k
    , ROUND(AVG(CASE WHEN attorney_involved = 1 THEN total_incurred END), 2) AS average_paid_attorney_involved
    , COUNT(CASE WHEN claim_report_lag >= 0 AND claim_report_lag <= 7 THEN 1 END) * 1.0000 / COUNT(*) claims_reported_first_week
FROM all_xyz_claims