# E-Commerce Sales Dashboard
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-blue?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Power BI](https://img.shields.io/badge/Power%20BI-Desktop-yellow?logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)

An end-to-end data analytics project built with **PostgreSQL** and **Power BI** — covering data ingestion, star schema modeling, SQL analysis, and an interactive business intelligence dashboard.

---

## Dashboard Preview

<img width="1340" height="754" alt="image" src="https://github.com/user-attachments/assets/ffd2fc1e-3a19-443c-9c6f-8b91b6247a9c" />

---
## Model View

<img width="1049" height="772" alt="image" src="https://github.com/user-attachments/assets/5afa20bc-8495-4021-941a-997619192129" />



---

## Tech Stack

| Tool | Purpose |
|------|---------|
| PostgreSQL 15 | Database, star schema, SQL analysis |
| Power BI Desktop | Dashboard, DAX measures, visualizations |
| Power Query | Data transformation and cleaning |
| DAX | KPI measures, time intelligence |

---

## Dataset

- **Source:** E-Commerce Sales Dataset
- **Rows:** 9,799 records
- **Columns:** 18 fields
- **Years:** 2015 – 2018
- **Fields:** Order ID, Order Date, Ship Date, Ship Mode, Customer, Segment, Region, Category, Sub-Category, Product, Sales

---

## Project Structure

```
ecommerce-sales-dashboard/
│
├── sql/
│   ├── 01_star_schema_creation.sql     # Dimension and fact table creation
│   └── 02_all_queries.sql        # KPI queries, window functions, RFM
│
├── screenshots/
│   └── dashboard.png          # Final dashboard screenshot
│
├── ecommerce.csv              # Source dataset
├── sales_dashboard.pbix       # Power BI file
└── README.md
```

---

## Data Model

Star schema with one fact table and four dimension tables:

```
dim_date ──────┐
dim_customer ──┤
               ├──▶ fact_sales
dim_product ───┤
dim_geography ─┘
```

- **fact_sales** — 9,799 rows, one per order line item
- **dim_date** — continuous date spine from 2015–2018, no gaps
- **dim_customer** — unique customers with segment
- **dim_product** — unique products with category and sub-category
- **dim_geography** — city, state, region, country

---

## SQL Analysis

Queries written across three areas:

**Aggregations**
- Total revenue, orders, unique customers by year
- Revenue by category, sub-category, region, segment

**Window Functions**
- Month-over-month growth using `LAG()`
- Revenue running total using `SUM() OVER()`
- Category share using `PARTITION BY`

**Advanced**
- Customer RFM analysis (Recency, Frequency, Monetary)
- Shipping mode performance with average ship days
- Top 10 products by revenue

---

## Dashboard Features

- **KPI Cards** — Total Revenue, Total Orders, Avg Order Value, Unique Customers with YoY comparison
- **Monthly Revenue Trend** — line chart with area fill
- **Revenue by Category** — horizontal bar chart
- **Revenue by Sub-Category** — Top N filtered bar chart
- **Revenue by Segment** — horizontal bar chart
- **Revenue by Region** — column chart
- **Top Products Table** — ranked by total revenue
- **Orders by Ship Mode** — column chart
- **Slicers** — Region, Segment, Month, Year with reset button

---

## Key Findings

- **Technology** is the top revenue category, followed closely by Furniture and Office Supplies
- **West region** generates the highest revenue across all years
- **Consumer segment** accounts for the largest share of orders
- **Standard Class** is the dominant shipping mode, used in over half of all orders
- Revenue shows a consistent upward trend toward Q4 each year

---
