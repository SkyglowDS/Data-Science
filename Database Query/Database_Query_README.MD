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
AND GENDER == 'Male'
)

SELECT 
    ID,
    SALARY
FROM customer_salary_table AS table_b
LEFT JOIN table_a
ON table_a.id = table_b.id
```
### Rolling Window Funciton




