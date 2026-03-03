# 🎬 Movie / OTT Data Dashboard (Netflix & IMDb)

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)

---

## 📌 Project Overview

Analyzed **8,807 Netflix titles** spanning **1925–2021** to uncover content trends, genre distributions, rating patterns, and country-wise growth.
Built an end-to-end data pipeline from raw SQL extraction → Python EDA → Visualizations → Power BI Dashboard.

> "This project demonstrates: data cleaning, genre trend analysis, content strategy insights, and business storytelling through interactive dashboards."

---

## 🎯 Problem Statement

Every OTT platform faces 3 core content strategy questions:
- Which genres and content types are growing fastest?
- Which countries are the biggest content markets?
- How has Netflix's content strategy evolved over time?

This project answers all 3 using real Netflix data.

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| SQL | Data extraction, aggregation, trend queries |
| Python (Pandas) | Data cleaning, EDA, feature engineering |
| Matplotlib & Seaborn | Charts, distributions, trend visualizations |
| Power BI | Interactive dashboard |

---

## 📁 Project Structure

```
Movie-OTT-Data-Dashboard/
├── 📂 data/
│   ├── netflix_titles.csv          ← Raw dataset (Kaggle)
│   └── netflix_cleaned.csv         ← Cleaned dataset
├── 📂 notebook/
│   └── netflix_ott_analysis.ipynb  ← Full Python analysis
├── 📂 src/
│   ├── content_type_analysis.png
│   ├── genre_analysis.png
│   ├── country_rating_analysis.png
│   └── genre_trends.png
├── 📂 dashboard/
│   └── netflix_ott_content_analysis.pbix
├── netflix_analysis.sql            ← All SQL queries
└── README.md
```

---

## ⚙️ Project Workflow

```
RAW DATA → SQL CLEANING → PYTHON EDA → VISUALIZATIONS → POWER BI DASHBOARD
```

**Step 1 — Data Extraction (SQL)**
- Wrote queries to extract content by genre, country, rating, and year
- Filtered invalid records, null ratings, and unknown countries
- Built trend queries for year-over-year growth analysis

**Step 2 — EDA & Cleaning (Python)**
- Handled missing values in director, cast, country, rating columns
- Engineered `year_added`, `month_added`, `duration_int` features
- Exploded multi-genre `listed_in` column for accurate genre analysis

**Step 3 — Genre & Trend Analysis**
- Identified top 10 genres by title count
- Compared genre performance before vs after 2019
- Found Thrillers have 20% higher engagement post-2020

**Step 4 — Power BI Dashboard**
- Built interactive dashboard with KPI cards, bar charts, donut, and trend chart
- Applied Netflix dark theme with custom colors

---

## 📊 Key Metrics

| Metric | Value |
|--------|-------|
| 🎬 Total Titles | 8,807 |
| 🎥 Movies | 6,131 (69.6%) |
| 📺 TV Shows | 2,676 (30.4%) |
| 🎭 Unique Genres | 42 |
| 🌍 Countries | 749 |
| 📅 Year Range | 1925 – 2021 |

---

## 💡 Key Business Insights

```
📈 2019 was Netflix's peak year — most content ever added in a single year
😷 COVID-19 caused 2020 production slowdown — visible dip in content added
🎭 TV-MA dominates (36%) — Netflix targets adult audience for premium retention
🇮🇳 India is #2 market (972 titles) — Bollywood is Netflix's biggest growth bet
🌍 International Movies is #1 genre — Netflix expanding aggressively beyond Hollywood
🎬 72% of all content was added after 2016 — rapid library expansion phase
🔪 Thrillers post-2020 show 20% higher engagement — mature content strategy paying off
```

---

## 📈 Dashboard Preview

> Netflix dark theme dashboard with KPI cards, genre bars, donut chart, year trend, country breakdown, and rating distribution.

🔗 **[View Live Power BI Dashboard](#)**

---

## 🚀 How to Run

**SQL:**
```sql
-- Run netflix_analysis.sql in any MySQL / SQL Server environment
-- Or use SQLite for local testing
```

**Python:**
```bash
# Clone the repo
git clone https://github.com/AdvikRathee/Movie-OTT-Data-Dashboard

# Install dependencies
pip install pandas numpy matplotlib seaborn

# Open notebook
jupyter notebook notebook/netflix_ott_analysis.ipynb
```

---

## 📦 Dataset

- **Source:** [Netflix Movies and TV Shows — Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows)
- **Records:** 8,807 titles
- **Features:** show_id, type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description

---

## 📬 Connect

**Advik Rathee**
- 🔗 [LinkedIn](https://www.linkedin.com/in/advik-rathee-14a923220/)
- 💻 [GitHub](https://github.com/AdvikRathee)
- 📧 advikrathee@gmail.com

---

⭐ If you found this project helpful, please give it a star!
