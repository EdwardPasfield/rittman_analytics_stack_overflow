

WITH base AS (
  SELECT
    question_key,
    tag_key,
    COALESCE(tag_name, 'untagged') AS tag_name,
    creation_month,
    view_count,
    score
  FROM `rittman-analytics-ed-pasfield`.`dev`.`fct_questions`
  WHERE unanswered_flag
),
monthly AS (
  SELECT
    creation_month,
    tag_key,
    tag_name,
    COUNT(*) AS unanswered_questions,
    SUM(view_count) AS total_views,
    AVG(view_count) AS avg_view_count,
    MIN(view_count) AS min_view_count,
    MAX(view_count) AS max_view_count,
    AVG(score) AS avg_score,
    MIN(score) AS min_score,
    MAX(score) AS max_score
  FROM base
  GROUP BY creation_month, tag_key, tag_name
)

SELECT
  creation_month,
  tag_key,
  tag_name,
  unanswered_questions,
  total_views,
  avg_view_count,
  min_view_count,
  max_view_count,
  avg_score,
  min_score,
  max_score,
  ROUND(AVG(avg_view_count) OVER (
    PARTITION BY tag_key
    ORDER BY creation_month
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
  ), 2) AS rolling_3m_avg_view,
  AVG(avg_view_count) OVER (
    PARTITION BY tag_key
    ORDER BY creation_month
    ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
  ) AS rolling_6m_avg_view
FROM monthly