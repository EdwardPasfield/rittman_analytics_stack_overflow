{{ config(
    materialized='table',
    cluster_by=["id"]
) }}

select 
    * 
from {{ source('stackoverflow', 'tags') }}

