/*
    서브쿼리(sub query)
    1. 메인쿼리에 포함되는 하위 쿼리를 서브쿼리라고 한다.
    2. 서브쿼리를 먼저 실행해서 그 결과를 메인쿼리에 전달한다.
    3. 종류
        1) SELECT 절 : 스칼라 서브쿼리
        2) FROM   절 : 인라인 뷰 (INLINE VIEW) 뷰 : 가상테이블,쿼리문
        3) WHERE  절 : 단일 행 서브쿼리 (결과가 1개) 
                       다중 행 서브쿼리 (결과가 N개)
*/
/*
    단일 행 서브쿼리 (single row sub query)
    1. 결과가 1행이다. (1개)
    2. 단일 행 서브쿼리인 경우
        1) WHERE 절에서 사용한 칼럼이 PK 또는 UNIQUE 칼럼인 경우
        2) 통계 함수를 사용한 경우 ex) SELECT COUNT(*) FROM EMPLOYEES
    3. 단일 행 서브쿼리 연산자
        =, !=, >, >=, <, <=
    
    다중 행 서브쿼리(multi row sub query)
    1. 결과가 N행이다.
    2. 다중 행 서브쿼리 연산자
        IN, ANY, ALL 등
*/

/* WHERE 절의 서브쿼리*/

-- 1. 사원번호가 101인 사원의 직업과 동일한 직업을 가진 사원을 조회하기
--SELECT *
--  FROM EMPLOYEES
-- WHERE JOB_ID = (사원번호가 101인 사원의 직업)
-- 사원번호가 101인 사원의 직업
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID =  (SELECT JOB_ID 
                    FROM EMPLOYEES 
                   WHERE EMPLOYEE_ID = 101);    --  PK이므로 단일 행 서브쿼리 연산자 '=' 사용

SELECT * 
  FROM EMPLOYEES 
 WHERE DEPARTMENT_ID IN(50,60);

-- 부서명이 'IT' 인 부서에 근무하는 사원조회하기
--SELECT *
--  FROM EMPLOYEES
-- WHERE DEPARTMENT_ID = (부서명이 'IT'인 부서의 부서번호)
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (
                        SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT'   -- 서브쿼리의 DEPARTMENT_NAME 칼럼은 중복이 있을 수 있으므로 다중행 서브쿼리로 처리한다.
                        );
 -- 3. 'Seattle' 에서 근무하는 사원 조회
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE LOCATION_ID IN (SELECT LOCATION_ID 
                                                FROM LOCATIONS
                                               WHERE CITY = 'Seattle'));
SELECT *
  FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
   AND D.LOCATION_ID = L.LOCATION_ID
   AND L.CITY = 'Seattle';

-- 4. 연봉 가장 높은 사원 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEES);
-- 5. 가장 먼저 입사한 사원 조회하기
SELECT *
 FROM EMPLOYEES
 WHERE HIRE_DATE = (SELECT MIN(HIRE_DATE)
                      FROM EMPLOYEES);

-- 6. 평균 연봉 이상을 받는 사원 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE SALARY >= (SELECT AVG(SALARY)
                   FROM EMPLOYEES);

/* FROM 절의 서브쿼리 (선 정렬 목적)*/

-- 1. 연봉이 3번째로 높은 사원 조회하기
--      1) 높은 연봉 순으로 정렬한다.
--      2) 정렬 결과에 행 번호를 붙인다.
--      3) 행 번호 3을 가져온다.
SELECT 행번호, EMPLOYEE_ID
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS 행번호, EMPLOYEE_ID
          FROM EMPLOYEES)
 WHERE 행번호 = 3;

-- 2. 연봉 11 ~ 20 번째 사원 조회
SELECT 연봉순위,
       EMPLOYEE_ID,
       SALARY,
       FIRST_NAME,
       LAST_NAME
  FROM (SELECT RANK() OVER(ORDER BY SALARY DESC) AS 연봉순위,
               EMPLOYEE_ID,
               SALARY,
               FIRST_NAME,
               LAST_NAME
          FROM EMPLOYEES)
 WHERE 연봉순위 BETWEEN 11 AND 20;

-- 3. 21 ~ 30 번째로 입사한 사원 조회
SELECT EMPLOYEE_ID AS 직원ID,
       HIRE_DATE   AS 입사날짜 
  FROM (SELECT RANK() OVER(ORDER BY HIRE_DATE ASC) AS 입사순,
               EMPLOYEE_ID,
               HIRE_DATE
          FROM EMPLOYEES)
 WHERE 입사순 BETWEEN 21 AND 30;
