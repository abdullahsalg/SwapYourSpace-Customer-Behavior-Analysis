-- =====================================================
-- SwapYourSpace Customer Behavior & Subscription Analysis
-- Google BigQuery SQL Queries
-- =====================================================

-- 1. Total Customers by Country

SELECT
    country,
    COUNT(*) AS total_customers
FROM country_table
GROUP BY country
ORDER BY total_customers DESC;


-- 2. Subscription Distribution

SELECT
    subscription_type,
    COUNT(*) AS total_subscriptions
FROM subscriptions
GROUP BY subscription_type
ORDER BY total_subscriptions DESC;


-- 3. Active vs Cancelled Subscriptions

SELECT
    subscription_status,
    COUNT(*) AS total_customers
FROM subscriptions
GROUP BY subscription_status;


-- 4. Customer Renewal Analysis

SELECT
    renewal_status,
    COUNT(*) AS total_customers
FROM renew_state
GROUP BY renewal_status
ORDER BY total_customers DESC;


-- 5. Cancellation Analysis

SELECT
    cancellation_reason,
    COUNT(*) AS total_cancellations
FROM cancellation_table
GROUP BY cancellation_reason
ORDER BY total_cancellations DESC;


-- 6. Exchange Activity by Country

SELECT
    country,
    COUNT(*) AS total_exchanges
FROM exchanges
GROUP BY country
ORDER BY total_exchanges DESC;


-- 7. Monthly Exchange Trend

SELECT
    EXTRACT(YEAR FROM exchange_date) AS year,
    EXTRACT(MONTH FROM exchange_date) AS month,
    COUNT(*) AS total_exchanges
FROM exchanges
GROUP BY year, month
ORDER BY year, month;


-- 8. Customer Retention KPI

SELECT
    renewal_status,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS retention_percentage
FROM renew_state
GROUP BY renewal_status;


-- 9. Top Countries by Subscription Count

SELECT
    c.country,
    COUNT(s.customer_id) AS subscriptions
FROM subscriptions s
LEFT JOIN country_table c
    ON s.customer_id = c.customer_id
GROUP BY c.country
ORDER BY subscriptions DESC
LIMIT 10;


-- 10. Business KPI Summary

SELECT
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(*) AS total_subscriptions
FROM subscriptions;
