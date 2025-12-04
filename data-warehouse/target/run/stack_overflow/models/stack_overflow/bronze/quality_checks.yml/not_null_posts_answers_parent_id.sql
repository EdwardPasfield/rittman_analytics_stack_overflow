select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select parent_id
from `rittman-analytics-ed-pasfield`.`dev`.`posts_answers`
where parent_id is null



      
    ) dbt_internal_test