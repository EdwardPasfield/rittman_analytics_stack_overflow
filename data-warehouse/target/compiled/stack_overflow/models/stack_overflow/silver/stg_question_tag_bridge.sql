

SELECT
  q.id AS question_id,
  t.id AS tag_id,
  t.tag_name
FROM `rittman-analytics-ed-pasfield`.`dev`.`stg_questions` q,
UNNEST(tag_list) AS tag
LEFT JOIN `rittman-analytics-ed-pasfield`.`dev`.`stg_tags` t
  ON LOWER(t.tag_name) = LOWER(tag)
WHERE tag IS NOT NULL
  AND t.tag_name IS NOT NULL