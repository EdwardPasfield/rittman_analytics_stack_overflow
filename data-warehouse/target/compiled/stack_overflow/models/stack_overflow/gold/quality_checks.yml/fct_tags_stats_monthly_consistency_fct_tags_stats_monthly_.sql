

WITH consistency_checks AS (
  SELECT
    creation_month,
    tag_key,
    tag_name,
    unanswered_questions,
    monthly_view_count,
    monthly_score,
    avg_view_count,
    avg_score,
    -- Check if averages are consistent with sums/counts (allowing for rounding)
    ABS(avg_view_count - (monthly_view_count / NULLIF(unanswered_questions, 0))) AS view_diff,
    ABS(avg_score - (monthly_score / NULLIF(unanswered_questions, 0))) AS score_diff
  FROM `rittman-analytics-ed-pasfield`.`dev`.`fct_tags_stats_monthly`
)

SELECT *
FROM consistency_checks
WHERE
  -- Data quality checks
  unanswered_questions <= 0
  OR monthly_view_count < 0
  -- Consistency checks (allow small rounding differences)
  OR view_diff > 0.01
  OR score_diff > 0.01
  -- Time range check (not in future, not before Stack Overflow launch)
  OR CAST(creation_month AS DATE) > CURRENT_DATE()
  OR CAST(creation_month AS DATE) < DATE('2008-08-01')

