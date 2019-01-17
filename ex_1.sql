select * from tab;

select e.LAST_NAME 이름, d.DEPARTMENT_NAME 부서명
FROM EMPLOYEES e 
INNER JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID LIKE d.DEPARTMENT_ID;

;

select department_name as "페이 부서"
from departments
where department_id like 
    (select department_id
    from employees
    where last_name like 'Fay');