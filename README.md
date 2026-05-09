# E-Commerce Sales Dashboard

An end-to-end data analytics project built with **PostgreSQL** and **Power BI** — covering data ingestion, star schema modeling, SQL analysis, and an interactive business intelligence dashboard.

---

## Dashboard Preview

<img width="1341" height="753" alt="Executive Dashboard" src="https://github.com/user-attachments/assets/35ef8a53-e949-46b1-9abf-aedd143f15c4" />


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
│   ├── 01_setup.sql           # Database and table creation, CSV load
│   ├── 02_star_schema.sql     # Dimension and fact table creation
│   └── 03_analysis.sql        # KPI queries, window functions, RFM
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
Data Analyst | Power BI | SQL | PostgreSQL

> *Built as a portfolio project targeting Data Analyst and BI Analyst roles.*
