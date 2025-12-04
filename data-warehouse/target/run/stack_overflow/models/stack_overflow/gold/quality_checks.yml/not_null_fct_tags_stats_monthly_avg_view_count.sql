select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select avg_view_count
from `rittman-analytics-ed-pasfield`.`dev`.`fct_tags_stats_monthly`
where avg_view_count is null



      
    ) dbt_internal_test