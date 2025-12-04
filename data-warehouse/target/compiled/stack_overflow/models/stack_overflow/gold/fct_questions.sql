

WITH base AS (
  SELECT
    question_key,
    question_id,
    DATE_TRUNC(question_date, MONTH) AS question_month,
    question_date,
    creation_date,
    view_count,
    score,
    answer_count,
    comment_count,
    unanswered_flag
  FROM `rittman-analytics-ed-pasfield`.`dev`.`dim_questions`
),
tag_lookup AS (
  SELECT
    b.question_key,
    b.tag_key,
    dt.tag_name
  FROM `rittman-analytics-ed-pasfield`.`dev`.`dim_question_tag_bridge` b
  LEFT JOIN `rittman-analytics-ed-pasfield`.`dev`.`dim_tags` dt
    ON b.tag_key = dt.tag_key
)

SELECT
  b.question_key,
  tl.tag_key,
  b.question_id,
  COALESCE(tl.tag_name, 'untagged') AS tag_name,
  b.question_date,
  b.creation_date,
  DATE_TRUNC(b.creation_date, MONTH) AS creation_month,
  b.view_count,
  b.score,
  b.answer_count,
  b.comment_count,
  b.unanswered_flag
FROM base b
LEFT JOIN tag_lookup tl
  ON b.question_key = tl.question_key