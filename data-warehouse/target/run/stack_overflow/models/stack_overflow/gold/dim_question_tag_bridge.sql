
  
    

    create or replace table `rittman-analytics-ed-pasfield`.`dev`.`dim_question_tag_bridge`
      
    
    cluster by question_key, tag_key

    OPTIONS()
    as (
      

SELECT
  dq.question_key,
  dt.tag_key,
  qtb.question_id,
  qtb.tag_id
FROM `rittman-analytics-ed-pasfield`.`dev`.`stg_question_tag_bridge` qtb
JOIN `rittman-analytics-ed-pasfield`.`dev`.`dim_questions` dq
  ON dq.question_id = qtb.question_id
JOIN `rittman-analytics-ed-pasfield`.`dev`.`dim_tags` dt
  ON dt.tag_id = qtb.tag_id
    );
  