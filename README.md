# 👮‍♂️ US Police Incident Data Engineering Pipeline

An end-to-end Data Engineering pipeline designed to ingest, clean, and model real-world US police incident data using **Snowflake, dbt, and Power BI**. This project transforms messy transactional logs into automated, business-ready analytical data marts built on a modular **Kimball Star Schema** architecture.

---

## 🛠️ Architecture & Tech Stack

**Cloud Storage (Data Lake Layer):** AWS S3 (Stores raw semi-structured and CSV incident logs)
* **Data Warehouse:** Snowflake (Analytical Compute Layer)
* **Transformation & Modeling (ETL/ELT):** dbt (Data Build Tool Core)
* **Business Intelligence:** Power BI (Reporting & Trend Dashboards)
* **Languages:** SQL (Advanced Window Functions, Aggregations)

---
## 🔄 Data Pipeline Flow
AWS S3 (Raw Data Lake) ➔ Snowflake Stage (Data Warehouse Ingestion) ➔ dbt Core (Star Schema Transformation) ➔ Power BI (Business Intelligence)

## 📐 Data Modeling Architecture (Star Schema)

The raw transactional logs were processed and structured into **4 core analytical data marts (Dimensional Models)** inside Snowflake to optimize querying speed and simplify dashboard reporting:

1. **`fct_incident_severity`**  
   * *Purpose:* Classifies and indexes crimes into High, Medium, or Low severity based on offense categories. Handles missing baseline codes safely using `COALESCE`.
2. **`fct_monthly_district_trends`**  
   * *Purpose:* Provides a Month-on-Month (MoM) breakdown of total crimes mapped against police districts to analyze seasonal crime waves.
3. **`fct_district_unresolved_cases`**  
   * *Purpose:* Identifies active or pending investigation rates across locations, enabling law enforcement to deploy patrolling resources efficiently.
4. **`fct_yearly_crime_growth`**  
   * *Purpose:* Calculates Year-over-Year (YoY) variance in crime rates. Utilizes advanced SQL **Window Functions (`LAG() OVER`)** to dynamically fetch historical baselines.

---

## 🚀 Key Data Engineering Highlights

* **Data Quality Assured:** Implemented dbt Schema tests (`not_null`, `unique`) to guarantee data integrity across critical primary keys like `Incident_ID`.
* **Dynamic Time Series:** Leveraged `EXTRACT` and time-travel functions to standardize cross-year analytics (2018–2021).
* **Optimization:** Used incremental-like modeling logic to isolate dimensions from heavy factual tables, cutting down query scanning costs in Snowflake.

---

## 📊 Business Impact & Analytics

The curated metrics from dbt were funneled into **Power BI Desktop**, visualizing core behavioral insights such as:
* The sudden, massive dip in overall metropolitan crime rates during 2020 (Correlating to COVID-19 lock-downs via the YoY Trend Line).
* Geographic hotspots requiring immediate tactical budget scaling.

---

## 📂 How to Run This Project

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/YOUR_USERNAME/police-incident-data-pipeline.git](https://github.com/YOUR_USERNAME/police-incident-data-pipeline.git)
