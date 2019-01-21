select * from Employees;
-- Employees 테이블
--[ employee_id = 사번 ] [ first_name = 이름 ] 
--[ last_name = 성 ] [ email = 이메일 ] 
--[ phone_number = 전화번호 ] [ hire_date = 입사일 ]
--[ job_id = 업무코드 ] [ salary = 급여]
--[ commission_pct = 커미션비율 ] [ manager_id = 상사아이디]
--[ department_id = 부서코드]

--  Jobs 테이블
select * from Jobs;
-- job_id 업무코드
-- job_title 업무타이틀
-- min_salary  최저급여
-- max_salary 최고급여
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
-- [문제021]
-- IT Programmer 또는 Sales Man인 
-- 직원의 이름, 입사일, 업무명 표시.
-- *******************  

select E.FNAME 이름, E.HDATE 입사일,  J.TITLE 업무명
from JOB J
    join EMP E 
    on J.JID like E.JID 
where J.TITLE IN('Programmer','Sales Man')
order by E.FNAME ;

-- ex.)
-- select 
--      e.first_name 이름,
--      e.hire_date 입사일,
--      j.JOB_ID 업무코드,
--      j.JOB_TITLE 업무명
-- from Employees e
--      inner foin jobs j
--      on e.job_id like j.job_id
-- where j.job_title in('programmer', 'Sales Manager')
-- order by e.first_name;

select * 
from Employees
where first_name like 'Vance';

-- *******************
-- [문제022]
-- 부서명 및 관리자이름 표시
-- (단, 컬럼명은 관리자 [공백] 이름 이 되도록 ...)
-- DEPARTMENTS 에서 MANAGER_ID 가 관리자 코드
-- *******************  

SELECT * FROM DEP;
SELECT * FROM EMP;

SELECT 
    DNAME 부서명,  
    FNAME "관리자 이름"
FROM DEP D 
    INNER JOIN EMP E 
    ON D.MID LIKE E.EID;
    
-- *******************
-- [문제023]
-- 마케팅(Marketing) 부서에서 근무하는 사원의 
-- 사번, 직책, 이름, 근속기간
-- (단, 근속기간은 JOB_HISTORY 에서 END_DATE-START_DATE로 구할 것)
-- EMPLOYEE_ID 사번, JOB_TITLE 직책임
-- *******************  
SELECT * FROM DEP;
SELECT * FROM EMP;
SELECT * FROM HIS;
SELECT * FROM JOB;

SELECT E.EID 사번, J.TITLE 직책 , E.FNAME 이름,
       H.EDATE - H.SDATE 근속일수
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
-- [문제024]
--  직책이 "Programmer"인 사원의 정보를 출력
-- DEPARTMENT_NAME 부서명, 이름(FIRST_NAME + [공백] + LAST_NAME)까지 출력
-- 이름은 중복되어서 출력됨. 즉 한명이 여러부서에서 업무를 수행함
-- *******************

SELECT 
    DNAME 부서명, FNAME || ' ' || LNAME 이름
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
-- [문제025]
-- 부서명, 관리자 이름, 부서위치 도시 표시
-- 부서명 오름차순
-- *******************

SELECT 
    D.DNAME 부서명, 
    E.FNAME ||''|| E.LNAME "관리자 이름", 
    L.CITY "부서위치 도시"
FROM DEP D
    JOIN EMP E 
        ON D.MID LIKE E.EID
    JOIN LOC L 
        USING(LID)
      --ON D.LID LIKE L.LID
ORDER BY DNAME;

-- *******************
-- [문제026]
-- 부서별 평균 급여를 출력하시오.
-- 
-- *******************

SELECT 
    D.DNAME 부서명,
    ROUND(AVG(E.SAL),2) "부서별 평균 급여"
FROM EMP E
    JOIN DEP D 
        ON E.DID LIKE D.DID
GROUP BY E.DID, D.DNAME
;

-- *******************
-- [문제027]
-- 부서별 평균 급여가 10000 이 넘는
--  부서명, "부서별 평균 급여" 를 출력하시오
-- *******************  
 
SELECT 
    D.DNAME 부서명,
    ROUND(AVG(E.SAL),2) "부서별 평균 급여"
FROM EMP E
    JOIN DEP D 
        ON E.DID LIKE D.DID
GROUP BY E.DID, D.DNAME
HAVING ROUND(AVG(E.SAL),2) >= 10000
;

SELECT * FROM TAB;
-- *******************
-- [문제028]
-- 올해 연봉에서 10% 인상된 급액이 내년 연봉으로
-- 책정되었습니다. 내년 전사원의 내년급여를
-- 출력하세요.
-- 단, 연봉 = 급여 * 12 입니다
-- *********************
SELECT
 EID 사번,
 FNAME||' '||LNAME 이름,
 SAL 올해급여,
 (SAL*12 + (SAL*12)*0.1) /12 내년급여
FROM EMP;


-- *******************
-- [문제029]
-- 부서별로 담당하는 관리자와 업무를 
-- 한번씩만 출력하시오 (20행)
-- *********************
SELECT * FROM EMP;
SELECT * FROM DEP;
SELECT * FROM JOB;
 
SELECT
    DISTINCT D.DNAME 부서,
    E.FNAME 관리자,
    J.TITLE 업무
FROM EMP E
    JOIN DEP D
        ON E.EID LIKE D.MID
    JOIN JOB J
        ON E.JID LIKE J.JID
   ;
 
SELECT * FROM DEP;

-- *******************
-- [문제030]
-- 이번 분기에 IT부서(부서명: IT)에서는 신규 프로그램을 개발하고 
-- 보급하여 회사에 공헌하였다. 
-- 이에 해당 부서의 사원 급여를 12.3% 인상하여 지급합니다.
-- 정수만(반올림) 표시하여 보고서를 작성하시오. 
-- 보고서는 사원번호, 성과 이름(이름), 
-- 급여, 내년 순으로 출력하시오
-- 급액은 천원단위임
-- *********************

SELECT
    E.EID 사번,
    E.FNAME||' '||E.LNAME 이름,    
    TO_CHAR(ROUND(E.SAL+(E.SAL * (12.3/100))),
        'l9,999,999'
        ) "인상된 급여"
FROM EMP E
WHERE E.DID LIKE (
                SELECT D.DID
                FROM DEP D
                WHERE D.DNAME LIKE 'IT'
                )
;

