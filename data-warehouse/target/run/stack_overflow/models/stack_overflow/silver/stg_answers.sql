

  create or replace view `rittman-analytics-ed-pasfield`.`dev`.`stg_answers`
  OPTIONS()
  as 

SELECT
  id,
  parent_id,
  creation_date,
  view_count,
  score,
  owner_user_id,
  SAFE_CAST(accepted_answer_id AS BOOL) AS accepted_flag
FROM `rittman-analytics-ed-pasfield`.`dev`.`raw_posts_answers`;

