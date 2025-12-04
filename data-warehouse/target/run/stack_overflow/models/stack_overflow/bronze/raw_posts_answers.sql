
  
    

    create or replace table `rittman-analytics-ed-pasfield`.`dev`.`raw_posts_answers`
      
    partition by date_trunc(creation_date, month)
    cluster by id

    OPTIONS()
    as (
      

select
    id,
    title,
    body,
    accepted_answer_id,
    answer_count,
    comment_count,
    community_owned_date,
    creation_date,
    favorite_count,
    last_activity_date,
    last_edit_date,
    last_editor_display_name,
    last_editor_user_id,
    owner_display_name,
    owner_user_id,
    parent_id,
    post_type_id,
    score,
    tags,
    view_count,
    DATE_TRUNC(creation_date, MONTH) AS event_date
from `bigquery-public-data`.`stackoverflow`.`posts_answers`
    );
  