
  
    

    create or replace table `rittman-analytics-ed-pasfield`.`dev`.`raw_tags`
      
    
    cluster by id

    OPTIONS()
    as (
      

select 
    * 
from `bigquery-public-data`.`stackoverflow`.`tags`
    );
  