select * from tab;

select e.LAST_NAME �̸�, d.DEPARTMENT_NAME �μ���
FROM EMPLOYEES e 
INNER JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID LIKE d.DEPARTMENT_ID;

;

select department_name as "���� �μ�"
from departments
where department_id like 
    (select department_id
    from employees
    where last_name like 'Fay');