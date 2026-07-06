# 👮‍♂️ US Police Incident Data Engineering Pipeline

An end-to-end Data Engineering pipeline designed to ingest, clean, and model real-world US police incident data using **AWS (S3), Snowflake, dbt, and Power BI**. This project transforms messy transactional logs from a consolidated base layer into automated, business-ready analytical data marts using an efficient **One Big Table (OBT) to Analytical Marts** architecture.

---

## 🛠️ Architecture & Tech Stack

* **Cloud Storage (Data Lake Layer):** AWS S3 (Stores raw semi-structured and CSV incident logs)
* **Data Warehouse:** Snowflake (Analytical Compute Layer)
* **Transformation & Modeling (ETL/ELT):** dbt (Data Build Tool Core)
* **Business Intelligence:** Power BI (Reporting & Trend Dashboards)
* **Languages:** SQL (Advanced Window Functions, Aggregations)

---

## 🔄 Data Pipeline Flow
AWS S3 (Raw Data Lake) ➔ Snowflake Stage (Single Base OBT View) ➔ dbt Core (Analytical Marts Transformation) ➔ Power BI (Business Intelligence)

---

## 📐 Data Modeling Architecture (OBT to Analytical Marts)

Instead of complex multi-table joins at the BI layer, the project utilizes a optimized **One Big Table (OBT)** base view to directly derive **4 core analytical data marts** inside Snowflake. This reduces query scanning costs and accelerates dashboard rendering:

1. **`fct_incident_severity`**  
   * *Purpose:* Classifies and indexes crimes into High, Medium, or Low severity based on offense categories. Handles missing baseline codes safely using `COALESCE`.
2. **`fct_monthly_district_trends`**  
   * *Purpose:* Provides a Month-on-Month (MoM) breakdown of total crimes mapped against police districts to analyze seasonal crime waves.
3. **`fct_district_unresolved_cases`**  
   * *Purpose:* Identifies active or pending investigation rates across locations, enabling law enforcement to deploy patrolling resources efficiently.
4. **`fct_yearly_crime_growth`**  
   * *Purpose:* Calculates Year-over-Year (YoY) variance in crime rates. Utilizes advanced SQL **Window Functions (`LAG() OVER`)** to dynamically fetch historical baselines from the base layer.

---

## 🚀 Key Data Engineering Highlights

* **Data Quality Assured:** Implemented dbt Schema tests (`not_null`, `unique`) to guarantee data integrity across critical primary keys like `Incident_ID`.
* **Dynamic Time Series:** Leveraged `EXTRACT` and time-travel functions to standardize cross-year analytics (2018–2021).
* **Optimization:** Transformed data directly from a single centralized base view into specific factual marts, cutting down redundant staging table overheads in Snowflake.

---

## 📊 Business Impact & Analytics

The curated metrics from dbt were funneled into **Power BI Desktop**, visualizing core behavioral insights such as:
* The sudden, massive dip in overall metropolitan crime rates during 2020 (Correlating to COVID-19 lockdowns via the YoY Trend Line).
* Geographic hotspots requiring immediate tactical budget scaling.

---

## 📂 How to Run This Project

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/YOUR_USERNAME/police-incident-data-pipeline.git](https://github.com/YOUR_USERNAME/police-incident-data-pipeline.git)
