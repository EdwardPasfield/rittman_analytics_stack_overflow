
    
    

with dbt_test__target as (

  select tag_id as unique_field
  from `rittman-analytics-ed-pasfield`.`dev`.`dim_tags`
  where tag_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


