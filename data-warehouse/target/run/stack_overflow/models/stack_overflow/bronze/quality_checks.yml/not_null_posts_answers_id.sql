select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select id
from `rittman-analytics-ed-pasfield`.`dev`.`posts_answers`
where id is null



      
    ) dbt_internal_test