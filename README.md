# 📊 Customer Churn Analysis & Retention Dashboard

An end-to-end data analytics project that identifies why customers are churning, quantifies the revenue impact, and delivers actionable retention recommendations — using Python, SQL, and Power BI.

---

## 🧩 Business Problem

The company is losing **26.54% of its customers** (1,869 out of 7,043), resulting in an estimated **$139,131 in lost monthly recurring revenue** (~$1.67M annually). This project answers four core business questions:

- Why are customers churning?
- Which customer segments are most at risk?
- How much revenue is being lost?
- What should the business do to improve retention?

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| Python (Pandas, NumPy, Matplotlib) | Data cleaning, feature engineering, EDA |
| MySQL / MySQL Workbench | Relational database, SQL analysis |
| Power BI | Interactive dashboard & DAX measures |
| Google Colab | Development environment |
| GitHub | Version control & portfolio hosting |

---

## 🔄 Project Workflow
---
Dataset → Data Cleaning (Python) → EDA → Export Clean Dataset 
→ MySQL → SQL Analysis → Power BI Dashboard → Business Recommendations

## 📁 Dataset

**Source:** IBM Telco Customer Churn dataset (enhanced version, 11.1.3+) — [Kaggle Dataset](https://www.kaggle.com/datasets/alfathterry/telco-customer-churn-11-1-3)
**Size:** 7,043 customers × 54 columns (after feature engineering)
**Scope:** California, USA

Key fields include demographics (Age, Gender, Dependents), account details (Contract, Payment Method, Tenure), service usage (Internet Type, Streaming, Support add-ons), and churn detail (Churn Label, Churn Category, Churn Reason, Satisfaction Score).

---

## 🧹 Data Cleaning (Python)

- Standardized column names for SQL compatibility
- Handled structural nulls correctly (e.g., `Churn_Reason` is legitimately blank for non-churned customers — not a data quality issue)
- Converted categorical fields to proper types
- Engineered new features: `Tenure_Group`, `Age_Group`, `Churned` (binary flag), `Had_Refund`
- Verified zero duplicate records and zero negative/invalid values

📓 Full notebook: [`notebooks/Customer_Churn_Analysis.ipynb`](notebooks/Customer_Churn_Analysis.ipynb)

---

## 📈 Key Insights

1. **Contract type is the #1 churn driver** — Month-to-Month customers churn at **45.84%** vs **2.55%** for Two-Year contracts (18x difference)
2. **Satisfaction Score is a near-perfect predictor** — 100% of customers rating satisfaction 1–2 churned; 0% of those rating 4–5 did
3. **45% of all churn is competitor-driven** — more than double the next most common cause
4. **First-year customers churn at 47.4%**, compared to just 6.6% for customers with 5+ years of tenure
5. **Churned customers pay MORE, not less** — $74.44/month average vs $61.27/month for retained customers
6. **Manual payment methods churn 2x more** than credit card auto-pay (36.9% / 34.0% vs 14.5%)
7. **Referral customers churn less** — 19.4% vs 32.6% for non-referrers
8. **Customers aged 60+ churn at 36.5%**, notably higher than younger age groups (22–24%)
9. Gender and geographic location show **no meaningful effect** on churn — ruled out as drivers
10. **525 customers received refunds**, representing hidden revenue leakage independent of churn

---

## 🗄️ SQL Analysis

10 queries covering beginner → advanced SQL, including `GROUP BY`, `CASE`, `HAVING`, subqueries, `CTEs`, and window functions (`RANK`, `DENSE_RANK`, `ROW_NUMBER`).

📄 Full queries: [`sql/churn_analysis_queries.sql`](sql/churn_analysis_queries.sql)

**Sample finding:** Ranking churn reasons by contract type (via `ROW_NUMBER()` + `PARTITION BY`) revealed that Month-to-Month churn is overwhelmingly competitor-driven, while longer contracts churn for different, more idiosyncratic reasons — a segmentation the aggregate stats alone wouldn't reveal.

---

## 📊 Power BI Dashboard

An interactive 5-page dashboard built on 10+ DAX measures:

| Page | Purpose |
|---|---|
| **Executive Dashboard** | Company-wide health check — KPIs, churn by contract, geographic map |
| **Customer Dashboard** | Demographic & tenure segmentation |
| **Revenue Dashboard** | Financial impact — revenue by city, refund leakage, MRR at risk |
| **Churn Dashboard** | Root cause analysis — churn category, reason, satisfaction score, payment method |
| **Business Recommendations** | Data-backed action items for leadership |

![Executive Dashboard](images/executive_dashboard.png)
![Churn Dashboard](images/churn_dashboard.png)
![Customer Dashboard](images/customer_dashboard.png)
![Revenue Dashboard](images/revenue_dashboard.png)
![Recommendations](images/recommendations_page.png)

📥 Dashboard file: [`powerbi/Customer_Churn_Dashboard.pbix`](powerbi/Customer_Churn_Dashboard.pbix)

---

## 💡 Business Recommendations

1. **Incentivize contract upgrades** — target Month-to-Month customers with upgrade offers
2. **Build a real-time satisfaction alert system** — flag customers at Satisfaction Score ≤3 before they churn
3. **Launch a structured 90-day onboarding program** — first-year churn is the single largest risk window
4. **Run quarterly competitive benchmarking** — competitor offers drive nearly half of all churn
5. **Promote auto-pay enrollment** — cheapest lever with a proven churn reduction effect
6. **Expand the referral program** — dual benefit of acquisition and retention
7. **Audit support interactions** — "Attitude" complaints are internally fixable, unlike competitor-driven churn
8. **Design a senior-specific retention offer** — 60+ segment shows elevated risk
9. **Investigate refund root causes** — address revenue leakage independent of churn
10. **Prioritize retention spend on new, high-paying customers** — highest financial risk concentration

📄 Full write-up: [`docs/business_recommendations.md`](docs/business_recommendations.md)

---

## 📂 Repository Structure

```
├── data/                # Raw and cleaned datasets
├── notebooks/           # Python data cleaning & EDA
├── sql/                 # SQL analysis queries
├── powerbi/             # Power BI dashboard file (.pbix)
├── images/              # Dashboard screenshots
├── docs/                # Business recommendations document
└── README.md
```

## 👤 Author

**Aditya Nath Pandey**
[LinkedIn](https://www.linkedin.com/in/adityanathpandey) • adityanathpandey060904@gmail.com

---

⭐ If you found this project useful, consider giving it a star!
