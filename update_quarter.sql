update scheme.value
   set productionquarterid   = quarter.productionquarterid
     , productionquartername = quarter.productionquartername
  from (
            select prod_quarter.productionquarterid 
                 , prod_quarter.datestart      
                 , prod_quarter.dateend       
                 , prod_quarter.startyear  
                   || 'Q' || 
                   prod_quarter.quarternumber as "quarter"
              from scheme.prod_quarter   
       ) as quarter
where id                in (94, 97)
  and quarterid          = -1
  and calcdatetime between quarter.datestart and quarter.dateend
        