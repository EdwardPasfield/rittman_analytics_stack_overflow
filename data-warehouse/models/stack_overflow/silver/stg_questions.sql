{{ config(materialized='view') }}

WITH base AS (
  SELECT
    *
  FROM {{ ref('raw_posts_questions') }}
)

SELECT
  id,
  creation_date,
  view_count,
  score,
  tags,
  accepted_answer_id,
  answer_count,
  comment_count,
  owner_user_id,
  CASE
    WHEN accepted_answer_id IS NULL THEN TRUE
    ELSE FALSE
  END AS unanswered_flag,
  CASE
    WHEN tags IS NULL THEN []
    ELSE SPLIT(REGEXP_REPLACE(tags, r'^<|>$', ''), '><')
  END AS tag_list
FROM base

