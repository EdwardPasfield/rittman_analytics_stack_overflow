

  create or replace view `rittman-analytics-ed-pasfield`.`dev`.`stg_tags`
  OPTIONS()
  as 

SELECT
  id,
  tag_name,
  count
FROM `rittman-analytics-ed-pasfield`.`dev`.`raw_tags`;

