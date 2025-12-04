select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select tags
from `rittman-analytics-ed-pasfield`.`dev`.`posts_questions`
where tags is null



      
    ) dbt_internal_test