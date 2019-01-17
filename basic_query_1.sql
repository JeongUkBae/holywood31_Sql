SELECT * FROM TAB;

-- Employees ���̺�
--[ employee_id = ��� ] [ first_name = �̸� ] 
--[ last_name = �� ] [ email = �̸��� ] 
--[ phone_number = ��ȭ��ȣ ] [ hire_date = ����� ]
--[ job_id = �����ڵ� ] [ salary = �޿�]
--[ commission_pct = Ŀ�̼Ǻ��� ] [ manager_id = �����̵�]
--[ department_id = �μ��ڵ�]
DESC EMPLOYEESDEPARTMENT_ID;

CREATE VIEW EMP AS
SELECT EMPLOYEE_ID EID,
       FIRST_NAME FNAME, 
       LAST_NAME LNAME ,
       EMAIL EMAIL,
       PHONE_NUMBER PHONE,
       HIRE_DATE HEATE,
       JOB_ID JID,
       SALARY SAL,
       COMMISSION_PCT COMM,
       MANAGER_ID MID,
       DEPARTMENT_ID DID
       FROM EMPLOYEES;

SELECT * FROM EMP;
SELECT * FROM EMP_DETAILS_VIEW;
DROP VIEW EMP;


-- *******
-- ����001. 
-- HR ��Ű�� ���̺��� ��� ���?
-- *******

SELECT * FROM tab;

-- *******
-- ����002. 
-- HR ��Ű�� ���̺� ���� �?
-- *******

SELECT count(*) from tab;

-- *******
-- ����003. 
-- ���, ��, �̸����?
-- *******

select employee_id, last_name, first_name
from Employees;


-- *******
-- ����004. 
-- �̸��� s�� ������ ������ �̸� ���?
-- *******

select first_name
from Employees
where first_name like '%s';

-- *******
-- ����005. 
-- �̸��� s�� �����ϴ� ������ �̸� ���?
-- *******

select first_name
from Employees
where first_name like 'S%';

-- *******
-- ����006. 
-- �޿��� ���� ������ �̸�,�μ��ڵ�,�޿� ��ȸ 
-- *******

select first_name, department_id, salary
from Employees 
order by salary desc, first_name asc;

-- *******
-- ����007.
-- �޿��� 12000 �̻��� ���,�̸�,�μ��ڵ�, �޿� ��ȸ 
-- *******

select employee_id, first_name, department_id, salary
from Employees
where salary > 12000 ;


-- *******
-- ����008.
-- �޿��� 1500�̻� 2500���ϸ� �޴� ������ ���,�̸�,�μ��ڵ�, �޿� ��ȸ 
-- ( AND ��� )
-- *******

select employee_id, first_name, department_id, salary
from Employees
where salary >= 1500 and salary <= 2500;

-- *******
-- ����009.
-- �޿��� 1500�̻� 2500���ϸ� �޴� 
-- ������ ���,�̸�,�μ��ڵ�, �޿� ��ȸ (BETWEEN ���) 
-- *******

select employee_id, first_name, department_id, salary
from Employees
where salary between 1500 and 2500;

-- *******
-- ����010.
-- 2005�⵵�� �Ի��� ������ �̸��� �μ��ڵ�, 
-- �Ի����ڸ� ��ȸ
-- *******

select first_name, department_id,  hire_date
from Employees
where hire_date between '2005/01/01' and '2005/12/31';