
  
    

    create or replace table `rittman-analytics-ed-pasfield`.`dev`.`posts_answers`
      
    
    

    OPTIONS()
    as (
      

select 
    * 
from `bigquery-public-data`.`stackoverflow`.`posts_answers`
    );
  