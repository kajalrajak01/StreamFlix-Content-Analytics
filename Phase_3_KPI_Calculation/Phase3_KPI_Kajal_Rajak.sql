-- =================================================================================
-- Phase 3 — KPI Calculation & Cohort Retention Analysis
-- =================================================================================

-- KPI 1 — Total Watch Hours
CREATE OR REPLACE VIEW public.kpi_total_watch_hours AS
SELECT
    ROUND(
        (SUM(watch_duration_min) / 60.0)::numeric,
        2
    ) AS total_watch_hours
FROM public.watch_history;

SELECT * FROM public.kpi_total_watch_hours;

-- KPI 2 — Active Rate
CREATE OR REPLACE VIEW public.kpi_active_rate AS
SELECT
    COUNT(*) FILTER (WHERE is_active = TRUE) AS active_subscribers,
    COUNT(*) AS total_subscribers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE is_active = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS active_rate_pct
FROM public.subscribers;

SELECT * FROM public.kpi_active_rate;

-- KPI 3 — Churn Rate
CREATE OR REPLACE VIEW public.kpi_churn_rate AS
SELECT
    COUNT(*) FILTER (WHERE is_active = FALSE) AS inactive_subscribers,
    COUNT(*) AS total_subscribers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE is_active = FALSE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM public.subscribers;

SELECT * FROM public.kpi_churn_rate;

-- KPI 4 — Average Completion Rate
CREATE OR REPLACE VIEW public.kpi_avg_completion_rate AS
SELECT
    ROUND(AVG(completion_pct)::numeric, 2)
        AS avg_completion_rate_pct
FROM public.watch_history;

SELECT * FROM public.kpi_avg_completion_rate;

-- KPI 5 — Monthly Recurring Revenue (MRR)
CREATE OR REPLACE VIEW public.kpi_monthly_recurring_revenue AS
SELECT
    ROUND(SUM(monthly_price_usd)::numeric, 2)
        AS monthly_recurring_revenue_usd
FROM public.subscribers
WHERE is_active = TRUE;

SELECT * FROM public.kpi_monthly_recurring_revenue;

-- KPI 6 — Average Revenue Per Active User (ARPU)
CREATE OR REPLACE VIEW public.kpi_arpu AS
SELECT
    ROUND(
        SUM(monthly_price_usd)::numeric
        / NULLIF(COUNT(*), 0),
        2
    ) AS arpu_usd
FROM public.subscribers
WHERE is_active = TRUE;

SELECT * FROM public.kpi_arpu;

-- KPI 7 — Average Watch Time per Active Subscriber
CREATE OR REPLACE VIEW public.kpi_avg_watch_time_per_subscriber AS
SELECT
    ROUND(
        (
            SELECT SUM(watch_duration_min) / 60.0
            FROM public.watch_history
        )::numeric
        / NULLIF(
            (
                SELECT COUNT(*)
                FROM public.subscribers
                WHERE is_active = TRUE
            ),
            0
        ),
        2
    ) AS avg_watch_hours_per_active_subscriber
;

SELECT * FROM public.kpi_avg_watch_time_per_subscriber;

-- KPI 8 — Watchlist Conversion Rate
CREATE OR REPLACE VIEW public.kpi_watchlist_conversion AS
SELECT
    COUNT(*) FILTER (WHERE watched = TRUE) AS watched_entries,
    COUNT(*) AS total_watchlist_entries,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE watched = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS watchlist_conversion_pct
FROM public.watchlist;

SELECT * FROM public.kpi_watchlist_conversion;

-- KPI 9 — Hit Concentration
CREATE OR REPLACE VIEW public.kpi_hit_concentration AS
WITH ranked_titles AS (
    SELECT
        title_id,
        total_plays,
        NTILE(10) OVER (
            ORDER BY total_plays DESC NULLS LAST, title_id
        ) AS popularity_decile
    FROM public.titles
),
play_totals AS (
    SELECT
        SUM(total_plays) AS all_title_plays,
        SUM(total_plays) FILTER (
            WHERE popularity_decile = 1
        ) AS top_10_pct_title_plays
    FROM ranked_titles
)
SELECT
    top_10_pct_title_plays,
    all_title_plays,
    ROUND(
        100.0 * top_10_pct_title_plays
        / NULLIF(all_title_plays, 0),
        2
    ) AS hit_concentration_pct
FROM play_totals;

SELECT * FROM public.kpi_hit_concentration;

-- KPI 10 — Originals Share of Watch Hours

CREATE OR REPLACE VIEW public.kpi_originals_share_of_hours AS
SELECT
    ROUND(
        (
            SUM(
                CASE
                    WHEN t.is_original = TRUE
                    THEN wh.watch_duration_min
                    ELSE 0
                END
            ) * 100.0
            / NULLIF(SUM(wh.watch_duration_min), 0)
        )::numeric,
        2
    ) AS originals_share_of_hours_pct
FROM public.watch_history wh
JOIN public.titles t
    ON wh.title_id = t.title_id;

SELECT * FROM public.kpi_originals_share_of_hours;

-- Intermediate Challenge — Cohort Retention Analysis (Optional Bonus)
WITH subscriber_cohorts AS (
    SELECT
        subscriber_id,
        DATE_TRUNC('month', signup_date)::date AS cohort_month,
        signup_date,
        churn_date
    FROM public.subscribers
    WHERE signup_date IS NOT NULL
),
cohort_retention AS (
    SELECT
        cohort_month,
        COUNT(*) AS cohort_size,
        ROUND(
            100.0 * COUNT(*) FILTER (
                WHERE churn_date IS NULL
                   OR churn_date > signup_date + INTERVAL '3 months'
            ) / COUNT(*),
            2
        ) AS retention_3m_pct,
        ROUND(
            100.0 * COUNT(*) FILTER (
                WHERE churn_date IS NULL
                   OR churn_date > signup_date + INTERVAL '6 months'
            ) / COUNT(*),
            2
        ) AS retention_6m_pct,
        ROUND(
            100.0 * COUNT(*) FILTER (
                WHERE churn_date IS NULL
                   OR churn_date > signup_date + INTERVAL '12 months'
            ) / COUNT(*),
            2
        ) AS retention_12m_pct
    FROM subscriber_cohorts
    GROUP BY cohort_month
)
SELECT *
FROM cohort_retention
ORDER BY cohort_month;