select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select number_of_questions_mentioned_on
from `rittman-analytics-ed-pasfield`.`dev`.`fct_tags_stats_monthly`
where number_of_questions_mentioned_on is null



      
    ) dbt_internal_test