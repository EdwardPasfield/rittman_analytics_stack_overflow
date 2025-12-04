select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select tag_name
from `rittman-analytics-ed-pasfield`.`dev`.`tags`
where tag_name is null



      
    ) dbt_internal_test