WITH decrypted_claims AS (
    SELECT
        account_id
        , client_name
        , claim_id
        , valuation_date
        , lower(decrypt_function(encrypted_descriptions)) AS decrypted_descriptions
        , total_incurred
    FROM table1
    WHERE encrypted_descriptions IS NOT NULL
),
claim_dates AS (
    SELECT 
        account_id
        , client_name
        , date_diff('MONTH', MIN(valuation_date), MAX(valuation_date)) AS max_month_difference
    FROM table2
    GROUP BY account_id, client_name
),
claim_desc_count AS (
    SELECT
        account_id
        , client_name
        , SUM(CASE WHEN decrypted_descriptions LIKE '%keyword1%' THEN 1 ELSE 0 END) AS Keyword1
        , SUM(CASE WHEN decrypted_descriptions LIKE '%keyword2%' THEN 1 ELSE 0 END) AS Keyword2
        , SUM(CASE WHEN (decrypted_descriptions LIKE '%keyword3%'
            OR decrypted_descriptions LIKE '%keyword3_variant_a%' 
            OR decrypted_descriptions LIKE '%keyword3_variant_b%' 
            OR decrypted_descriptions LIKE '%keyword3_variant_c%') THEN 1 ELSE 0 END) as Keyword3
    FROM decrypted_claims
    GROUP BY account_id, client_name
), 
total_claims_table AS (
    SELECT 
        a.account_id as account_id
        , a.client_name as client_name
        , (b.max_month_difference/12.00) as historical_data_years
        , (Keyword1 + Keyword2 + Keyword3) as total_claims
        , Keyword1
        , Keyword2
        , Keyword3
    FROM claim_desc_count a
    LEFT JOIN claims_date b
    ON a.account_id = b.account_id
    AND a.client_name = b.client_name
)
SELECT *
FROM total_claims_table
WHERE total_claims > 0
ORDER BY total_claims DESC