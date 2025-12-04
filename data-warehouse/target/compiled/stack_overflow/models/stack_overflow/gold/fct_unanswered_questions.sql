

WITH metric AS (
  SELECT
    b.question_key,
    b.tag_key,
    dq.question_id,
    dt.tag_name,
    dq.time_key,
    dq.question_date,
    dq.view_count,
    dq.score,
    dq.answer_count,
    dq.comment_count,
    dq.unanswered_flag
  FROM `rittman-analytics-ed-pasfield`.`dev`.`dim_question_tag_bridge` b
  JOIN `rittman-analytics-ed-pasfield`.`dev`.`dim_questions` dq
    ON b.question_key = dq.question_key
  JOIN `rittman-analytics-ed-pasfield`.`dev`.`dim_tags` dt
    ON b.tag_key = dt.tag_key
)

SELECT
  question_key,
  tag_key,
  question_id,
  tag_name,
  time_key,
  question_date,
  view_count,
  score,
  answer_count,
  comment_count,
  unanswered_flag
FROM metric