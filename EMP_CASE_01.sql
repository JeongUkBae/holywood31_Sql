SELECT * FROM EMP;
--EMPNO ���
--ENAME �����
--JOB ����
--MGR �Ŵ���
--HIREDATE �Ի���
--SAL ����
--COMM Ŀ�̼�
--DEPTNO �μ��ڵ�
SELECT * FROM DEPT;
--DEPTNO �μ��ڵ�
--DNAME �μ���
--LOC ȸ����ġ

-- EMP_TEST_01
-- CASE ǥ��
SELECT ENAME,
    CASE WHEN SAL > 2000
        THEN SAL
        ELSE 2000
    END REVISED_SALARY
FROM EMP;
--����
--CASE WHEN ���ǽ�
--  THEN ���� ���
--  ELSE ������ ���
--END �÷������� ó�� 

--EMP_TEST_02
--�μ��������� �μ���ġ�� �̱��� ����,�ߺ�,���η� �����϶� 
-- ���� - EAST, ������ - EAST, ��ī�� - CENTER, �޶� - CENTER
-- �÷��� - AREA
SELECT DNAME,
    CASE WHEN LOC IN ('NEW YORK','BOSTON')
        THEN 'EAST'
        WHEN LOC IN ('CHICAGO','DALLAS')
        THEN 'CENTER'
    END AREA
FROM DEPT;


-- EMP_TEST_03
-- �޿��� 3000 �̻��̸� HIGH, 1000 �̻��̸� MID, �̸��̸� LOW 
SELECT ENAME,
    CASE WHEN SAL >= 3000
        THEN 'HIGH'
        WHEN SAL >= 1000
        THEN 'MID' 
        ELSE 'LOW'
    END SALARY
FROM EMP;

SELECT * FROM EMP;

-- EMP_TEST_04
-- �޿��� 2000 �̻��̸� ���ʽ� 1000, 
-- 1000 �̻��̸� 500,
-- 1000 �̸��̸� 0���� ����Ͻÿ�
-- �÷����� BONUS

SELECT ENAME, SAL,
    CASE WHEN SAL >= 2000
        THEN 1000
        WHEN SAL >= 1000
        THEN 500
        ELSE 0
    END BONUS
FROM EMP;

--EMP_TEST_05
--�Ŵ����� "BLAKE" �̸� NULL ǥ��, ���� ������ MGR ǥ��

SELECT ENAME, EMPNO, MGR,
    CASE WHEN MGR LIKE (SELECT EMPNO 
                    FROM EMP 
                    WHERE ENAME LIKE 'BLAKE')
         THEN NULL
         ELSE MGR
    END NUIF
FROM EMP; 

--EMP_TEST_06
--���� �Ի� �������� ���� �����͸� �����ϱ�
--EXTRACT() 
SELECT ENAME, DEPTNO, EXTRACT(MONTH FROM HIREDATE) MONTH, SAL
FROM EMP;

--EMP_TEST_07
--����� MONTH �����͸� 12���� ���� Į������ �����ϱ�
SELECT ENAME, DEPTNO, 
    CASE MONTH WHEN 1 THEN SAL END "1��",
    CASE MONTH WHEN 2 THEN SAL END "2��",
    CASE MONTH WHEN 3 THEN SAL END "3��",
    CASE MONTH WHEN 4 THEN SAL END "4��",
    CASE MONTH WHEN 5 THEN SAL END "5��",
    CASE MONTH WHEN 6 THEN SAL END "6��",
    CASE MONTH WHEN 7 THEN SAL END "7��",
    CASE MONTH WHEN 8 THEN SAL END "8��",
    CASE MONTH WHEN 9 THEN SAL END "9��",
    CASE MONTH WHEN 10 THEN SAL END "10��",
    CASE MONTH WHEN 11 THEN SAL END "11��",
    CASE MONTH WHEN 12 THEN SAL END "12��"
FROM (SELECT ENAME, DEPTNO, EXTRACT(MONTH FROM HIREDATE) MONTH, SAL
      FROM EMP);
      
-- EMP_TEST_08
-- ����� MONTH �����͸� 12���� ���� Į������ ������ ��
-- �μ����� �����ϱ�
 
SELECT ENAME, DEPTNO, 
    DECODE(MONTH, 1, SAL) "1��",
    DECODE(MONTH, 2, SAL) "2��"
FROM (SELECT ENAME, DEPTNO, EXTRACT(MONTH FROM HIREDATE) MONTH, SAL
      FROM EMP);


SELECT 
    (SELECT DNAME
    FROM DEPT D
    WHERE D.DEPTNO LIKE E.DEPTNO) DNAME
    ,DEPTNO, 
    AVG(CASE MONTH WHEN 1 THEN SAL END) "1��",
    AVG(CASE MONTH WHEN 2 THEN SAL END) "2��",
    AVG(CASE MONTH WHEN 3 THEN SAL END) "3��",
    AVG(CASE MONTH WHEN 4 THEN SAL END) "4��",
    AVG(CASE MONTH WHEN 5 THEN SAL END) "5��",
    AVG(CASE MONTH WHEN 6 THEN SAL END) "6��",
    AVG(CASE MONTH WHEN 7 THEN SAL END) "7��",
    AVG(CASE MONTH WHEN 8 THEN SAL END) "8��",
    AVG(CASE MONTH WHEN 9 THEN SAL END) "9��",
    AVG(CASE MONTH WHEN 10 THEN SAL END) "10��",
    AVG(CASE MONTH WHEN 11 THEN SAL END) "11��",
    AVG(CASE MONTH WHEN 12 THEN SAL END) "12��"
FROM (SELECT E.DEPTNO, 
      EXTRACT(MONTH FROM HIREDATE) MONTH, SAL
      FROM EMP E) E
GROUP BY E.DEPTNO ;


-- EMP_TEST_09
-- ������ ����
-- LEVEL : ��Ʈ �����͸� 1, �� ���� �����͸� 2�̴�.
-- ����(LEAF) �����ͱ��� 1�� �����Ѵ�.
-- CONNECT_BY_ISLEAF ���� �������� �ش� �����Ͱ� �����������̸� 
-- 1, �׷��� ������ 0�̴�.
-- LPAD �� ��������͸� �鿩���� �ϱ� ���� �����.
SELECT LEVEL, 
        LPAD(' ', 4 * (LEVEL-1)) || EMPNO ���,
        MGR ������, 
        CONNECT_BY_ISLEAF ISLEAF
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO LIKE MGR;

-- EMP_TEST_10
-- �������� 

SELECT E1.EMPNO ���, E1.MGR ������, E2.MGR "���� ������"
FROM EMP E1
    JOIN EMP E2
        ON E1.MGR LIKE E2.EMPNO
ORDER BY E2.MGR DESC, E1.MGR, E1.EMPNO
;
-- �ڽŰ� �ڽ��� ���Ӱ����ڴ� ������ �࿡�� ���� �� ������
-- ������ �����ڴ� �ٷ� ���� �� ����.
-- ������ �����ڸ� ���ϱ� ���ؼ��� �ڽ��� ���� �����ڸ� 
-- �������� ���� ������ �����ؾ� �Ѵ�.
-- �׷���, INNER JOIN �� ��������ν� �ڽ��� �����ڰ� 
-- �������� �ʴ� ��쿡�� E2���̺��� ������ ����� 
-- �������� �ʱ� ������ �ش� �����ʹ� ������� �����ȴ�.
-- �̸� �����ϱ� ���ش� �ƿ��� ������ ����Ѵ�.

SELECT E1.EMPNO ���, E1.MGR ������, E2.MGR "���� ������"
FROM EMP E1
    LEFT JOIN EMP E2
        ON E1.MGR LIKE E2.EMPNO
ORDER BY E2.MGR DESC, E1.MGR, E1.EMPNO ;

-- EMP_TEST_11
-- GROUP FUNCTION �׷� �Լ� {}

SELECT DNAME �μ���,
    JOB ����, 
    COUNT(*) "��ü ���",
    SUM(SAL) "��ü �޿�"
FROM EMP E, DEPT D
WHERE E.DEPTNO LIKE D.DEPTNO
GROUP BY DNAME,JOB;

-- ANSI ���� ������ �Լ� ������ 
-- AGGREGATE FUNCTION ���� �Լ� 
--      {SUM(), MIN(), MAX()...}
-- GROUP FUNCTION �׷� �Լ� {}
--      Ư���׸� ���� �Ұ踦 �ϴ� �Լ� 
--        ROLLUP(): �ұ׷� ���� �Ұ踦 ����ϴ� �Լ� 
--        CUBE() : ���������� �Ұ踦 ����ϴ� �Լ�  
-- WINDOW FUNCTION ������ �Լ�
--      {RANK(), ROW_NUMBER()} 

-- ROLLUP 
SELECT DNAME �μ���,
    JOB ����, 
    COUNT(*) "��ü ���",
    SUM(SAL) "��ü �޿�"
FROM EMP E, DEPT D
WHERE E.DEPTNO LIKE D.DEPTNO
GROUP BY ROLLUP(DNAME,JOB);

-- CUBE 
SELECT CASE GROUPING(DNAME)
            WHEN 1 THEN 'ALL DEPTS'
            ELSE DNAME
        END AS "�μ���",
        CASE GROUPING(JOB)
            WHEN 1 THEN 'ALL JOBS'
            ELSE JOB 
        END AS "����",
        COUNT(*) "��ü ���",
        SUM(SAL) "��ü �޿�"
FROM EMP E, DEPT D
WHERE E.DEPTNO LIKE D.DEPTNO
GROUP BY CUBE(DNAME,JOB);