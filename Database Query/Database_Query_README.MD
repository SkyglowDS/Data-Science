# Database Query











## SQL Queries


### Basic Query
```
SELECT *
FROM Table
WHERE z between x and y
```


### Common Table Expression (CTE)

```
WITH table_a as (
SELECT 
    ID,
    AGE,
    GENDER
FROM customer_demographics_table
WHERE AGE > 50 
AND GENDER = 'Male'
)

SELECT 
    table_b.ID,
    SALARY
FROM customer_salary_table AS table_b
LEFT JOIN table_a
ON table_a.id = table_b.id
```

### Rolling Window Funciton

```
SELECT
    cost,
    AVG(cost) OVER (ORDER BY month_column ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS cost_moving_average
FROM
    table_a;
```


## Sample Code

Sample code are based on Hive/Trino SQL flavor. Slight variation in functions and syntax compared to MySQL/PostgreSQL. 

### Insurance Queries

[Link to folder](Code/Insurance%20Queries/)

Based on common insurance queries. 

`top_5_causes.sql`: Returns the claim count and average total incurred for the top 5 cause of loss where total incurred is greater than 100k. 

`identify_location`: Returns the address of a client, if avaliable, based on two different tables.

`keyword_search.sql`: Finds keywords in claim description and returns the claim counts and average total incurred.

`multiple_keyword_search.sql`: Finds multiple keywords and returns the years of claims and claim counts per keyword for each account.

`metrics.sql`: Returns various claim metrics based on specific claim requirements. 


