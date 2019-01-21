select * from Employees;
-- Employees ���̺�
--[ employee_id = ��� ] [ first_name = �̸� ] 
--[ last_name = �� ] [ email = �̸��� ] 
--[ phone_number = ��ȭ��ȣ ] [ hire_date = �Ի��� ]
--[ job_id = �����ڵ� ] [ salary = �޿�]
--[ commission_pct = Ŀ�̼Ǻ��� ] [ manager_id = �����̵�]
--[ department_id = �μ��ڵ�]

--  Jobs ���̺�
select * from Jobs;
-- job_id �����ڵ�
-- job_title ����Ÿ��Ʋ
-- min_salary  �����޿�
-- max_salary �ְ�޿�
DESC JOBS;
CREATE VIEW JOB AS
SELECT 
    JOB_ID JID,
    JOB_TITLE TITLE,
    MIN_SALARY MINSAL,
    MAX_SALARY MAXSAL
FROM JOBS;

DESC EMPLOYEES;
CREATE VIEW EMP AS
SELECT EMPLOYEE_ID EID,
       FIRST_NAME FNAME, 
       LAST_NAME LNAME ,
       EMAIL EMAIL,
       PHONE_NUMBER PHONE,
       HIRE_DATE HDATE,
       JOB_ID JID,
       SALARY SAL,
       COMMISSION_PCT COMM,
       MANAGER_ID MID,
       DEPARTMENT_ID DID
       FROM EMPLOYEES;

SELECT * FROM EMP;
SELECT * FROM EMP_DETAILS_VIEW;
DROP VIEW EMP;

SELECT * FROM TAB;
DESC DEPARTMENTS;
CREATE VIEW DEP AS
SELECT 
    DEPARTMENT_ID DID,
    DEPARTMENT_NAME DNAME,
    MANAGER_ID MID,
    LOCATION_ID LID
FROM DEPARTMENTS;

DESC LOCATIONS;
CREATE VIEW LOC AS
SELECT
    LOCATION_ID LID,
    STREET_ADDRESS ADDR,
    POSTAL_CODE ZIP,
    CITY,
    STATE_PROVINCE PROV,
    COUNTRY_ID CID
FROM LOCATIONS;

DESC JOB_HISTORY;
CREATE VIEW HIS AS
SELECT 
    EMPLOYEE_ID EID,
    START_DATE SDATE,
    END_DATE EDATE,
    JOB_ID JID,
    DEPARTMENT_ID DID
FROM JOB_HISTORY;

-- *******************
-- [����021]
-- IT Programmer �Ǵ� Sales Man�� 
-- ������ �̸�, �Ի���, ������ ǥ��.
-- *******************  

select E.FNAME �̸�, E.HDATE �Ի���,  J.TITLE ������
from JOB J
    join EMP E 
    on J.JID like E.JID 
where J.TITLE IN('Programmer','Sales Man')
order by E.FNAME ;

-- ex.)
-- select 
--      e.first_name �̸�,
--      e.hire_date �Ի���,
--      j.JOB_ID �����ڵ�,
--      j.JOB_TITLE ������
-- from Employees e
--      inner foin jobs j
--      on e.job_id like j.job_id
-- where j.job_title in('programmer', 'Sales Manager')
-- order by e.first_name;

select * 
from Employees
where first_name like 'Vance';

-- *******************
-- [����022]
-- �μ��� �� �������̸� ǥ��
-- (��, �÷����� ������ [����] �̸� �� �ǵ��� ...)
-- DEPARTMENTS ���� MANAGER_ID �� ������ �ڵ�
-- *******************  

SELECT * FROM DEP;
SELECT * FROM EMP;

SELECT 
    DNAME �μ���,  
    FNAME "������ �̸�"
FROM DEP D 
    INNER JOIN EMP E 
    ON D.MID LIKE E.EID;
    
-- *******************
-- [����023]
-- ������(Marketing) �μ����� �ٹ��ϴ� ����� 
-- ���, ��å, �̸�, �ټӱⰣ
-- (��, �ټӱⰣ�� JOB_HISTORY ���� END_DATE-START_DATE�� ���� ��)
-- EMPLOYEE_ID ���, JOB_TITLE ��å��
-- *******************  
SELECT * FROM DEP;
SELECT * FROM EMP;
SELECT * FROM HIS;
SELECT * FROM JOB;

SELECT E.EID ���, J.TITLE ��å , E.FNAME �̸�,
       H.EDATE - H.SDATE �ټ��ϼ�
FROM HIS H
    JOIN JOB J
        ON H.JID LIKE J.JID
    JOIN EMP E 
        ON E.EID LIKE H.EID
WHERE E.DID LIKE (SELECT D.DID
                  FROM DEP D
                  WHERE D.DNAME LIKE 'Marketing'
);


-- *******************
-- [����024]
--  ��å�� "Programmer"�� ����� ������ ���
-- DEPARTMENT_NAME �μ���, �̸�(FIRST_NAME + [����] + LAST_NAME)���� ���
-- �̸��� �ߺ��Ǿ ��µ�. �� �Ѹ��� �����μ����� ������ ������
-- *******************

SELECT 
    DNAME �μ���, FNAME || ' ' || LNAME �̸�
FROM EMP E 
    JOIN JOB J
        ON E.JID LIKE J.JID
    JOIN DEP D
        ON E.DID LIKE D.DID
WHERE J.JID LIKE (SELECT JID 
                  FROM JOB 
                  WHERE TITLE LIKE 'Programmer')
;
    

-- *******************
-- [����025]
-- �μ���, ������ �̸�, �μ���ġ ���� ǥ��
-- �μ��� ��������
-- *******************

SELECT 
    D.DNAME �μ���, 
    E.FNAME ||''|| E.LNAME "������ �̸�", 
    L.CITY "�μ���ġ ����"
FROM DEP D
    JOIN EMP E 
        ON D.MID LIKE E.EID
    JOIN LOC L 
        USING(LID)
      --ON D.LID LIKE L.LID
ORDER BY DNAME;

-- *******************
-- [����026]
-- �μ��� ��� �޿��� ����Ͻÿ�.
-- 
-- *******************

SELECT 
    D.DNAME �μ���,
    ROUND(AVG(E.SAL),2) "�μ��� ��� �޿�"
FROM EMP E
    JOIN DEP D 
        ON E.DID LIKE D.DID
GROUP BY E.DID, D.DNAME
;

-- *******************
-- [����027]
-- �μ��� ��� �޿��� 10000 �� �Ѵ�
--  �μ���, "�μ��� ��� �޿�" �� ����Ͻÿ�
-- *******************  
 
SELECT 
    D.DNAME �μ���,
    ROUND(AVG(E.SAL),2) "�μ��� ��� �޿�"
FROM EMP E
    JOIN DEP D 
        ON E.DID LIKE D.DID
GROUP BY E.DID, D.DNAME
HAVING ROUND(AVG(E.SAL),2) >= 10000
;

SELECT * FROM TAB;
-- *******************
-- [����028]
-- ���� �������� 10% �λ�� �޾��� ���� ��������
-- å���Ǿ����ϴ�. ���� ������� ����޿���
-- ����ϼ���.
-- ��, ���� = �޿� * 12 �Դϴ�
-- *********************
SELECT
 EID ���,
 FNAME||' '||LNAME �̸�,
 SAL ���ر޿�,
 (SAL*12 + (SAL*12)*0.1) /12 ����޿�
FROM EMP;


-- *******************
-- [����029]
-- �μ����� ����ϴ� �����ڿ� ������ 
-- �ѹ����� ����Ͻÿ� (20��)
-- *********************
SELECT * FROM EMP;
SELECT * FROM DEP;
SELECT * FROM JOB;
 
SELECT
    DISTINCT D.DNAME �μ�,
    E.FNAME ������,
    J.TITLE ����
FROM EMP E
    JOIN DEP D
        ON E.EID LIKE D.MID
    JOIN JOB J
        ON E.JID LIKE J.JID
   ;
 
SELECT * FROM DEP;

-- *******************
-- [����030]
-- �̹� �б⿡ IT�μ�(�μ���: IT)������ �ű� ���α׷��� �����ϰ� 
-- �����Ͽ� ȸ�翡 �����Ͽ���. 
-- �̿� �ش� �μ��� ��� �޿��� 12.3% �λ��Ͽ� �����մϴ�.
-- ������(�ݿø�) ǥ���Ͽ� ������ �ۼ��Ͻÿ�. 
-- ������ �����ȣ, ���� �̸�(�̸�), 
-- �޿�, ���� ������ ����Ͻÿ�
-- �޾��� õ��������
-- *********************

SELECT
    E.EID ���,
    E.FNAME||' '||E.LNAME �̸�,    
    TO_CHAR(ROUND(E.SAL+(E.SAL * (12.3/100))),
        'l9,999,999'
        ) "�λ�� �޿�"
FROM EMP E
WHERE E.DID LIKE (
                SELECT D.DID
                FROM DEP D
                WHERE D.DNAME LIKE 'IT'
                )
;

