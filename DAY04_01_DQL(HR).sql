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
-- 9. 사원테이블에서 전화번호가 '515'로 시작하는 사원의 정보 조회하기
SELECT * 
  FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE '515' || '%'; -- 와일드카드는 등호문자 사용 X LIKE 사용
-- || 합치기를 사용해 더 유연하게 만들어준다.
-- 10. 사원테이블에서 전화번호가 '515'로 시작하는 전화번호를 조회하시오. 중복제거.
SELECT DISTINCT PHONE_NUMBER
  FROM EMPLOYEES
WHERE PHONE_NUMBER LIKE '515' || '%';

-- 11. 사원테이블의 사원들을 연봉순으로 조회하기 높은 연봉을 먼저 조회
SELECT *
  FROM EMPLOYEES
 ORDER BY SALARY; -- ORDER BY 기본값은 오름차순 ASC: Ascending
SELECT *
  FROM EMPLOYEES
 ORDER BY SALARY DESC; -- 내림차순 DESC : Descending
-- 12. 사원테이블의 사원들을 입사순으로 조회하시오 먼저 입사한 사원을 먼저 조회
SELECT *
  FROM EMPLOYEES
 ORDER BY HIRE_DATE;
-- 13. 사원테이블의 사원들을 부서별로 비교할 수 있도록 
-- 같은 부서의 사원들을 모아서 조회한 뒤 같은 부서 내의 사원들은 연봉순으로 조회하기
-- ,는 묶음이 아니라 끊어서 해석
SELECT *
  FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID,
SALARY DESC;
