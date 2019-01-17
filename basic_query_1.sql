SELECT * FROM TAB;

-- Employees 테이블
--[ employee_id = 사번 ] [ first_name = 이름 ] 
--[ last_name = 성 ] [ email = 이메일 ] 
--[ phone_number = 전화번호 ] [ hire_date = 고용일 ]
--[ job_id = 업무코드 ] [ salary = 급여]
--[ commission_pct = 커미션비율 ] [ manager_id = 상사아이디]
--[ department_id = 부서코드]
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
-- 문제001. 
-- HR 스키마 테이블을 모두 출력?
-- *******

SELECT * FROM tab;

-- *******
-- 문제002. 
-- HR 스키마 테이블 수는 몇개?
-- *******

SELECT count(*) from tab;

-- *******
-- 문제003. 
-- 사번, 성, 이름출력?
-- *******

select employee_id, last_name, first_name
from Employees;


-- *******
-- 문제004. 
-- 이름이 s로 끝나는 직원의 이름 출력?
-- *******

select first_name
from Employees
where first_name like '%s';

-- *******
-- 문제005. 
-- 이름이 s로 시작하는 직원의 이름 출력?
-- *******

select first_name
from Employees
where first_name like 'S%';

-- *******
-- 문제006. 
-- 급여가 많은 순으로 이름,부서코드,급여 조회 
-- *******

select first_name, department_id, salary
from Employees 
order by salary desc, first_name asc;

-- *******
-- 문제007.
-- 급여가 12000 이상인 사번,이름,부서코드, 급여 조회 
-- *******

select employee_id, first_name, department_id, salary
from Employees
where salary > 12000 ;


-- *******
-- 문제008.
-- 급여가 1500이상 2500이하를 받는 직원의 사번,이름,부서코드, 급여 조회 
-- ( AND 사용 )
-- *******

select employee_id, first_name, department_id, salary
from Employees
where salary >= 1500 and salary <= 2500;

-- *******
-- 문제009.
-- 급여가 1500이상 2500이하를 받는 
-- 직원의 사번,이름,부서코드, 급여 조회 (BETWEEN 사용) 
-- *******

select employee_id, first_name, department_id, salary
from Employees
where salary between 1500 and 2500;

-- *******
-- 문제010.
-- 2005년도에 입사한 직원의 이름과 부서코드, 
-- 입사일자를 조회
-- *******

select first_name, department_id,  hire_date
from Employees
where hire_date between '2005/01/01' and '2005/12/31';