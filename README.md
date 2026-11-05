# Relational Database & BI Analytics Dashboard

## Project Overview

An end-to-end e-commerce analytics project using PostgreSQL, SQL, Python, and Power BI to investigate sales performance, customer behavior, and operational efficiency.

The project transforms raw transactional data into actionable business insights through relational database design, SQL analysis, exploratory data analysis, and interactive BI dashboards.

## Business Objectives

- Analyze sales and product category performance.
- Evaluate order fulfillment and delivery performance.
- Identify regional delivery bottlenecks.
- Compare seller-level operational performance.
- Investigate process variability and validate operational metrics.

## Tech Stack

| Technology | Purpose |
|---|---|
| PostgreSQL | Relational database management |
| SQL | Data querying, aggregation, and business analysis |
| Power BI | Interactive dashboards and reporting |
| DAX | KPI calculations |
| Python | Exploratory data analysis |
| Pandas | Data manipulation and analysis |
| NumPy | Numerical analysis |
| Matplotlib | Data visualization |

## Dataset

Olist Brazilian E-Commerce Public Dataset.

Nine relational tables were imported into PostgreSQL:

- Customers
- Orders
- Order Items
- Order Payments
- Order Reviews
- Products
- Sellers
- Geolocation
- Product Category Translation

The database contains 1,550,922 records across the nine tables.

## Database Design

The PostgreSQL database includes primary key and foreign key constraints to maintain relational integrity.

Key relationships include:

- Orders → Customers
- Order Items → Orders
- Order Items → Products
- Order Items → Sellers
- Order Payments → Orders
- Order Reviews → Orders

Composite primary keys were used where individual columns were not unique.

## SQL Analysis

SQL analyses included:

- Order status distribution
- Monthly sales performance
- Product category revenue analysis
- Regional delivery performance
- Seller sales performance
- Seller delivery performance
- Operational bottleneck analysis
- Process duration and variability analysis

Techniques used:

`JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`, `CTE`, `CASE WHEN`, aggregate functions and window functions where applicable.

## Key Findings

### Sales Performance

- Health & Beauty generated approximately R$1.23 million in delivered product sales.
- Watches & Gifts generated approximately R$1.17 million.
- Bed, Bath & Table had the highest number of delivered orders among the analyzed categories.

### Delivery Performance

- 96,478 orders reached delivered status.
- The cancellation rate was approximately 0.63%.
- Carrier-to-customer delivery was the longest operational stage, averaging 9.33 days.

### Regional Performance

- Alagoas (AL) had the highest observed late delivery rate among the analyzed states, at 23.93%.
- São Paulo (SP) accounted for the largest number of late deliveries, with 2,386 orders.

### Process Variability

The delivery stages showed different levels of variability:

| Stage | Mean | Median | P90 |
|---|---:|---:|---:|
| Purchase to Approval | 0.43 days | 0.01 days | 1.44 days |
| Approval to Carrier | 2.85 days | 1.85 days | 6.02 days |
| Carrier to Customer | 9.33 days | 7.10 days | 18.90 days |

## Python EDA

Python was used to:

- Inspect dataset structure and data types.
- Examine missing values and duplicate records.
- Calculate descriptive statistics.
- Evaluate operational process variability.
- Visualize delivery time distributions using boxplots.
- Independently validate SQL-derived operational metrics.

The three operational stage averages matched the corresponding SQL results when rounded to two decimal places.

## Power BI Dashboard

The Power BI report contains three pages:

1. **Executive Overview**
   - Total orders
   - Delivered orders
   - Product revenue
   - Average order value
   - Cancellation rate
   - Average delivery time
   - Monthly revenue trend

2. **Delivery & Operations**
   - Delivery performance by state
   - Late delivery rate
   - Operational stage duration
   - Seller delivery performance

3. **Product & Customer Analysis**
   - Revenue by product category
   - Orders by state
   - Payment method distribution
   - Customer review distribution

## Repository Structure

```text
ecommerce_project/
│
├── .vscode/
├── data/
│   └── raw/
├── sql/
├── scripts/
├── notebooks/
│   └── operational_eda.ipynb
├── reports/
│   ├── ecommerce_analytics_dashboard.pbix
│   └── screenshots/
└── README.md
```

## Conclusion

This project demonstrates an end-to-end analytics workflow, combining relational database design, SQL-based business analysis, Python exploratory data analysis, and interactive Power BI reporting to identify business performance patterns and operational bottlenecks.