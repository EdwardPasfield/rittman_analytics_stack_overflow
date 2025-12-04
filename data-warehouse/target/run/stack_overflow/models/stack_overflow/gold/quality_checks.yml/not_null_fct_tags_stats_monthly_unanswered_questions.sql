select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select unanswered_questions
from `rittman-analytics-ed-pasfield`.`dev`.`fct_tags_stats_monthly`
where unanswered_questions is null



      
    ) dbt_internal_test