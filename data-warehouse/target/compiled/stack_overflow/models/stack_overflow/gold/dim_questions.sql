

SELECT
  FARM_FINGERPRINT(CONCAT('question_', CAST(id AS STRING))) AS question_key,
  id AS question_id,
  creation_date,
  DATE(creation_date) AS question_date,
  view_count,
  score,
  answer_count,
  comment_count,
  owner_user_id,
  tags,
  unanswered_flag
FROM `rittman-analytics-ed-pasfield`.`dev`.`stg_questions`