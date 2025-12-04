select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select question_key
from `rittman-analytics-ed-pasfield`.`dev`.`dim_question_tag_bridge`
where question_key is null



      
    ) dbt_internal_test