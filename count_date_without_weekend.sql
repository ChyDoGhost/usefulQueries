with recursive cte as (
    select objectid
         , current_date                         as dt
         , calcdatetime::date                   as dt_end
         , 1                                    as "counter"
         , extract(dow from calcdatetime::date) as "dayofweek"
      from scheme.value
     where scheme.id = 80 
       
    union all
    
    select objectid
         , current_date 
         , dt_end + 1  
         , counter + 1 
         , extract(dow from dt_end + counter) 
      from cte
     where dt_end <= dt        
)
select objectid
     , count(objectid) 
     , min(dt_end)
  from cte
 where dayofweek not in (0, 6)
 group by objectid