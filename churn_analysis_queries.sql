-- =============================================================================
-- PROJECT: Telco Customer Churn Analysis
-- SCRIPT: Data Loading & Initial Data Integrity Validation
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. Database Selection
-- Ensure queries run against the correct database environment
-- -----------------------------------------------------------------------------
USE telco_churn_db;

-- -----------------------------------------------------------------------------
-- 2. Bulk Data Ingestion
-- Import cleaned CSV dataset into the target table
-- -----------------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'C:/customer churn project/archive (2)/telco_cleaned.csv'
INTO TABLE customer_churn
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- -----------------------------------------------------------------------------
-- 3. Validation Checks
-- Confirm total row count and verify primary key integrity
-- -----------------------------------------------------------------------------

-- Check 3.1: Verify total records loaded into the table
SELECT 
    COUNT(*) AS total_records 
FROM customer_churn;

-- Check 3.2: Verify non-null Primary Keys (Customer_IDs) against total row count
SELECT 
    COUNT(*) AS total_rows,
    COUNT(Customer_ID) AS valid_ids
FROM customer_churn;

SELECT 
    COUNT(*) AS total_customers,
    SUM(Churned) AS total_churned,
    ROUND(SUM(Churned) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customer_churn;

SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(Churned) AS churned_customers,
    ROUND(SUM(Churned) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

SELECT 
    City,
    COUNT(*) AS total_customers,
    ROUND(SUM(Total_Revenue), 2) AS total_revenue
FROM customer_churn
GROUP BY City
ORDER BY total_revenue DESC
LIMIT 10;  

SELECT 
    CASE 
        WHEN Total_Revenue >= 5000 THEN 'High Value'
        WHEN Total_Revenue >= 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS revenue_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(Churned) * 100, 2) AS churn_rate_pct
FROM customer_churn
GROUP BY revenue_segment
ORDER BY churn_rate_pct DESC;

SELECT 
    Payment_Method,
    COUNT(*) AS total_customers,
    ROUND(AVG(Churned) * 100, 2) AS churn_rate_pct
FROM customer_churn
GROUP BY Payment_Method
HAVING AVG(Churned) > (SELECT AVG(Churned) FROM customer_churn)
ORDER BY churn_rate_pct DESC;

SELECT 
    Customer_ID,
    Monthly_Charge,
    Contract,
    Churn_Reason
FROM customer_churn
WHERE Churned = 1
  AND Monthly_Charge > (SELECT AVG(Monthly_Charge) FROM customer_churn)
ORDER BY Monthly_Charge DESC
LIMIT 15;

SELECT 
    City,
    ROUND(SUM(Total_Revenue), 2) AS city_revenue,
    RANK() OVER (ORDER BY SUM(Total_Revenue) DESC) AS revenue_rank
FROM customer_churn
GROUP BY City
LIMIT 10;

SELECT 
    City,
    Contract,
    ROUND(AVG(Churned) * 100, 2) AS churn_rate_pct,
    DENSE_RANK() OVER (PARTITION BY City ORDER BY AVG(Churned) DESC) AS churn_rank_in_city
FROM customer_churn
GROUP BY City, Contract
HAVING COUNT(*) >= 20  -- avoid tiny-sample noise
ORDER BY City, churn_rank_in_city
LIMIT 20;

WITH tenure_summary AS (
    SELECT 
        Tenure_Group,
        COUNT(*) AS total_customers,
        SUM(Churned) AS churned_customers
    FROM customer_churn
    GROUP BY Tenure_Group
)
SELECT 
    Tenure_Group,
    total_customers,
    churned_customers,
    ROUND((total_customers - churned_customers) * 100.0 / total_customers, 2) AS retention_rate_pct
FROM tenure_summary
ORDER BY retention_rate_pct ASC;  

WITH ranked_reasons AS (
    SELECT 
        Contract,
        Churn_Reason,
        COUNT(*) AS reason_count,
        ROW_NUMBER() OVER (PARTITION BY Contract ORDER BY COUNT(*) DESC) AS rn
    FROM customer_churn
    WHERE Churned = 1
    GROUP BY Contract, Churn_Reason
)
SELECT Contract, Churn_Reason, reason_count
FROM ranked_reasons
WHERE rn <= 3
ORDER BY Contract, rn;