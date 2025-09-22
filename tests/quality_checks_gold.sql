/*
=============================================================================================================================
Quality Checks
=============================================================================================================================
Script Purpose:
      This script performs quality checks to validate the integrity, consistency, 
      and accuracy of the Gold Layer, These checks ensure:
          -uniqueness of surrogate keys in dimension tables.
          -Referential integrity between fact and dimension tables.
          -Validation of relationships in the data model for analytical purposes.

Usage Notes:
    -Run these checks after data loading Silver Layer.
    -Investigate and resolve any disturbances found during the checks.
=============================================================================================================================
*/

--=============================================================================================================================
-- Checking 'gold.dim_customers
--=============================================================================================================================
--Check for Uniqueness of customer Key in gold.dim_customers
-- Expectation: No results
SELECT
    customer key
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*)>1；

--=============================================================================================================================
--Checking 'gold.product_key
--=============================================================================================================================
-- Check for Uniqueness of Product Key in gold.dim_products
-- Expectation: No results
SELECT
   product key, 
   COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*)>1;

--=============================================================================================================================
-- Checking 'gold.fact_sales'
--=============================================================================================================================
-- Check the data model connectivity between fact and dimensions
SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
oN c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
oN p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL
