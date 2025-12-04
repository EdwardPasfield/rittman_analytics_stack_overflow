
  
    

    create or replace table `rittman-analytics-ed-pasfield`.`dev`.`dim_answers`
      
    partition by date_trunc(creation_date, month)
    cluster by answer_key

    OPTIONS()
    as (
      

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
    );
  