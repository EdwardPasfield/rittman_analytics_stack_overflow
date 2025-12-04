select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select answer_key
from `rittman-analytics-ed-pasfield`.`dev`.`dim_answers`
where answer_key is null



      
    ) dbt_internal_test