-- AS ALIAS(별명)의 약자. 
-- FROM 부터 실행, 공백으로 별명 지정
-- 중복제거 DISTINCT 중복제거할 칼럼이름 앞에 적는다.
-- 오라클은 FROM절 필수
-- LIKE 등호대신 사용 검색에 사용 와일드카드와 같이 사용
-- 1. 사원 테이블에서 FIRST_NAME, LAST_NAME 조회하기
SELECT E.FIRST_NAME AS FN, E.LAST_NAME AS LN
  FROM EMPLOYEES E;
-- 2. 사원 테이블에서 DEPARTMENT_ID의 중복을 제거하고 조회하기.
SELECT DISTINCT DEPARTMENT_ID
  FROM EMPLOYEES;
-- 3. 사원 테이블에서 EMPLOYEE_ID가 150인 사원의 정보 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID = 150;
-- 4. 사원 테이블에서 연봉이 10000 이상인 사원의 정보 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE SALARY >= 10000;
-- 5. 사원 테이블에서 연봉이 10000 이상, 20000 이하인 사원의 정보 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE SALARY >= 10000 AND SALARY <= 20000;

SELECT *
  FROM EMPLOYEES
 WHERE SALARY BETWEEN 10000 AND 20000;  -- ㅊㅊ
-- 6. 사원테이블에서 부서번호가 30, 40, 50인 사원의 정보 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN(30, 40, 50);
-- 7. 사원테이블에서 부서번호가 없는 사원의 정보 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IS NULL; -- NULL은 IS 사용 
 -- 8. 사원테이블에서 커미션을 받는 사원의 정보 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NOT NULL;