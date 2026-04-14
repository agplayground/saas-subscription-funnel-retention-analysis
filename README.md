Note: the datasets used within this project are synthetic, generated specifically for SaaS analytics practices.

## Business Problem

RavenStack is a SaaS startup delivering AI-driven team tools. The product was piloted with coding bootcamp graduates. The leadership team is observing a high permanent churn rate and is concerned regarding the issues before the upcoming public launch. This analysis aims to:

- How many users churned and never came back
- Identify why those users are churning out and if the drop is steady or growing
- Provide recommendations to improve user retention before the publich launch

## Tools & Methods

- SQL (BigQuery) for churned accounts identification and breakdowns for (1) lost MRR by churn reason code and (2) churned accounts by month
- Python (pandas & matplotlib) for creating visualizations for lost MRR by churn reason code and churned accounts by month

## Findings

- Out of 500 users who signed up (in this case all signed up users also converted) 110 churned and never came back
- 35 users are marked as churned, but don't have a churn_event record
- The remaining 75 permanently churned users left primarily due to budget, features, pricing and support reasons
- From the timeline perspective, churn started growing fast since 2024-08

## Recommendations



## Next Steps
