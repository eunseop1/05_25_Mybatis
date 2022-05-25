-- 테이블 목록 보기
SELECT * FROM tab;

-- || : 문자열 연결 연산자
SELECT 
	e.EMPLOYEE_ID 사번, FIRST_NAME || ' ' || LAST_NAME AS 이름
FROM 
	EMPLOYEES e ;

-- 1. 연봉이 12000 이상되는 직원들의 LAST_NAME 및 연봉을 조회한다.
/*
1. 연봉이 12000 이상되는 직원들의 LAST_NAME 및 연봉을 조회한다.

(결과 예제)

LAST_NAME SALARY
------------------------- ----------
Hartstein 13000
King 24000
Kochhar 17000
De Haan 17000
Russell 14000
Partners 13500
*/
SELECT LAST_NAME, SALARY
FROM EMPLOYEES e
WHERE SALARY >= 12000;


/*
2. 사원번호가 176 인 사람의 LAST_NAME 과 부서 번호를 조회한다.

(결과 예제)

LAST_NAME DEPARTMENT_ID
------------------------- -------------
Taylor 80
*/
SELECT LAST_NAME , DEPARTMENT_ID
FROM EMPLOYEES e
WHERE EMPLOYEE_ID = 176;


/*
3. 연봉이 5000 에서 12000 의 범위 이외인 사람들의 LAST_NAME 및 연봉을 조회힌다.

(결과 예제)

LAST_NAME SALARY
------------------------- ----------
OConnell 2600
Grant 2600
Whalen 4400
Hartstein 13000
King 24000
...
*/
SELECT LAST_NAME , SALARY 
FROM EMPLOYEES e
WHERE SALARY < 5000 OR SALARY > 12000;

SELECT LAST_NAME , SALARY 
FROM EMPLOYEES e
WHERE SALARY NOT BETWEEN 5000 AND 12000;

/*
4. 2007/02/20 일부터 2007/05/01 사이에 고용된 사원들의 LAST_NAME 사번, 고용일자를 조회한다.
- 고용일자 순으로 정렬한다.


(결과 예제)

LAST_NAME JOB_ID HIRE_DATE
------------------------- ---------- ----------
Fleaur SH_CLERK 1998/02/23
Urman FI_ACCOUNT 1998/03/07
Matos ST_CLERK 1998/03/15
Bloom SA_REP 1998/03/23
Taylor SA_REP 1998/03/24
Olsen SA_REP 1998/03/30
Patel ST_CLERK 1998/04/06
Livingston SA_REP 1998/04/23
Walsh SH_CLERK 1998/04/24
*/

SELECT LAST_NAME, JOB_ID, HIRE_DATE||''
FROM EMPLOYEES e
WHERE HIRE_DATE >= '07/02/20' AND HIRE_DATE <= '07/05/01'
ORDER BY HIRE_DATE ASC ;


/*
5. 20 번 및 50 번 부서에서 근무하는 모든 사원들의 LAST_NAME 및 부서 번호를 알파벳순으로 조회한다.


(결과 예제)

LAST_NAME DEPARTMENT_ID
------------------------- -------------
Atkinson 50
Bell 50
Bissot 50
Bull 50
Cabrio 50
Chung 50
...
*/
SELECT LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES e 
WHERE DEPARTMENT_ID IN (20, 50)
ORDER BY LAST_NAME ASC;


/*
6. 20 번 및 50 번 부서에 근무하며, 연봉이 5000 ~ 12,000 사이인 사원들의 LAST_NAME 및 연봉을 조회한다.


(결과 예제)

EMPLOYEES SALARY
------------------------- ----------
Fay 6000
Weiss 8000
Fripp 8200
Kaufling 7900
Vollman 6500
Mourgos 5800
*/
SELECT LAST_NAME AS EMPLOYEES, SALARY
FROM EMPLOYEES e 
WHERE DEPARTMENT_ID In (20, 50) AND SALARY BETWEEN 5000 AND 12000;


/*
7. 2004년도에 고용된 모든 사람들의 LAST_NAME 및 고용일을 조회한다.

(결과 예제)

LAST_NAME HIRE_DATE
------------------------- ----------
Mavris 1994/06/07
Baer 1994/06/07
Higgins 1994/06/07
Gietz 1994/06/07
Greenberg 1994/08/17
Faviet 1994/08/16
Raphaely 1994/12/07
*/
SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES e
WHERE HIRE_DATE >= '04/01/01' AND HIRE_DATE <= '04/12/31';

SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES e
WHERE HIRE_DATE BETWEEN '04/01/01' AND '04/12/31';

SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES e
WHERE SUBSTR(HIRE_DATE, 1, 2) = '04';

--substr(문자열, 시작위치, 길이)
-- 4월에 입사한 직원

SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES e
WHERE SUBSTR(HIRE_DATE, 3, 4) = '/04/';

SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES e
WHERE SUBSTR(HIRE_DATE, 4, 2) = '04';


SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES e
WHERE HIRE_DATE LIKE '%/04/%';

/*
8. 매니저가 없는 사람들의 LAST_NAME 및 JOB_ID 를 조회한다.

(결과 예제)

LAST_NAME JOB_ID
------------------------- ----------
King AD_PRES
*/
SELECT LAST_NAME, JOB_ID
FROM EMPLOYEES e 
WHERE MANAGER_ID IS NULL;

/*
9. 커미션을 버는 모든 사원들의 LAST_ANME, 연봉 및 커미션을 조회한다.
- 연봉 역순, 커미션 역순차로 정렬한다.


(결과 예제)

LAST_NAME SALARY COMMISSION_PCT
------------------------- ---------- --------------
Russell 14000 .4
Partners 13500 .3
Errazuriz 12000 .3
Ozer 11500 .25
Cambrault 11000 .3
...
*/

SELECT LAST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES e 
WHERE COMMISSION_PCT  IS NOT NULL
ORDER BY 2 DESC, 3 DESC;

/*
10. LAST_NAME 의 네번째 글자가 a 인 사원들의 LAST_NAME 을 조회한다.


(결과 예제)

LAST_NAME
-------------------------
Doran
Errazuriz
Fleaur
Kumar
McCain
Pataballa
Sciarra
Sewall
Tuvault
Urman
*/
SELECT LAST_NAME
FROM EMPLOYEES e 
WHERE LAST_NAME LIKE  '___a%'; 

/*
11. LAST_NAME 에 a 및 e 글자가 있는 사원들의 LAST_NAME 을 조회힌다.


(결과 예제)

LAST_NAME
-----------------------
Baer
Bates
Colmenares
Davies
De Haan
Faviet
Fleaur
Gates
Hartstein
Markle
Nayer
Partners
Patel
Philtanker
Raphaely
Sewall
Whalen
*/
SELECT LAST_NAME
FROM EMPLOYEES e 
WHERE LAST_NAME LIKE  '%a%' OR  LAST_NAME LIKE  '%e%';
/*
12. 연봉이 2,500, 3,500, 7000 이 아니며 직업이 SA_REP 이나 ST_CLERK 인 사람들을 조회한다.


(결과 예제)

LAST_NAME JOB_ID SALARY
------------------------- ---------- ----------
Nayer ST_CLERK 3200
Mikkilineni ST_CLERK 2700
Landry ST_CLERK 2400
Markle ST_CLERK 2200
...
*/
SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES e 
WHERE SALARY NOT IN (2500, 3500, 7000) AND JOB_ID IN ('SA_REP', 'ST_CLERK');