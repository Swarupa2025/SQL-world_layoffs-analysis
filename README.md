# Layoffs Data Cleaning and Exploratory Data Analysis (EDA)

This project covers a full SQL workflow starting from **data cleaning** to **exploratory data analysis (EDA)** using a real-world layoffs dataset.

The goal of this project is to clean the dataset, handle duplicates and missing values correctly, and then perform insightful EDA to identify key trends, top affected companies, industries, countries, and time-based patterns.

---

## 📂 Project Structure
- **Data Cleaning:** `layoffs_data_cleaning.sql`
    - Removal of duplicates using window functions.
    - Standardization of categorical fields.
    - Proper handling of `NULL` values and blank entries.
    - Date corrections and format conversions.
- **Exploratory Data Analysis:** `layoffs_eda.sql`
    - Identifying maximum layoffs and highest layoff percentages.
    - Top companies with the largest layoffs.
    - Year-over-year and month-over-month layoff trends.
    - Industry-wise and country-wise layoff summaries.
    - Rolling totals of layoffs over time.
    - Ranking companies per year based on layoff counts.

---

## 💻 Tools Used
- MySQL Workbench
- SQL (Window functions, CTEs, Aggregate functions, Date functions)

---

## 📊 Key Insights from EDA
- Companies with the most layoffs.
- Industries most impacted by layoffs.
- Countries with the highest layoffs.
- Yearly and monthly layoff patterns.
- Top companies affected each year.

---

## 📁 Files
- `layoffs_data_cleaning.sql` – All SQL scripts for cleaning the dataset.
- `layoffs_eda.sql` – All SQL scripts for exploratory data analysis.
- `layoffs.csv` – Original raw dataset (if you choose to upload it or reference it externally).

---

## ✨ Learning Outcomes
- Data cleaning with SQL using real-world data.
- Practical use of CTEs, window functions, and aggregation for EDA.
- Handling complex data scenarios like distinguishing between real `0` values and blank entries.
- Step-by-step SQL workflow for both beginners and intermediate SQL users.

---

Feel free to explore the SQL scripts and adapt them to your own datasets. Contributions and suggestions are welcome!
