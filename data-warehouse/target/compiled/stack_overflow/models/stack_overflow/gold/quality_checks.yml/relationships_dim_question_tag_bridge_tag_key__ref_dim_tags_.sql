
    
    

with child as (
    select tag_key as from_field
    from `rittman-analytics-ed-pasfield`.`dev`.`dim_question_tag_bridge`
    where tag_key is not null
),

parent as (
    select  as to_field
    from `rittman-analytics-ed-pasfield`.`dev`.`dim_tags`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


