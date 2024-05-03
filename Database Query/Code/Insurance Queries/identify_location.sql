SELECT
    a.account_id,
    a.client_name,
    COALESCE(a.address, b.address, 'N/A') AS client_address
FROM
    table_a a
LEFT JOIN
    table_b b 
    ON a.account_id = b.account_id 
    AND a.client_name = b.client_name;