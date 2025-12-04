select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with child as (
    select question_key as from_field
    from `rittman-analytics-ed-pasfield`.`dev`.`dim_question_tag_bridge`
    where question_key is not null
),

parent as (
    select  as to_field
    from `rittman-analytics-ed-pasfield`.`dev`.`dim_questions`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



      
    ) dbt_internal_test