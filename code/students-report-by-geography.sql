-- 618. Students Report By Geography
WITH CTE AS(
    select *, 
            row_number() over (partition by continent order by name) rk 
    from student
)
select 
    max(if(continent='America',name,null)) America,
    max(if(continent='Asia',name,null)) Asia,
    max(if(continent='Europe',name,null)) Europe
from CTE 
group by rk;