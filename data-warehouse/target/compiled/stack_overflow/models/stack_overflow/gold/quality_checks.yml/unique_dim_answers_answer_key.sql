
    
    

with dbt_test__target as (

  select answer_key as unique_field
  from `rittman-analytics-ed-pasfield`.`dev`.`dim_answers`
  where answer_key is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


