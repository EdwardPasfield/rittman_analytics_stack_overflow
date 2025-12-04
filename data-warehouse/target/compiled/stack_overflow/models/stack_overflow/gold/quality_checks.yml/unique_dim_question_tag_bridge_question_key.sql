
    
    

with dbt_test__target as (

  select question_key as unique_field
  from `rittman-analytics-ed-pasfield`.`dev`.`dim_question_tag_bridge`
  where question_key is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


