-- ============================================================
-- NETFLIX / OTT CONTENT ANALYSIS — SQL QUERIES
-- Dataset: Netflix Titles (Kaggle)
-- Author: Advik Rathee
-- Tools: SQL, Python, Power BI
-- ============================================================

-- ─────────────────────────────────────────
-- 1. DATA EXPLORATION
-- ─────────────────────────────────────────

-- Total records
SELECT COUNT(*) AS total_titles FROM netflix_titles;

-- Column overview
SELECT type, COUNT(*) AS count
FROM netflix_titles
GROUP BY type;

-- Year range
SELECT MIN(release_year) AS oldest, MAX(release_year) AS newest
FROM netflix_titles;

-- Missing values check
SELECT
  SUM(CASE WHEN director IS NULL THEN 1 ELSE 0 END) AS missing_director,
  SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS missing_country,
  SUM(CASE WHEN date_added IS NULL THEN 1 ELSE 0 END) AS missing_date,
  SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS missing_rating,
  SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS missing_duration
FROM netflix_titles;


-- ─────────────────────────────────────────
-- 2. CONTENT TYPE ANALYSIS
-- ─────────────────────────────────────────

-- Movies vs TV Shows count
SELECT
  type,
  COUNT(*) AS total,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_titles), 2) AS percentage
FROM netflix_titles
GROUP BY type
ORDER BY total DESC;


-- ─────────────────────────────────────────
-- 3. GENRE ANALYSIS
-- ─────────────────────────────────────────

-- Top 10 genres (single genre per title)
SELECT
  listed_in AS genre,
  COUNT(*) AS title_count
FROM netflix_titles
GROUP BY listed_in
ORDER BY title_count DESC
LIMIT 10;

-- Genre trend: Before vs After 2019
SELECT
  listed_in AS genre,
  SUM(CASE WHEN release_year < 2019 THEN 1 ELSE 0 END) AS before_2019,
  SUM(CASE WHEN release_year >= 2019 THEN 1 ELSE 0 END) AS after_2019
FROM netflix_titles
GROUP BY listed_in
ORDER BY after_2019 DESC
LIMIT 10;

-- Insight: Thrillers growth after 2020
SELECT
  listed_in AS genre,
  COUNT(*) AS count,
  ROUND(AVG(release_year), 0) AS avg_release_year
FROM netflix_titles
WHERE listed_in LIKE '%Thrillers%'
GROUP BY listed_in
ORDER BY count DESC;


-- ─────────────────────────────────────────
-- 4. COUNTRY ANALYSIS
-- ─────────────────────────────────────────

-- Top 10 countries by content
SELECT
  country,
  COUNT(*) AS total_titles,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_titles), 2) AS share_pct
FROM netflix_titles
WHERE country IS NOT NULL AND country != 'Unknown'
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- Movies vs TV Shows by country
SELECT
  country,
  SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) AS movies,
  SUM(CASE WHEN type = 'TV Show' THEN 1 ELSE 0 END) AS tv_shows
FROM netflix_titles
WHERE country IS NOT NULL AND country != 'Unknown'
GROUP BY country
ORDER BY movies + tv_shows DESC
LIMIT 10;


-- ─────────────────────────────────────────
-- 5. RATING ANALYSIS
-- ─────────────────────────────────────────

-- Rating distribution
SELECT
  rating,
  COUNT(*) AS total,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_titles), 2) AS share_pct
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY total DESC;

-- Rating by content type
SELECT
  rating,
  type,
  COUNT(*) AS count
FROM netflix_titles
WHERE rating IN ('TV-MA', 'TV-14', 'TV-PG', 'R', 'PG-13', 'NR')
GROUP BY rating, type
ORDER BY count DESC;


-- ─────────────────────────────────────────
-- 6. YEARLY TREND ANALYSIS
-- ─────────────────────────────────────────

-- Content added per year
SELECT
  YEAR(date_added) AS year_added,
  COUNT(*) AS titles_added,
  SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) AS movies,
  SUM(CASE WHEN type = 'TV Show' THEN 1 ELSE 0 END) AS tv_shows
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY year_added;

-- Peak year insight
SELECT
  YEAR(date_added) AS year_added,
  COUNT(*) AS titles_added
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY titles_added DESC
LIMIT 1;

-- Growth rate year over year
SELECT
  curr.year_added,
  curr.titles_added,
  prev.titles_added AS prev_year,
  ROUND((curr.titles_added - prev.titles_added) * 100.0 / prev.titles_added, 2) AS growth_pct
FROM (
  SELECT YEAR(date_added) AS year_added, COUNT(*) AS titles_added
  FROM netflix_titles
  WHERE date_added IS NOT NULL
  GROUP BY YEAR(date_added)
) curr
LEFT JOIN (
  SELECT YEAR(date_added) AS year_added, COUNT(*) AS titles_added
  FROM netflix_titles
  WHERE date_added IS NOT NULL
  GROUP BY YEAR(date_added)
) prev ON curr.year_added = prev.year_added + 1
ORDER BY curr.year_added;


-- ─────────────────────────────────────────
-- 7. DURATION ANALYSIS
-- ─────────────────────────────────────────

-- Average movie duration by genre
SELECT
  listed_in AS genre,
  ROUND(AVG(CAST(REPLACE(duration, ' min', '') AS UNSIGNED)), 0) AS avg_duration_min
FROM netflix_titles
WHERE type = 'Movie' AND duration LIKE '%min%'
GROUP BY listed_in
ORDER BY avg_duration_min DESC
LIMIT 10;

-- TV Shows by number of seasons
SELECT
  duration AS seasons,
  COUNT(*) AS show_count
FROM netflix_titles
WHERE type = 'TV Show'
GROUP BY duration
ORDER BY show_count DESC
LIMIT 10;


-- ─────────────────────────────────────────
-- 8. KEY BUSINESS INSIGHTS
-- ─────────────────────────────────────────

-- Insight 1: Netflix content explosion after 2016
SELECT
  CASE WHEN YEAR(date_added) <= 2016 THEN 'Before 2016' ELSE 'After 2016' END AS period,
  COUNT(*) AS titles
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY period;

-- Insight 2: TV-MA dominance
SELECT rating, COUNT(*) AS count
FROM netflix_titles
WHERE rating = 'TV-MA';

-- Insight 3: India as #2 market
SELECT country, COUNT(*) AS titles
FROM netflix_titles
WHERE country IN ('United States', 'India', 'United Kingdom')
GROUP BY country
ORDER BY titles DESC;

-- Insight 4: International content growth
SELECT
  YEAR(date_added) AS year,
  SUM(CASE WHEN country != 'United States' THEN 1 ELSE 0 END) AS intl_titles,
  SUM(CASE WHEN country = 'United States' THEN 1 ELSE 0 END) AS us_titles
FROM netflix_titles
WHERE date_added IS NOT NULL AND country IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY year;
