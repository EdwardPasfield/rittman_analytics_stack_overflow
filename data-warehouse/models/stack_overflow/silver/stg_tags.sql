{{ config(materialized='view') }}

SELECT
  id,
  tag_name,
  count
FROM {{ ref('raw_tags') }}

