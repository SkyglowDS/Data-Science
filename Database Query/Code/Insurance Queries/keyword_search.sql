WITH decrypted_claims AS (
    claim_id
    , lower(decrypt_function(encrypted_descriptions)) AS decrypted_descriptions
    , total_incurred
FROM table1
WHERE encrypted_descriptions IS NOT NULL
)
SELECT
    COUNT(DISTINCT claim_id) as claim_counts
    , AVG(total_incurred) as average_total_incurred
FROM decrypted_claims
WHERE decrypted_descriptions LIKE '%keyword%'
OR decrypted_descriptions LIKE '%key word%'
AND decrypted_descriptions NOT LIKE '%key%word%'