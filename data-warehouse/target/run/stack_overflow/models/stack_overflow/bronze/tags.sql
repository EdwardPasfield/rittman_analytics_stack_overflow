
  
    

    create or replace table `rittman-analytics-ed-pasfield`.`dev`.`tags`
      
    
    

    OPTIONS()
    as (
      

select 
    * 
from `bigquery-public-data`.`stackoverflow`.`tags`
    );
  