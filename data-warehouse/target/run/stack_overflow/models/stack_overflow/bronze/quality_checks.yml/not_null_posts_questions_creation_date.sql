select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select creation_date
from `rittman-analytics-ed-pasfield`.`dev`.`posts_questions`
where creation_date is null



      
    ) dbt_internal_test