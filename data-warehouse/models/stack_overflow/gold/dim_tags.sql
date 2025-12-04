{{ config(
    materialized='table',
    cluster_by=["tag_key"]
) }}

SELECT
  FARM_FINGERPRINT(CONCAT('tag_', CAST(id AS STRING))) AS tag_key,
  id AS tag_id,
  LOWER(tag_name) AS tag_name,
  count AS usage_count,
  'topic' AS classification
FROM {{ ref('stg_tags') }}

