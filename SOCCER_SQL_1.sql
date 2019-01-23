desc player;
create view pla as
select 
    player_id pid,
    PLAYER_NAME pname,
    TEAM_ID tid,
    E_PLAYER_NAME epname, 
    NICKNAME nname,
    JOIN_YYYY joy,
    POSITION pos,
    BACK_NO bano,
    NATION nat,
    BIRTH_DATE bdate,
    SOLAR sol,
    HEIGHT hei,
    WEIGHT wei
from player;
select * from pla;
select * from player;
select * from team;
desc team;
create view tea as
select 
    TEAM_ID tid,
    REGION_NAME rname, 
    TEAM_NAME tname,
    E_TEAM_NAME etn,
    ORIG_YYYY ory,
    STADIUM_ID sid,
    ZIP_CODE1 zcd1,
    ZIP_CODE2 zcd2,
    ADDRESS adr,
    DDD,
    TEL,
    FAX,
    HOMEPAGE hop,
    OWNER own
from team;
 select * from tea;

-- SQL_TEST_001
-- 전체 축구팀 목록. 이름 오름차순

select t.tname "전체 축구팀 목록"
from tea t 
order by t.TNAME asc;

-- SQL_TEST_002
-- 포지션 종류(중복제거,없으면 빈공간)

select distinct pos 포지션 
from pla;

-- SQL_TEST_003
-- 포지션 종류(중복제거,없으면 신입으로 기재)
-- nvl2()사용

select distinct nvl2(pos ,pos,'신입') 포지션 
from pla;


-- SQL_TEST_004
-- 수원팀(ID: K02)골키퍼
select * from tea;
select rname from tea;
select tid from tea; -- tid 
select * from pla;

select p.pname 수원
from pla p
where p.tid like 'K02';

select p.pname 이름, p.TID ID 
from pla p
where p.pname like '김운재';

select p.pname 이름
from pla p
where p.tid like 'K02'; 

-- 답 
select p.pname 이름 
from pla p
where p.pos like 'GK' and p.tid like 'K02'
order by p.pname asc;


-- SQL_TEST_005
-- 수원팀(ID: K02)키가 170 이상 선수
-- 이면서 성이 고씨인 선수
select * from pla;

select p.POS 포지션, p.pname 이름
from pla p
where p.tid like 'K02' and p.HEI >= 170 and p.pname like '고%' ;


-- SQL_TEST_006
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- 키 내림차순
select * from pla;

select concat(p.PNAME,'선수')이름, 
    to_char (nvl2(p.hei,p.hei,'0')||'cm') 키, 
    to_char (nvl2(p.wei,p.wei,'0')||'kg' ) 몸무게
from pla p
where p.tid like 'K02'
order by p.hei desc;


-- SQL_TEST_007
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- BMI지수 
-- 키 내림차순
--nvl2(weight,weight,'0')'kg'
select concat(player_name,'선수')이름, 
    to_char (nvl2(height,height,'0')||'cm') 키, 
    to_char (nvl2(weight,weight,'0')||'kg') 몸무게,
    round(WEIGHT/(HEIGHT*HEIGHT)*10000, 2) "BMI 지수"
from (select player_name, height, weight
      from player 
      where team_id like 'K02')
order by height desc;

-- SQL_TEST_008
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 
--  포지션이 GK 인  선수
-- 팀명, 사람명 오름차순

SELECT T.TEAM_NAME, P.POSITION, P.PLAYER_NAME 
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE T.TEAM_ID IN('K02','K10') AND POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;

-- SQL_TEST_009
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- 키가 180 이상 183 이하인 선수들
-- 키, 팀명, 사람명 오름차순

SELECT T.TEAM_NAME 팀명, P.PLAYER_NAME 이름,  to_char(P.HEIGHT||'cm') 키 
FROM (SELECT T.TEAM_ID, T.TEAM_NAME
      FROM TEAM T WHERE T.TEAM_ID IN('K02','K10')) T
    JOIN PLAYER P 
        ON T.TEAM_ID LIKE P.TEAM_ID
WHERE P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME ;


-- SOCCER_SQL_010
-- 모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순

SELECT T.TEAM_NAME 팀명, P.PLAYER_NAME 이름
FROM (SELECT P.TEAM_ID, P.PLAYER_NAME 
        FROM PLAYER P WHERE P.POSITION IS NULL) P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;

-- SOCCER_SQL_011
-- 팀과 스타디움을 조인하여
-- 팀이름, 스타디움 이름 출력
 
SELECT T.TEAM_NAME 팀명, S.STADIUM_NAME 스타디움
FROM TEAM T
    JOIN STADIUM S
    ON T.STADIUM_ID LIKE S.STADIUM_ID
ORDER BY T.TEAM_NAME ;



-- SOCCER_SQL_012
-- 팀과 스타디움, 스케줄을 조인하여
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력
-- 다중테이블 join 을 찾아서 해결하시오

SELECT * FROM SCHEDULE;
SELECT * FROM TEAM;
SELECT * FROM STADIUM;

SELECT T.TEAM_NAME 팀명, S.STADIUM_NAME 스타디움, 
        J.AWAYTEAM_ID "원정팀 ID", J.SCHE_DATE 스케줄날짜  
FROM STADIUM S
    JOIN SCHEDULE J 
    ON S.STADIUM_ID LIKE J.STADIUM_ID
    JOIN TEAM T 
    ON J.STADIUM_ID LIKE T.STADIUM_ID
WHERE J.SCHE_DATE LIKE '20120317'
ORDER BY T.TEAM_NAME; 

-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오

SELECT P.PLAYER_NAME 선수명, P.POSITION 포지션,
       T.REGION_NAME||' '||T.TEAM_NAME 팀명, 
       S.STADIUM_NAME 스타디움, J.SCHE_DATE 스케줄날짜
       
FROM ( SELECT J.SCHE_DATE, J.HOMETEAM_ID, J.STADIUM_ID
       FROM SCHEDULE J
       WHERE J.SCHE_DATE LIKE '20120317' AND HOMETEAM_ID LIKE 'K03') J
    JOIN (SELECT S.STADIUM_ID, S.STADIUM_NAME
            FROM STADIUM S) S
        ON J.STADIUM_ID LIKE S.STADIUM_ID
    JOIN TEAM T 
        ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN (SELECT P.TEAM_ID, P.POSITION, P.PLAYER_NAME
            FROM PLAYER P
            WHERE POSITION LIKE 'GK') P 
        ON T.TEAM_ID LIKE P.TEAM_ID
ORDER BY P.PLAYER_NAME; 


-- SOCCER_SQL_014
-- 홈팀이 3점이상 차이로 승리한 경기의 
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오
SELECT * FROM SCHEDULE;
SELECT * FROM TEAM;
SELECT * FROM STADIUM;

SELECT * 
FROM SCHEDULE C
WHERE (C.HOME_SCORE-C.AWAY_SCORE) >=3 
ORDER BY C.HOME_SCORE DESC;

SELECT STADIUM_NAME 스타디움, SCHE_DATE 경기날짜 , 
       (T.REGION_NAME||' '|| T.TEAM_NAME) 홈팀,
       (T.REGION_NAME ||' '||
       (SELECT T.TEAM_NAME
       FROM TEAM T
       WHERE C.AWAYTEAM_ID LIKE T.TEAM_ID
       ))원정팀,
       HOME_SCORE "홈팀 점수", AWAY_SCORE "원정팀 점수"
FROM (SELECT SCHE_DATE, HOME_SCORE, AWAY_SCORE, STADIUM_ID,
        HOMETEAM_ID, AWAYTEAM_ID
      FROM SCHEDULE C
      WHERE(C.HOME_SCORE-C.AWAY_SCORE) >=3 ) C
      JOIN STADIUM S
      ON C.STADIUM_ID LIKE S.STADIUM_ID
      JOIN TEAM T 
      ON S.HOMETEAM_ID LIKE T.TEAM_ID
ORDER BY HOME_SCORE DESC;


-- SOCCER_SQL_015
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
-- 카운트 값은 20

SELECT * FROM STADIUM;
SELECT * FROM TEAM;

SELECT COUNT(*) FROM STADIUM;

SELECT S.STADIUM_NAME, S.STADIUM_ID, S.SEAT_COUNT, 
       S.HOMETEAM_ID, S.HOMETEAM_ID, T.E_TEAM_NAME
FROM STADIUM S
     LEFT JOIN TEAM T
     ON S.STADIUM_ID LIKE T.STADIUM_ID;
     
SELECT S.STADIUM_NAME, S.STADIUM_ID, S.SEAT_COUNT, 
       S.HOMETEAM_ID, S.HOMETEAM_ID, 
       (SELECT T.E_TEAM_NAME
        FROM TEAM T
        WHERE T.STADIUM_ID LIKE S.STADIUM_ID) TEAM_NAME
FROM STADIUM S ;


-- SOCCER_SQL_016
-- 평균키가 인천 유나이티스팀의 평균키 보다 작은 팀의 
-- 팀ID, 팀명, 평균키 추출
SELECT * FROM PLAYER;

SELECT AVG(P.HEIGHT)
FROM PLAYER P ;

SELECT TEAM_ID, AVG(P.HEIGHT)
FROM PLAYER P
GROUP BY P.TEAM_ID;


SELECT P.HEIGHT 
FROM PLAYER P
GROUP BY P.HEIGHT
ORDER BY P.HEIGHT;

SELECT * FROM PLAYER;
SELECT * FROM TEAM;
SELECT T.TEAM_ID, T.TEAM_NAME, P.PLAYER_NAME, P.HEIGHT
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.TEAM_ID LIKE 'K04'
GROUP BY AVG(P.HEIGHT);    
--WHERE AVG(TEAM_ID);

SELECT * 
FROM PLAYER 
WHERE TEAM_ID LIKE 'K04';

SELECT AVG(HEIGHT)
      FROM PLAYER 
      WHERE TEAM_ID LIKE 'K04';

SELECT AVG(HEIGHT)
FROM PLAYER

GROUP BY TEAM_ID
ORDER BY TEAM_ID;

SELECT TEAM_ID, COUNT(TEAM_ID), ROUND(AVG(HEIGHT),2)
FROM PLAYER 
GROUP BY TEAM_ID
HAVING AVG(HEIGHT) < 180.51
ORDER BY AVG(HEIGHT);

--답 
SELECT T.TEAM_ID 팀아이디, T.TEAM_NAME 팀명, 
        평균키
FROM (SELECT P.TEAM_ID, ROUND(AVG(P.HEIGHT),0) 평균키
        FROM PLAYER P
        GROUP BY P.TEAM_ID
        HAVING AVG(P.HEIGHT) < (SELECT AVG(P2.HEIGHT)
                                FROM PLAYER P2
                                WHERE P2.TEAM_ID LIKE 'K04'
                                )
        ) P
       JOIN TEAM T
       ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY 평균키;
--ORDER BY ;

--1단계 
SELECT P.TEAM_ID 팀ID,
       T.TEAM_NAME 팀명,
       AVG(P.HEIGHT) 평균키
FROM TEAM T
    JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY P.TEAM_ID, T.TEAM_NAME
ORDER BY 평균키;

--2단계
SELECT P.TEAM_ID 팀ID,
       T.TEAM_NAME 팀명,
       AVG(P.HEIGHT) 평균키
FROM TEAM T
    JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY P.TEAM_ID, T.TEAM_NAME
HAVING AVG(P.HEIGHT) < 180
ORDER BY 평균키;

--3단계
SELECT P.TEAM_ID 팀ID,
       T.TEAM_NAME 팀명,
       ROUND(AVG(P.HEIGHT),0) 평균키
FROM TEAM T
    JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY P.TEAM_ID, T.TEAM_NAME
HAVING AVG(P.HEIGHT) < (SELECT AVG(P.HEIGHT)
                        FROM TEAM T
                            JOIN PLAYER P
                                 ON T.TEAM_ID LIKE P.TEAM_ID
                        WHERE T.TEAM_NAME LIKE '유나이티드')
ORDER BY 평균키;

-- SOCCER_SQL_017
-- 포지션이 MF 인 선수들의  소속팀명 및 선수명, 백넘버 출력

SELECT T.TEAM_NAME 팀명, P.PLAYER_NAME 선수명, P.BACK_NO 백넘버 
FROM (
       SELECT *
       FROM PLAYER 
       WHERE POSITION LIKE 'MF') P
      JOIN TEAM T
      ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY P.PLAYER_NAME;


-- SOCCER_SQL_018
-- 가장 키큰 선수 5 추출, 오라클, 단 키 값이 없으면 제외

SELECT * FROM PLAYER;

SELECT HEIGHT
FROM PLAYER
WHERE HEIGHT IS NOT NULL
ORDER BY HEIGHT DESC; 

SELECT PLAYER_NAME 선수명, BACK_NO 백넘버, POSITION 포지션, HEIGHT 키
FROM (
       SELECT HEIGHT, PLAYER_NAME, BACK_NO, POSITION
       FROM PLAYER
       WHERE HEIGHT IS NOT NULL
       ORDER BY HEIGHT DESC )
WHERE ROWNUM BETWEEN 1 AND 5;     
     

-- SOCCER_SQL_019
-- 선수 자신이 속한 팀의 평균키보다 작은 선수 정보 출력
SELECT * 
FROM PLAYER 
;


SELECT P.TEAM_ID
FROM PLAYER P
GROUP BY P.TEAM_ID
HAVING AVG(P.HEIGHT) < 180
;

SELECT T.TEAM_ID, ROUND(AVG(T.HEIGHT),0) 평균
FROM PLAYER T
GROUP BY T.TEAM_ID
 ;

SELECT *
FROM PLAYER P
WHERE P.HEIGHT > ( 
                   SELECT AVG(T.HEIGHT) 평균
                    FROM PLAYER T
                    GROUP BY T.TEAM_ID
                   
                    )
                    ;


SELECT *
FROM 
      (
      SELECT P.TEAM_ID
      FROM PLAYER P
      GROUP BY P.TEAM_ID
      HAVING AVG(P.HEIGHT) > P.HEIGHT 
      ORDER BY AVG(P.HEIGHT))T
;

SELECT L.TEAM_ID, ROUND(AVG(L.HEIGHT),0) 평균
        FROM PLAYER L
        GROUP BY L.TEAM_ID 
        ORDER BY AVG(L.HEIGHT);

SELECT P.TEAM_ID, 평균, T.TEAM_ID 팀아이디
FROM TEAM T
    JOIN ( SELECT P.TEAM_ID, ROUND(AVG(P.HEIGHT),0) 평균
        FROM PLAYER P
        GROUP BY P.TEAM_ID 
        ORDER BY AVG(P.HEIGHT)) P
    ON P.TEAM_ID LIKE T.TEAM_ID

 ;

--틀린 내답** 
SELECT ( SELECT TEAM_NAME
        FROM TEAM
        WHERE TEAM_ID LIKE P.TEAM_ID) 팀명,
       P.PLAYER_NAME 선수명, P.POSITION 포지션,
       P.BACK_NO 백넘버, P.HEIGHT, 평균
       
FROM PLAYER P
     JOIN (SELECT L.TEAM_ID, ROUND(AVG(L.HEIGHT),0) 평균
            FROM PLAYER L
            GROUP BY L.TEAM_ID 
            ORDER BY AVG(L.HEIGHT))T
      ON P.TEAM_ID LIKE T.TEAM_ID
     
WHERE P.HEIGHT < T."평균"
ORDER BY P.PLAYER_NAME ;

--** 최종답 !! 
SELECT ( SELECT TEAM_NAME
        FROM TEAM
        WHERE TEAM_ID LIKE P.TEAM_ID) 팀명,
       P.PLAYER_NAME 선수명, P.POSITION 포지션,
       P.BACK_NO 백넘버, P.HEIGHT
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.HEIGHT < (SELECT AVG(P2.HEIGHT)
                   FROM PLAYER P2
                   WHERE P2.TEAM_ID LIKE P.TEAM_ID)
ORDER BY P.PLAYER_NAME;
 
 
-- SOCCER_SQL_020
-- 2012년 5월 한달간 경기가 있는 경기장 조회
-- EXISTS 쿼리는 항상 연관쿼리로 상요한다.
-- 또한 아무리 조건을 만족하는 건이 여러 건이라도
-- 조건을 만족하는 1건만 찾으면 추가적인 검색을 진행하지 않는다

SELECT * FROM SCHEDULE;

SELECT S.STADIUM_ID ID, S.STADIUM_NAME 경기장명
FROM STADIUM S 
WHERE EXISTS (
              SELECT 1
              FROM SCHEDULE C
              WHERE S.STADIUM_ID LIKE C.STADIUM_ID 
              AND C.SCHE_DATE BETWEEN '20120501' AND '20120530'
             
              --AND C.SCHE_DATE IN('20120501', '20120530') 
                )
 ORDER BY S.STADIUM_NAME;
 
 -- SOCCER_SQL_021
-- 이현 선수 소속팀의 선수명단 출력



-- SOCCER_SQL_022
-- NULL 처리에 있어
-- SUM(NVL(SAL,0)) 로 하지말고
-- NVL(SUM(SAL),0) 으로 해야 자원낭비가 줄어든다
-- 팀별 포지션별 인원수와 팀별 전체 인원수 출력
-- Oracle, Simple Case Expr 



-- SOCCER_SQL_023
-- GROUP BY 절 없이 전체 선수들의 포지션별 평균 키 및 전체 평균 키 출력


-- SOCCER_SQL_024 
-- 소속팀별 키가 가장 작은 사람들의 정보


-- SOCCER_SQL_025 
-- K-리그 2012년 8월 경기결과와 두 팀간의 점수차를 ABS 함수를 사용하여
-- 절대값으로 출력하기


-- SOCCER_SQL_026 
-- 20120501 부터 20120602 사이에 경기가 있는 경기장 조회

-- SOCCER_SQL_027 
-- 선수정보와 해당 선수가 속한  팀의 평균키 조회
-- 단, 정렬시 평균키 내림차순

-- SOCCER_SQL_028 
-- 평균키가 삼성 블루윙즈 팀이 평균키보다 작은 팀의 
-- 이름과 해당 팀의 평균키

-- SOCCER_SQL_029 
-- 드래곤즈,FC서울,일화천마 각각의 팀 소속의 GK, MF 선수 정보

-- SOCCER_SQL_030 
-- 29번에서 제시한 팀과 포지션이 아닌 선수들의 수