

SELECT
  FARM_FINGERPRINT(CONCAT('answer_', CAST(id AS STRING))) AS answer_key,
  id AS answer_id,
  parent_id AS question_id,
  creation_date,
  view_count,
  score,
  owner_user_id,
  accepted_flag
FROM `rittman-analytics-ed-pasfield`.`dev`.`stg_answers`