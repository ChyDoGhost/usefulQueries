call scheme.update_employee_name();

drop procedure scheme.update_employee_name;

create or replace procedure scheme.update_employee_name()
language sql
as 
$$
    update scheme.value
       set leadername  = employees.leadername
         , managername = employees.managername
         , curatorname = employees.curatorname
      from (
                with get_variations_employee as 
                (
                    select distinct 
                           leaderid
                         , managerid
                         , curatorid  
                      from scheme.value
                     where value.id in (49,50,51,52,53,54,55,56,57,60,62,63,64,65,66,67,68,83,84)
                ),
                get_employee as 
                (
                    select concat(lastname, ' ', firstname, ' ', middlename) as employeename
                         , employeeid
                      from scheme.employee
                )
                select get_variations_employee.leaderid
                     , get_leader.employeename           as leadername
                     , get_variations_employee.managerid 
                     , get_manager.employeename          as managername
                     , get_variations_employee.curatorid 
                     , get_curator.employeename          as curatorname
                  from get_variations_employee
                 inner join get_employee as get_leader  on get_variations_employee.leaderid  = get_leader.employeeid
                 inner join get_employee as get_manager on get_variations_employee.managerid = get_manager.employeeid
                 inner join get_employee as get_curator on get_variations_employee.curatorid = get_curator.employeeid 
                         
              ) as employees                                
     where value.leaderid   = employees.leaderid 
       and value.managerid  = employees.managerid 
       and value.curatorid  = employees.curatorid 
       and value.id        in (49,50,51,52,53,54,55,56,57,60,62,63,64,65,66,67,68,83,84)
$$;