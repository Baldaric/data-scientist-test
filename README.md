# data-scientist-test

This repository contains the structure and setup for the data science take-home test, which includes:

 - A. SQL Analytics
 - B. Python Modeling
 - C. R Statistical Validation

## Folder Structure
```
├── data/
│   ├── credit_scoring.csv
|   ├── e_commerce_transactions.csv
│   └── predictions.csv
├── notebooks/
│   ├── B_modeling.ipynb
|   ├── decision_slide.pdf
|   ├── requirements.txt
|   └── shap_summary.png
├── analysis.sql              # Bagian A
├── validation.R              # Bagian C
├── A_findings.md             # Anomali (max 150 kata)
├── C_summary.md              # Cut-off (max 100 kata)
├── calibration_curve.png     # Curve hasil validasi R
└── README.md                 # Cara run project
```
## Status

- [x] Folder structure initialized
- [x] SQL analysis in progress
- [x] Python modeling in progress
- [x] R validation in progress
### ALL COMPLETED

## 🧪 How to Run

### Part A – SQL
- Run `analysis.sql` using any PostgreSQL-compatible environment.
- Summary is in `A_findings.md`.

### Part B – Python
- Run `notebooks/B_modeling.ipynb` using Jupyter or VSCode.
- Model outputs `predictions.csv` and `decision_slide.pdf`.

### Part C – R
- Open R or RStudio.
- Set working directory to repo root:
  ```r
  setwd("your/path/to/repo")
  source("validation.R")
  ```
- Outputs calibration_curve.png and HL test result to console.

## Notes
 - All results use only the allowed environment: Python ≥ 3.11, R 4.3.
 - Leakage features were correctly removed before modeling.
 - HL test and calibration curve validate model calibration.

## Author
### Affan Haidar Anitya
[Github](https://github.com/Baldaric)