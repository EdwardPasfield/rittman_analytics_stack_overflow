{{ config(materialized='view') }}

SELECT
  q.id AS question_id,
  t.id AS tag_id,
  t.tag_name
FROM {{ ref('stg_questions') }} q,
UNNEST(tag_list) AS tag
LEFT JOIN {{ ref('stg_tags') }} t
  ON LOWER(t.tag_name) = LOWER(tag)
WHERE tag IS NOT NULL
  AND t.tag_name IS NOT NULL

