-- ========================================================
-- PROJECT: E-COMMERCE & MARKETING REVENUE PIPELINE
-- STEP 2: RELATIONAL DATABASE MODELING & AGGREGATIONS
-- ========================================================

CREATE TABLE IF NOT EXISTS marketing_campaigns (
    campaign_id TEXT PRIMARY KEY,
    channel TEXT,
    objective TEXT,
    target_segment TEXT,
    expected_uplift REAL,
    start_date TEXT,
    end_date TEXT
);

CREATE TABLE IF NOT EXISTS ecommerce_sales (
    transaction_id TEXT PRIMARY KEY,
    customer_id TEXT,
    product_id TEXT,
    gross_revenue REAL,
    quantity INTEGER,
    discount_applied INTEGER,
    refund_flag INTEGER,
    timestamp TEXT,
    campaign_id TEXT,
    FOREIGN KEY (campaign_id) REFERENCES marketing_campaigns(campaign_id)
);

SELECT 
    c.channel AS marketing_channel,
    SUM(s.gross_revenue) AS total_net_revenue
FROM ecommerce_sales s
INNER JOIN marketing_campaigns c 
    ON s.campaign_id = c.campaign_id
WHERE s.refund_flag = 0
GROUP BY c.channel
ORDER BY total_net_revenue DESC;