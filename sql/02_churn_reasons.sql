-- Identifying churned accounts base
WITH churned_accounts AS (
  SELECT 
    account_id
  FROM accounts
  WHERE 
    churn_flag = true
),
-- Ranking subscriptions to be able to pull only the latest one for churned MRR/ARR calculations, ignoring trials
last_sub AS (
  SELECT 
    account_id, 
    mrr_amount,
    ROW_NUMBER() OVER (PARTITION BY account_id ORDER BY start_date DESC) AS rn
  FROM subscriptions
  WHERE 
    is_trial = false
),
-- Ranking churn events to be able to pull only the latest one for churn reason analysis, aligning approach with latest subscription calculations
last_churn AS (
  SELECT 
    account_id, 
    reason_code,
    ROW_NUMBER() OVER (PARTITION BY account_id ORDER BY churn_date DESC) AS rn
  FROM churn_events
)
-- Combining metrics to analyze churn distribution and MRR impact by reason code
SELECT
  COALESCE(lc.reason_code,'no_data') AS reason_code,
  COUNT(*) AS churn_count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct_of_total_churn,
  ROUND(SUM(ls.mrr_amount), 2) AS lost_mrr,
  ROUND(AVG(ls.mrr_amount), 2) AS avg_mrr_lost
FROM churned_accounts ca
LEFT JOIN last_churn lc ON 
  ca.account_id = lc.account_id
  AND lc.rn = 1
LEFT JOIN last_sub ls ON 
  ca.account_id = ls.account_id
  AND ls.rn = 1
GROUP BY reason_code
ORDER BY lost_mrr DESC
