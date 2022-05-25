-- (제2장) 함수
-- ================================================================================================
-- INSTR (문자열 또는 필드, 찾는 문자) : 찾는 문자의 첫번쨰 위치를 알려준다. 문자단위로 처리
-- INSTRB (문자열 또는 필드, 찾는 문자) : 찾는 문자의 첫번쨰 위치를 알려준다. 바이트 단위로 처리
 SELECT 
 	INSTR('우리나라 좋은나라','나라'),
 	INSTR('우리나라 좋은나라','국가'),
 	INSTRB('우리나라 좋은나라','나라'), -- 현재 우리의 오라클에서 한글은 3바이트로 처리한다. 그래서 7이 나온다.
 	INSTRB('우리나라 좋은나라','국가')
 FROM 
 	dual;
 
 -- INSTR (문자열 또는 필드, 찾는 문자, 시작 위치, 몇번째)
  SELECT 
 	INSTR('우리나라 좋은나라 나라','나라', 5 , 2), -- 5번째부터 2번째로 나오는 부분
 	INSTRB('우리나라 좋은나라 나라','나라', 8 , 1) -- 8번째 부터 1번째로 나오는거
 FROM 
 	dual;
-- ================================================================================================
-- SUBSTR(문자열 또는 필드, 시작위치, 개수)
  SELECT 
 	SUBSTR('우리나라 좋은나라 나라', 1 , 3),
 	SUBSTR('우리나라 좋은나라 나라', 3 , 5),
 	SUBSTR('우리나라 좋은나라 나라', 5) -- 길이를 생략하면 끝까지
 FROM 
 	dual;
 
-- SUBSTRB(문자열 또는 필드, 시작위치, 개수)
  SELECT 
 	SUBSTRB('우리나라 좋은나라 나라', 1 , 3),
 	SUBSTRB('우리나라 좋은나라 나라', 3 , 5),
 	SUBSTRB('우리나라 좋은나라 나라', 5) -- 길이를 생략하면 끝까지
 FROM 
 	dual;

-- LENGTH(문자열 또는 필드) : 문자열의 길이를 구한다
  SELECT 
 	LENGTH('우리나라 좋은나라 QWERTY 1234'),
 	LENGTHB('우리나라 좋은나라 QWERTY 1234'),
 	(LENGTHB('우리나라 좋은나라 QWERTY 1234') - LENGTH('우리나라 좋은나라 QWERTY 1234'))/2 한글
 FROM 
 	dual;


-- LPAD (문자열 또는 필드, 길이, 문자)
-- RPAD (문자열 또는 필드, 길이, 문자) 
-- 한글을 2바이트로 계산한다
SELECT 
	LPAD(DEPT_NAME, 10, '*') -- 10칸을 확보하고 앞에 *을 찍어라
	,RPAD(DEPT_NAME, 10, '*') 
FROM
	TDEPT;

SELECT 
	LPAD(DEPT_NAME, 10, '1234567890') -- 여러개쓰면 해당하는 길이 만큼만
	,RPAD(DEPT_NAME, 10, '1234567890') -- 만약 *처럼 작은것을 쓰고 길이가 넓으면 반복되어 찍힌다
FROM
	TDEPT;

--- 아래와 같이 부서이름을 조회하시오!!!!
--- 경영지원90  --> 9
--- 재무567890  --> 5
--- h/w지원890  --> 8
--- 영업167890  --> 6
SELECT 
   DEPT_NAME, 
   RPAD(DEPT_NAME, 10, '*'),
   RPAD(DEPT_NAME, 10, SUBSTR('1234567890', (LENGTHB(DEPT_NAME)-LENGTH(DEPT_NAME))/2 * 2  + 1)), -- 한글만 들어가면 가능
   RPAD(DEPT_NAME, 10, SUBSTR('1234567890', ((LENGTHB(DEPT_NAME)-LENGTH(DEPT_NAME))/2*2)+(LENGTH(DEPT_NAME)-(LENGTHB(DEPT_NAME)-LENGTH(DEPT_NAME))/2)+1)), -- 한글만 들어가면 가능
   (LENGTHB(DEPT_NAME)-LENGTH(DEPT_NAME))/2 "한글글자수",
   LENGTH(DEPT_NAME) - (LENGTHB(DEPT_NAME)-LENGTH(DEPT_NAME))/2 "영숫자개수",
   (LENGTHB(DEPT_NAME)-LENGTH(DEPT_NAME))/2 * 2  + 1 "시작위치1",
   ((LENGTHB(DEPT_NAME)-LENGTH(DEPT_NAME))/2*2)+(LENGTH(DEPT_NAME)-(LENGTHB(DEPT_NAME)-LENGTH(DEPT_NAME))/2)+1 "시작위치2" -- 한글과 영어를 파악한다
FROM 
   TDEPT;
  
-- REPLACE(문자열, 찾는문자, 바꿀문자)
SELECT 
 	REPLACE('우리나라 좋은나라 QWERTY 1234', '나라', '국가'),
 	REPLACE(REPLACE('우리나라 좋은나라 QWERTY 1234', 'QWERTY',''),'1234',''),
 	REGEXP_REPLACE('우리나라 좋은나라 QWERTY 1234', '[A-Z0-9]') -- 정규표현식을 써서 한번에 바꾼다 A-Z와 0-9까지 모두 제거
 FROM 
 	dual;
/*
오라클은 10g 부터 REGEXP로 시작하는 함수를 지원 합니다. (Regular Expression 이라는 정규식의 의미 입니다.)
이 함수를 통해 데이터의 패턴을 보다 다양하게 찾고, 변경할 수 있게 되었습니다.

정규식 함수는 다음과 같습니다.

함수               설명
REGEXP_LIKE            Like 연산과 유사하여 정규식 패턴을 검색
REGEXP_REPLACE         정규식 패턴을 검색하여 대체 문자열로 변경
REGEXP_INSTR         정규식 패턴을 검색하여 위치 반환
REGEXP_SUBSTR         정규식 패턴을 검색하여 부분 문자 추출
REGEXP_COUNT(v11g)      정규식 패턴을 검색하여 발견된 횟수를 반환
*/

 SELECT
 	'한' || CHR(13) ||'사' || CHR(13) ||'람' -- CHR(13)은 아스키 코드에서 엔터를 의미 
 FROM 
 	dual;

SELECT
	'사번: ' || EMP_ID || CHR(10) || '이름: ' || EMP_NAME --CHR(10)도 리눅스에서 엔터이지만 윈도우에서는 이상한 기호가 붙는다  
FROM 
	TEMP t;


--
SELECT 
	ROUND(567.5678),
	ROUND(567.5678, 1),
	ROUND(567.5678, 2),
	ROUND(567.5678, -1),
	ROUND(567.5678, -2)
FROM 
	dual;
-- 문제: 부서별 연봉 평균 1,000,000의 자리에서 반올림
SELECT
	DEPT_CODE , AVG(SALARY), ROUND(AVG(SALARY),-7)  
FROM 
	TEMP t 
GROUP BY
	DEPT_CODE ;


--버림과 올림?
SELECT 
	ROUND(567.8989) 반올림, 
	ROUND(567.1989 + 0.4) 올림,
	ROUND(567.989 - 0.5) 버림,
	ROUND(567.889 - 0.3) "8이상 올림 7이하 버림",
	ROUND(567.789 - 0.3) "8이상 올림 7이하 버림"
FROM 
	dual;

SELECT 
	TRUNC(567.5678),
	TRUNC(567.5678, 1),
	TRUNC(567.5678, 2),
	TRUNC(567.5678, -1),
	TRUNC(567.5678, -2)
FROM 
	dual;

SELECT 
	SIGN(123), 
	SIGN(-123), 
	SIGN(0), 
	SIGN(''), 
	SIGN('123'),
	-- SIGN('-123A') 처럼 숫자가 아닌 값은 숫자로 변환되어 표시하는데, 만약 숫자로 변환할수 없으면 에러
	SIGN('-123')
FROM 
	dual;

SELECT 
	ceil(123.5),ceil(-123.5),ceil(123.4),ceil(-123.4),
	FLOOR(123.5),FLOOR(-123.5),FLOOR(123.4),FLOOR(-123.4) 
FROM 
	dual;
	

SELECT
	MOD(23 , 5) , MOD(5, 7), MOD(5, 5)
FROM
	dual;

-- SELECT 명령을 이용하여 테이블을 생성할수 있다
-- SELECT 한 결과가 테이블로 만들어 진다
CREATE TABLE imsi AS SELECT emp_id id, emp_name name, salary sal FROM temp;
SELECT * FROM imsi;
DELETE FROM IMSI;
ROLLBACK; -- 명령취소

SELECT * FROM TEMP t;
SELECT rownum, rowid, t.* FROM TEMP t;
SELECT rownum, rowid, t.* FROM TEMP t ORDER BY EMP_ID DESC;

CREATE TABLE mod_table AS SELECT rownum NO FROM TEMP t;
SELECT * FROM MOD_TABLE mt;

-- 2의 0승부터 2의 10승까지 조회하자
INSERT INTO MOD_TABLE VALUES (11);
SELECT POWER(2, NO-1) "2의 누승" FROM MOD_TABLE mt;

-- 날짜 함수
-- 날짜와 날짜를 더하면? 에러가 나온다
SELECT 
	EMP_NAME , BIRTH_DATE , BIRTH_DATE + SYSDATE 
FROM 
	TEMP t ;

-- 그러면 날짜와 정수(숫자)를 더하면? 일이 증가된 상태로 보인다
SELECT 
	EMP_NAME , BIRTH_DATE , BIRTH_DATE + 2
FROM 
	TEMP t ;
-- 날짜와 정수(숫자)를 뺴면? 일이 감소된 상태로 보인다
SELECT 
	EMP_NAME , BIRTH_DATE , BIRTH_DATE - 2
FROM 
	TEMP t ;

-- 정수부분은 날짜(일수), 소수부분은 시간
SELECT 
	SYSDATE - 1 어제, SYSDATE 오늘, SYSDATE + 1 내일,
	SYSDATE - 1.5 어제, SYSDATE 오늘, SYSDATE + 1.5 내일, -- 0.5로 인해 시간이 12시간 차이나게 된다
	SYSDATE - 1/24 "1시간전", SYSDATE + 1/24 "1시간후"
FROM 
	dual;

-- 오늘부터 10일간의 날짜를 얻어오라
SELECT 
	SYSDATE + (NO - 1)
FROM
	MOD_TABLE mt 
WHERE 
	NO < 11;

--날짜를 문자열로 변환하는 함수
-- TO_CHAR(날짜, 형식)
SELECT
	BIRTH_DATE , BIRTH_DATE || '', -- ''를 하고나니 내가 원하는 양식이 아니다
	TO_CHAR(BIRTH_DATE,'YYYY-MM-DD'), --이렇게 원하는 형식을 지정할수 있다
	TO_CHAR(SYSDATE,'YY-MM-DD'),
	TO_CHAR(SYSDATE ,'HH:MI:SS'),
	TO_CHAR(SYSDATE ,'HH24:MI:SS')
FROM 
	TEMP t ;

-- 직원이 살아온 일수
SELECT
	EMP_NAME , 
	round(SYSDATE - BIRTH_DATE) "살아온 일수",
	round((SYSDATE - BIRTH_DATE)/365) "나이",
	round((SYSDATE - BIRTH_DATE)/365.2422) "나이"
FROM 
	TEMP t ;

-- 월을 더해주는 함수
-- ADD_MONTHS
SELECT 
	SYSDATE,
	ADD_MONTHS(SYSDATE, 1) "1",
	ADD_MONTHS(SYSDATE, 2) "2",
	ADD_MONTHS(SYSDATE, 12) "3",
	ADD_MONTHS(SYSDATE, -1) "4",
	ADD_MONTHS(SYSDATE, -2) "5",
	ADD_MONTHS(SYSDATE, -12) "6"
FROM 
	dual;

-- MONTHS_BETWEEN : 월의 간격 구해준다
SELECT
	EMP_NAME , 
	ROUND( MONTHS_BETWEEN(SYSDATE, BIRTH_DATE) , 2) "살아온 월수", 
	ROUND( MONTHS_BETWEEN(SYSDATE, BIRTH_DATE) / 12) "나이",
	round((SYSDATE - BIRTH_DATE)/365.2422) "나이"
FROM 
	TEMP t ;

-- 마지막 날짜를 구해준다
SELECT
	BIRTH_DATE,
	LAST_DAY(BIRTH_DATE), 
	to_char(LAST_DAY(BIRTH_DATE), 'DD') "생월의 마지막 날짜",
	LAST_DAY(BIRTH_DATE)+1 "다음달 1일의 날짜" -- 숫자와 더하게 되면 날짜가 아니라 숫자가 된다
FROM 
	TEMP t ;

-- 다음달 1일의 날짜
SELECT
	TO_CHAR(BIRTH_DATE, 'YEAR') ,
	TO_CHAR(BIRTH_DATE, 'month') ,
	TO_CHAR(BIRTH_DATE, 'mon') ,
	TO_CHAR(BIRTH_DATE, 'day'),
	TO_CHAR(BIRTH_DATE, 'DY')
FROM 
	TEMP t ;
-- 그룹함수
SELECT
	COUNT(*), COUNT(EMP_ID), COUNT(HOBBY) 
FROM
	TEMP t ; -- 10 10 4 (null 제외)

SELECT 
	sum(SALARY), SUM(SALARY)/COUNT(*), AVG(SALARY), MAX(SALARY), MIN(SALARY)  
FROM 
	TEMP t ;

-- 취미가 있는 사원의 평균연봉과 취미가 없는 사원의 표준연봉을 구하고 싶다
SELECT 
	SUM(SALARY)/COUNT(*), AVG(SALARY)  
FROM 
	TEMP t 
WHERE
	HOBBY IS NOT NULL; 

SELECT 
	SUM(SALARY)/COUNT(*), AVG(SALARY)  
FROM
	TEMP t 
WHERE
	HOBBY IS NULL; 

-- 직급의 종류를 보고 싶다
SELECT DISTINCT lev FROM TEMP t ;
-- 직급의 개수는?
SELECT COUNT( DISTINCT lev ) FROM TEMP t ;


-- 오라클에서 증가하는 숫자 만들기
SELECT level FROM dual CONNECT BY LEVEL <= 20; -- level이 한없이 증가하는데 20까지만 증가시킨다
CREATE TABLE list_table AS  SELECT LEVEL no FROM dual CONNECT BY LEVEL <= 100; -- level은 필드명으로 쓸수 없다
SELECT COUNT(*) FROM list_table; 


-- 이번달 1일부터 말일까지의 날짜를 구하라
SELECT 
	TO_CHAR(SYSDATE - TO_CHAR(SYSDATE, 'DD') + 1, 'YYYY-MM-DD') "1일",
	TO_CHAR(LAST_DAY( SYSDATE ), 'YYYY-MM-DD') "말일"
FROM 
	dual;

SELECT 
	TO_CHAR(SYSDATE - TO_CHAR(SYSDATE, 'DD') + LEVEL, 'YYYY-MM-DD') "일자"
FROM 
	dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY( SYSDATE ), 'DD'); -- level은 숫자이기에 비교를 하면서 문자열인 to_char이 자동으로 숫자가 된다


-- 직급별 최소 연봉을 가진 직원의 사번과 연봉을 조회하시오(서브쿼리 사용하지 말라)
SELECT
	lev, 
	--min(LPAD(SALARY, 10, 0) || EMP_ID), -- 월급을 10칸으로 만들어 뒤에 사번을 붙이고 최소값을 구한다
	SUBSTR(min(LPAD(SALARY, 10, 0) || EMP_ID), 11) "사번",
	min(SALARY) 최소연봉
FROM 
	TEMP t 
GROUP BY 
	LEV;

-- 서브쿼리를 쓰면 다음과 같다
SELECT LEV , EMP_ID ,SALARY FROM TEMP 
WHERE 
	(lev, SALARY) IN (SELECT lev, min(SALARY) FROM TEMP t GROUP BY	LEV); -- 멀티 로우라서 in을 쓴다

	
INSERT INTO TEMP VALUES (20000101,'이태백',TO_DATE('19800125','YYYYMMDD'),'AA0001','인턴','Y','123-4567','등산', 30000000,'수습');
INSERT INTO TEMP VALUES (20000102,'김설악',TO_DATE('19800322','YYYYMMDD'),'AB0001','인턴','Y','234-5678','낚시', 30000000,'수습');
INSERT INTO TEMP VALUES (20000203,'최오대',TO_DATE('19800415','YYYYMMDD'),'AC0001','인턴','Y','345-6789','바둑', 30000000,'수습');
INSERT INTO TEMP VALUES (20000334,'박지리',TO_DATE('19800525','YYYYMMDD'),'BA0001','인턴','Y','456-7890','노래', 30000000,'수습');
INSERT INTO TEMP VALUES (20000305,'정북악',TO_DATE('19800615','YYYYMMDD'),'BB0001','인턴','Y','567-8901','독서', 30000000,'수습');
INSERT INTO TEMP VALUES (20006106,'유도봉',TO_DATE('19800705','YYYYMMDD'),'BC0001','인턴','Y','678-9012','술',   30000000,'수습');
INSERT INTO TEMP VALUES (20000407,'윤주왕',TO_DATE('19800815','YYYYMMDD'),'CA0001','인턴','Y','789-0123','오락', 30000000,'수습');
INSERT INTO TEMP VALUES (20000308,'강월악',TO_DATE('19800925','YYYYMMDD'),'CB0001','인턴','Y','890-1234','골프', 30000000,'수습');
INSERT INTO TEMP VALUES (20000119,'장금강',TO_DATE('19801105','YYYYMMDD'),'CC0001','인턴','Y','901-2345','술',   30000000,'수습');
INSERT INTO TEMP VALUES (20000210,'나한라',TO_DATE('19801215','YYYYMMDD'),'CD0001','인턴','Y','012-3456','독서', 30000000,'수습');
COMMIT;

SELECT * FROM TEMP t ;

CREATE TABLE TCOM (
        WORK_YEAR    VARCHAR2(04) NOT NULL,
        EMP_ID       NUMBER       NOT NULL,
        BONUS_RATE   NUMBER,
        COMM         NUMBER,
        CONSTRAINT COM_PK PRIMARY KEY (WORK_YEAR, EMP_ID)
);
	
SELECT * FROM tcom;

-- SELECT 명령을 이용한 데이터 삽입
INSERT INTO
	TCOM
SELECT '2020', t.EMP_ID, 1, t.SALARY * 0.01
FROM TEMP t WHERE t.DEPT_CODE LIKE 'C%';

SELECT * FROM tcom;
	
-- 직급별 연봉 상하한과 나이으 상하한선이 있는 테이블
CREATE TABLE EMP_LEVEL (
   LEV             VARCHAR2(10) PRIMARY KEY,
      FROM_SAL        NUMBER,
     TO_SAL            NUMBER,
     FROM_AGE        NUMBER,
     TO_AGE           NUMBER
 );
INSERT INTO EMP_LEVEL VALUES ('사원',30000000,40000000,20,25);
INSERT INTO EMP_LEVEL VALUES ('대리',35000000,60000000,23,27);
INSERT INTO EMP_LEVEL VALUES ('과장',37000000,75000000,25,29);
INSERT INTO EMP_LEVEL VALUES ('차장',40000000,80000000,27,31);
INSERT INTO EMP_LEVEL VALUES ('부장',60000000,100000000,29,32);	
	
SELECT * FROM tab;
	
-- union과 union all: 합집합 구하기
SELECT * FROM temp; -- 20개
SELECT * FROM tcom; -- 8개

SELECT EMP_ID FROM temp
UNION
SELECT EMP_ID FROM tcom; -- 20개(중복제거) 정렬
	
SELECT EMP_ID FROM temp
UNION all
SELECT EMP_ID FROM tcom; -- 28개 (중복허용) 비정렬
	
--잘못 사용하는 경우
SELECT EMP_ID, EMP_NAME FROM temp --EMP_NAME은 문자열, BONUS_RATE는 숫자
UNION
SELECT EMP_ID, BONUS_RATE FROM tcom; -- 컬럼 타입이 달라서 에러가 발생
	
SELECT EMP_ID FROM temp
UNION
SELECT EMP_ID, BONUS_RATE FROM tcom; -- 컬럼의 개수가 달라도 에러

SELECT EMP_ID, EMP_NAME, 0 FROM temp -- 이처럼 의미없는 값0과 ' '를 입력하면 나오지만
UNION
SELECT EMP_ID, ' ', BONUS_RATE FROM tcom; --중복되어 나온다 어떻게 중복을 제거할까?

SELECT EMP_ID 사번, SALARY 연봉 FROM temp 
UNION
SELECT EMP_ID 사번, COMM 커미션 FROM tcom; -- 연봉자리에 커미션이 나온다 -> 잘못된 결과가 나온다 어떻게 둘다 나오게 할까?

SELECT EMP_ID 사번, SALARY 연봉, 0 커미션 FROM temp 
UNION
SELECT EMP_ID 사번, 0 연봉, COMM 커미션 FROM tcom; -- 커미션이 있으면 두줄, 없으면 한줄로만 나온다-> 합치려면 조인을 써야 한다
