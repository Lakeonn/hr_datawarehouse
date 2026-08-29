# 🏢 HR Data Warehouse  
### Medallion Architecture • SQL Server • ETL Automation

A modular, scalable HR analytics warehouse built on a **Bronze → Silver → Gold** pipeline with SQL Server and Python ETL.

---

## 📦 Overview

This project implements a complete **Medallion Architecture** for HR data:

- **Bronze** — raw ingestion from CSVs and external sources  
- **Silver** — cleaned, standardized, enriched relational tables  
- **Gold** — business‑ready dimensional models for analytics  
- **Master Load Procedure** — orchestrates the entire pipeline with logging  

The goal is to provide a clean, reproducible, enterprise‑grade HR data warehouse.

---

## 🏗️ Architecture

### 🔹 Bronze Layer  
Raw staging tables loaded directly from CSVs or external sources.  
No transformations, no business logic — pure ingestion.

### 🔸 Silver Layer  
Cleaned and transformed data including:

- Type normalization  
- Deduplication  
- Column standardization  
- Data quality checks  
- Referential integrity fixes  

### 🟡 Gold Layer  
Final analytical models:

- Dimensions  
- Facts  
- Aggregations  
- Reporting tables  

### 🧠 Master Load Procedure  
A single SQL procedure that:

- Runs Bronze ingestion  
- Runs Silver transformations  
- Logs start/end time  
- Logs duration  
- Logs success/failure  
- Captures error messages  

---

## 📁 Project Structure


---

## 🧩 Key SQL Components

### **Bronze Load**
Loads raw CSVs into staging tables using `BULK INSERT` or Python ETL.

### **Silver Load**
Transforms Bronze tables into clean, relational structures.

### **Gold Models**
Creates business‑ready tables for HR analytics such as:

- Employee dimension  
- Department dimension  
- Fact tables for attendance, holidays, payroll, etc.  

### **Master Load**
Central orchestration procedure that:

- Executes Bronze → Silver → Gold  
- Writes ETL run logs  
- Captures errors  
- Ensures repeatability  

---

## 📝 ETL Logging Table

Tracks every pipeline execution:

| Column            | Description                          |
|-------------------|--------------------------------------|
| run_start         | Timestamp when ETL started           |
| run_end           | Timestamp when ETL finished          |
| duration_seconds  | Total runtime                        |
| status            | SUCCESS / FAILED                     |
| error_message     | Error details (if any)               |

---

## ⚙️ Requirements

### **SQL Server**
- SQL Server 2019+  
- SSMS or Azure Data Studio  

### **Python (optional ETL)**
- Python 3.10+  
- pandas  
- pyodbc  

---

## 🔧 Setup Instructions

### 1. Clone the repository

git clone https://github.com/Lakeonn/hr_datawarehouse.git



### 2. Configure SQL Server connection  
Update your Python ETL scripts with your connection string.

### 3. Run Bronze + Silver scripts  
Execute SQL scripts in:

/sql/bronze
/sql/silver


### 4. Run Master Load

EXEC dwh.master_load;


---

## 🧪 Testing the Pipeline

1. Drop Bronze tables  
2. Re‑run master load  
3. Check `etl_run_log`  
4. Validate row counts in Silver/Gold  
5. Confirm transformations applied correctly  

---

## 📜 Git Hygiene

This project uses a strict `.gitignore` to prevent:

- CSVs  
- Jupyter checkpoints  
- Python cache  
- Secrets  
- SQL Server backups  

Only SQL scripts, Python ETL, and documentation are tracked.

---

## 📈 Roadmap

- Add row‑count logging per table  
- Add Power BI dashboard for ETL monitoring  
- Add automated email alerts on ETL failure  
- Add CI/CD deployment pipeline  
- Add data quality scoring in Silver layer  

---

## 👤 Author

**Olalekan**  
Founder & Technical Consultant — Letovie Consulting  
Building AfroVendors / AfriFind marketplace platform  

---
