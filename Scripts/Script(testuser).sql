-- 05-24 실습을 하자(2)
-- 제 1장 데이터 조회하기 : SELECT
-- =======================================================

-- 사원 테이블 
-- 한글 1글자가 3바이트라서 크기를 맞춰줘야 한다 
-- 옛날에는 2바이트였어서 예제에서는 2바이트로 계산했다
-- 01-001.sql
CREATE TABLE TEMP (
 EMP_ID      NUMBER NOT NULL PRIMARY KEY,
 EMP_NAME    VARCHAR2(10) NOT NULL,
 BIRTH_DATE  DATE,
 DEPT_CODE   VARCHAR2(06) NOT NULL,
 EMP_TYPE    VARCHAR2(06),
 USE_YN      VARCHAR2(01) NOT NULL,
 TEL         VARCHAR2(15),
 HOBBY       VARCHAR2(30),
 SALARY      NUMBER,
 LEV         VARCHAR2(06)
);
-- =======================================================
-- 01-002.sql
--부서 테이블
CREATE TABLE TDEPT (
 DEPT_CODE   VARCHAR2(06) NOT NULL PRIMARY KEY,
 DEPT_NAME   VARCHAR2(20) NOT NULL,
 PARENT_DEPT VARCHAR2(06) NOT NULL,
 USE_YN      VARCHAR2(01) NOT NULL,
 AREA        VARCHAR2(10),
 BOSS_ID     NUMBER
);
-- ==============================================================================================================
-- 01-003.sql
INSERT INTO TEMP VALUES (19970101,'김길동',TO_DATE('19740125','YYYYMMDD'),'AA0001','정규','Y','','등산',100000000,'부장');
INSERT INTO TEMP VALUES (19960101,'홍길동',TO_DATE('19730322','YYYYMMDD'),'AB0001','정규','Y','','낚시',72000000,'과장');
INSERT INTO TEMP VALUES (19970201,'박문수',TO_DATE('19750415','YYYYMMDD'),'AC0001','정규','Y','','바둑',50000000,'과장');
INSERT INTO TEMP VALUES (19930331,'정도령',TO_DATE('19760525','YYYYMMDD'),'BA0001','정규','Y','','노래',70000000,'차장');
INSERT INTO TEMP VALUES (19950303,'이순신',TO_DATE('19730615','YYYYMMDD'),'BB0001','정규','Y','','',56000000,'대리');
INSERT INTO TEMP VALUES (19966102,'지문덕',TO_DATE('19720705','YYYYMMDD'),'BC0001','정규','Y','','',45000000,'과장');
INSERT INTO TEMP VALUES (19930402,'강감찬',TO_DATE('19720815','YYYYMMDD'),'CA0001','정규','Y','','',64000000,'차장');
INSERT INTO TEMP VALUES (19960303,'설까치',TO_DATE('19710925','YYYYMMDD'),'CB0001','정규','Y','','',35000000,'사원');
INSERT INTO TEMP VALUES (19970112,'연흥부',TO_DATE('19761105','YYYYMMDD'),'CC0001','정규','Y','','',45000000,'대리');
INSERT INTO TEMP VALUES (19960212,'배뱅이',TO_DATE('19721215','YYYYMMDD'),'CD0001','정규','Y','','',39000000,'과장');
--
INSERT INTO TDEPT VALUES ('AA0001','경영지원','AA0001','Y','서울',19940101);
INSERT INTO TDEPT VALUES ('AB0001','재무','AA0001','Y','서울',19960101);
INSERT INTO TDEPT VALUES ('AC0001','총무','AA0001','Y','서울',19970201);
INSERT INTO TDEPT VALUES ('BA0001','기술지원','BA0001','Y','인천',19930301);
INSERT INTO TDEPT VALUES ('BB0001','H/W지원','BA0001','Y','인천',19950303);
INSERT INTO TDEPT VALUES ('BC0001','S/W지원','BA0001','Y','인천',19966102);
INSERT INTO TDEPT VALUES ('CA0001','영업','CA0001','Y','본사',19930402);
INSERT INTO TDEPT VALUES ('CB0001','영업기획','CA0001','Y','본사',19950103);
INSERT INTO TDEPT VALUES ('CC0001','영업1','CA0001','Y','본사',19970112);
INSERT INTO TDEPT VALUES ('CD0001','영업2','CA0001','Y','본사',19960212);
--
COMMIT;

-- ==============================================================================================================
SELECT * FROM TEMP; 
SELECT * FROM tdept;

-- SELECT 필드명 ... from 테이블명 .... where 조건 order by 정렬필드 ....
SELECT 
	E.EMP_ID 사번, E.EMP_NAME AS 이름
FROM 
	temp E;

SELECT 
	*
FROM 
	temp E;

-- 연봉을 이용하여 월급을 계산해보자
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 연봉, SALARY/13 월급 FROM temp;
-- 소수점이 아예 안나오게 하려면?
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 연봉, ROUND(SALARY/13) 월급 FROM temp;
--소수점 2자리 까지 봐준다면?
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 연봉, ROUND(SALARY/13,2) 월급 FROM temp;
--십의 자리에서 반올림하겠다면?
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 연봉, ROUND(SALARY/13,-2) 월급 FROM temp;

--짝수달에는 연봉의 2/18을, 홀수 달에는 1/18을 지급한다. 조회해 보자 
--별칭에 빈칸(공백)이 들어갈거면 ""를 써야 한다
SELECT
	EMP_ID 사번, EMP_NAME 이름, SALARY 연봉, 
	ROUND(SALARY/18, -2) "홀수달 월급", ROUND(SALARY/18*2, -2) "짝수달 월급" 
FROM 
	temp;

-- null의 사용 -> null 대신 '없다' 나오게 하고 싶다
SELECT * FROM TEMP t;

-- NVL함수 : NVL(값, 값이 null일 경우 표시할 내용)
SELECT EMP_NAME , NVL(HOBBY, '없다') FROM TEMP t;

-- NVL2함수 : NVL(값, 값이 있을때 나타낼 값, 값이 null일 경우 표시할 내용)
SELECT EMP_NAME , NVL2(HOBBY, HOBBY, '없다') FROM TEMP t;--취미가 null이면 없다 있으면 취미를 찍으라
SELECT EMP_NAME , NVL2(HOBBY, '있다', '없다') FROM TEMP t;

-- ===============================================================================================

SELECT EMP_NAME, HOBBY  FROM TEMP t WHERE HOBBY = '등산';
SELECT EMP_NAME, HOBBY  FROM TEMP t WHERE HOBBY <> '등산';
SELECT EMP_NAME, HOBBY  FROM TEMP t WHERE HOBBY != '등산';
-- 이렇게 쓰면 null이 안나온다

-- 아래는 아무것도 안나온다
SELECT EMP_NAME, HOBBY  FROM TEMP t WHERE HOBBY != NULL;
SELECT EMP_NAME, HOBBY  FROM TEMP t WHERE HOBBY = NULL;

-- 반드시 NULL의 비교는 is null또는 is no null을 이용해야 한다
SELECT EMP_NAME, HOBBY  FROM TEMP t WHERE HOBBY is null;
SELECT EMP_NAME, HOBBY  FROM TEMP t WHERE HOBBY is not null;
-- 조건문을 쓸때 따음표 안에 주는 명령어는 대소문자 구분을 하지만 나머지는 구분하지 않는다

-- 취미가 null인 사원의 취미를 등산으로 해서 취미가 등산인 사원 목록을 조회하시오
SELECT EMP_NAME ,NVL(HOBBY,'등산')  FROM TEMP WHERE NVL(HOBBY, '등산') = '등산';

-- 이름과 부서코드, 부서명을 조회하시오
SELECT * FROM TDEPT t ;
SELECT * FROM TEMP t ;

SELECT 
	EMP_NAME, temp.DEPT_CODE, dept_name
FROM 
	TEMP, TDEPT
WHERE
	temp.DEPT_CODE = tdept.DEPT_CODE;

SELECT 
	EMP_NAME, E.DEPT_CODE, dept_name
FROM 
	TEMP E, TDEPT D
WHERE
	E.DEPT_CODE = D.DEPT_CODE;
-- DEPT_CODE는 그냥 쓰면 양쪽 테이블에 동일한 이름으로 모두 있기에 오류가 난다. 따라서 어디 테이블의 것인지 미리 지정해줘야 한다

--성명을 보일때 괄호 안에 직급을 넣어서 보여주시오. 
--문자열 연결할때 ||(문자열 연결 연산자)를 사용
--Concat 함수: 문자열연결함수 : concat(문자열1, 문자열2)
SELECT 
	EMP_NAME || '(' || LEV || ')' , CONCAT(CONCAT(CONCAT(EMP_NAME , '(') , LEV) , ')') 
FROM 
	TEMP t;

--작은 따음표를 출력하고 싶다? ''''를 연달아 써야 한다.
SELECT 
	EMP_NAME || ''' || LEV || ''' , EMP_NAME || '''' || LEV || ''''
FROM 
	TEMP t;
--쌍 따음표는 ' ' 안에 적으면 된다
SELECT 
	EMP_NAME || ''' || LEV || ''' , 
	EMP_NAME || '"' || LEV || '"'
FROM 
	TEMP t;

SELECT 
	*
FROM
	USER_OBJECTS; -- 사용자가 가지고 있는 객체의 목록을 보여준다
	--키 필드(기본키)를 지정하면 자동으로 인덱스가 생성된다 -> 인덱스는 검색을 빠르게 하기 위한 색인표이다

-- ===============================================================================================
	
--테이블 목록을 조회하기
SELECT 
	OBJECT_NAME , OBJECT_TYPE 
FROM
	USER_OBJECTS WHERE OBJECT_TYPE = 'TABLE';
--자주쓰는 명령을 view로 만들수도 있다
SELECT * FROM tab; -- 테이블 목록 확인할때 주로 쓴다. 하는 일은 위와 같다

--모든 테이블을 지우는 명령을 만드는 명령(실제론 지우지 마라)
SELECT 'drop table ' || OBJECT_NAME || ';' FROM USER_OBJECTS WHERE OBJECT_TYPE = 'TABLE';
-- 조건문없으면 인덱스도 한꺼번에 제거
SELECT 'drop table ' || OBJECT_TYPE  || ' ' || OBJECT_NAME || ';' FROM USER_OBJECTS;

-- =============================================================================================

-- 문자열과 숫자의 연결
SELECT 
	'11' || 11 "문자와 숫자의 결합",
	'12' * '2' "문자를 연산자로 결합",
	'12' + 6 "연산자로 결합"
FROM 
	dual;

-- SUBSTR(EMP_ID, 1, 4) 에서 연산을 해서 숫자로 바뀌어버렸다
SELECT
	EMP_ID , EMP_NAME , SUBSTR(EMP_ID, 1, 4) 
FROM TEMP t
WHERE SUBSTR(EMP_ID, 1, 4) = 1997;
-- 여기는 자동으로 문자로, 숫자로 변환해서 비교한다
SELECT
	EMP_ID , EMP_NAME , SUBSTR(EMP_ID, 1, 4) 
FROM TEMP t
WHERE SUBSTR(EMP_ID, 1, 4)*1 = '1997';

SELECT 
	LEV, EMP_ID , EMP_NAME 
FROM 
	TEMP t 
ORDER BY
	1, 2 DESC; -- 1과 2는 각각 LEV, EMP_ID를 의미

SELECT 
	SALARY / 12, SALARY / 18
FROM 
	TEMP t 
ORDER BY
	1; -- 정렬할 필드의 연산식이 있는 경우에는 필드명보다 숫자가 편리하다

-- LIKE 절
SELECT 
	DEPT_CODE 
FROM 
	TEMP t 
WHERE 
	DEPT_CODE LIKE '_A%'; -- 부서코드의 2번째 글자가 A인 부서

SELECT 
	DEPT_CODE 
FROM 
	TEMP t 
WHERE 
	DEPT_CODE LIKE '%A%'; -- 부서코드의 A를 포함한 부서

SELECT 
	DEPT_CODE 
FROM 
	TEMP t 
WHERE 
	DEPT_CODE LIKE '%1'; -- 부서코드가 1로 끝나는 부서

SELECT 
	EMP_ID , EMP_NAME 
FROM 
	TEMP
WHERE 
	EMP_NAME LIKE '%동%';

-- ==============================================================================================
-- 1997년에 입사한 사원의 목록을 조회하시오
SELECT 
	EMP_ID ,EMP_NAME 
FROM 
	TEMP t 
WHERE 
	SUBSTR(EMP_ID, 1, 4) = 1997 ;

SELECT 
	EMP_ID ,EMP_NAME 
FROM 
	TEMP t 
WHERE 
	EMP_ID >= 19970001 AND EMP_ID <= 19979999 ;

SELECT 
	EMP_ID ,EMP_NAME 
FROM 
	TEMP t 
WHERE 
	EMP_ID BETWEEN 19970101 AND 19971231 ;
-- ===============================================================================================

-- IN , NOT IN
-- 포함하느냐? 포함하지 않느냐?
-- 과장과 부장, 차장을 조회하시오
SELECT EMP_NAME , LEV  FROM TEMP t WHERE LEV = '과장' OR  LEV = '부장' OR LEV ='차장';
SELECT EMP_NAME , LEV  FROM TEMP t WHERE LEV IN ('과장' ,'부장','차장');
SELECT EMP_NAME , LEV  FROM TEMP t WHERE LEV NOT IN ('과장' ,'부장','차장');


-- ==============================================================================================
-- group by ~ HAVING 
-- 그룹함수 MAX, MIN, SUM, AVG, COUNT

--직급별 최대 연봉, 최소 연봉
SELECT 
	lev, MAX(SALARY) 최대연봉, MIN(SALARY) 최소연봉  
FROM 
	TEMP
GROUP BY lev;

--직급별 최대 연봉이 70,000,000이상인 직급을 조회
SELECT 
	lev, MAX(SALARY) 최대연봉, MIN(SALARY) 최소연봉  
FROM 
	TEMP
GROUP BY lev
WHERE MAX(SALARY) >= 70000000; -- 에러 

SELECT 
	lev, MAX(SALARY) 최대연봉, MIN(SALARY) 최소연봉  
FROM 
	TEMP
WHERE MAX(SALARY) >= 70000000; -- 위치를 바꿔도 에러
GROUP BY lev

SELECT 
	lev, MAX(SALARY) 최대연봉
FROM 
	TEMP
GROUP BY lev
HAVING MAX(SALARY) >= 70000000;-- 그룹지어준 곳에 조건을 달때는 having으로 조건을 준다

-- =============================================================================================
-- 직급만 중복없이 보고 싶다
SELECT LEV 
FROM TEMP t; -- 모든 행이 나온다
 
SELECT DISTINCT  LEV -- 중복제거 
FROM TEMP t;

SELECT LEV FROM TEMP t GROUP BY lev; -- 그룹을 지어서 중복을 없애기

--==============================================================================================

-- 직급별 막내 중에서 1997년에 입사한 사람만 조회
SELECT LEV , MAX(EMP_ID) 
FROM 
	TEMP 
GROUP BY
	LEV
HAVING 
	MAX(EMP_ID) LIKE '1997%'













