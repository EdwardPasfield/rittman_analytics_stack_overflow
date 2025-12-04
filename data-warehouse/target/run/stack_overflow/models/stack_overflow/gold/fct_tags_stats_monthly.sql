
  
    

    create or replace table `rittman-analytics-ed-pasfield`.`dev`.`fct_tags_stats_monthly`
      
    partition by date_trunc(creation_month, month)
    cluster by tag_key

    OPTIONS()
    as (
      

WITH base AS (
  SELECT
    dq.question_key,
    qtb.tag_key,
    COALESCE(dt.tag_name, 'untagged') AS tag_name,
    DATE_TRUNC(dq.creation_date, MONTH) AS creation_month,
    dq.view_count,
    dq.score
  FROM `rittman-analytics-ed-pasfield`.`dev`.`dim_questions` dq
  LEFT JOIN `rittman-analytics-ed-pasfield`.`dev`.`dim_question_tag_bridge` qtb
    ON dq.question_key = qtb.question_key
  LEFT JOIN `rittman-analytics-ed-pasfield`.`dev`.`dim_tags` dt
    ON qtb.tag_key = dt.tag_key
  WHERE dq.unanswered_flag
),

monthly AS (
  SELECT
    creation_month,
    tag_key,
    tag_name,
    COUNT(*) AS unanswered_questions,
    COUNT(DISTINCT question_key) AS number_of_questions_mentioned_on,
    SUM(view_count) AS monthly_view_count,
    SUM(score) AS monthly_score,
    AVG(view_count) AS avg_view_count,
    AVG(score) AS avg_score
  FROM base
  GROUP BY creation_month, tag_key, tag_name
)

  SELECT
    creation_month,
    tag_key,
    tag_name,
    unanswered_questions,
    number_of_questions_mentioned_on,
    monthly_view_count,
    monthly_score,
    avg_view_count,
    avg_score,
    ROUND(avg_score - LAG(avg_score) OVER (
      PARTITION BY tag_key
      ORDER BY creation_month
    ), 2) AS delta_1m_score,
    ROUND(avg_score - LAG(avg_score, 3) OVER (
      PARTITION BY tag_key
      ORDER BY creation_month
    ), 2) AS delta_3m_score,
    ROUND(avg_score - LAG(avg_score, 6) OVER (
      PARTITION BY tag_key
      ORDER BY creation_month
    ), 2) AS delta_6m_score,
    ROUND(avg_view_count - LAG(avg_view_count) OVER (
      PARTITION BY tag_key
      ORDER BY creation_month
    ), 2) AS delta_1m_view,
    ROUND(avg_view_count - LAG(avg_view_count, 3) OVER (
      PARTITION BY tag_key
      ORDER BY creation_month
    ), 2) AS delta_3m_view,
    ROUND(avg_view_count - LAG(avg_view_count, 6) OVER (
      PARTITION BY tag_key
      ORDER BY creation_month
    ), 2) AS delta_6m_view,
FROM monthly
    );
  