{{ config(
    materialized='table',
    cluster_by=["question_key","tag_key"]
) }}

SELECT
  dq.question_key,
  dt.tag_key,
  qtb.question_id,
  qtb.tag_id
FROM {{ ref('stg_question_tag_bridge') }} qtb
JOIN {{ ref('dim_questions') }} dq
  ON dq.question_id = qtb.question_id
JOIN {{ ref('dim_tags') }} dt
  ON dt.tag_id = qtb.tag_id

