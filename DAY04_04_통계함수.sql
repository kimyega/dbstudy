/*
    통계함수
    1. SUM(표현식)   : 합계
    2. AVG(표현식)   : 평균
    3. MAX(표현식)   : 최댓값
    4. MIN(표현식)   : 최솟값
    5. COUNT(표현식) : 갯수
*/

-- 1. 사원 테이블에서 전체 사원의 연봉합계 조회
SELECT SUM(SALARY) AS 연봉합계
  FROM EMPLOYEES;

-- 2. 사원 테이블에서 전체 사원의 커미션퍼센트의 평균 조회
-- 커미션이 없는 사원은 제외하고 조회하기
SELECT AVG(COMMISSION_PCT) AS 커미션퍼센트평균
  FROM EMPLOYEES; -- AVG함수는 자체적으로 NULL 값은 이미 제외된 상태

-- 3. 사원 테이블에서 전체 사원중 최대연봉을 조회
SELECT MAX(SALARY) AS 최대연봉
  FROM EMPLOYEES;
-- 4. 사원 테이블에서 전체사원의 최대 커미션 조회하기
-- 커미션 = 연봉 * 커미션퍼센트
SELECT MAX(SALARY * COMMISSION_PCT) AS 최대커미션
  FROM EMPLOYEES;
-- 5. 사원 테이블에서 전체 사원중 가장 나중에 입사한 사원의 입사일 조회하기
SELECT MAX(HIRE_DATE) AS 최근입사일
  FROM EMPLOYEES;
-- 날짜도 기본적으로 숫자 연산 가능. 클수록 최근 날짜

-- 6. 전체 사원 수 조회하기
-- 1) NOT NULL이 확실한 칼럼(PK)으로 갯수를 구한다.
SELECT COUNT(EMPLOYEE_ID) AS 전체사원수
  FROM EMPLOYEES;
-- 2) 모든 칼럼으로 갯수를 구한다.
SELECT COUNT(*) AS 전체사원수
  FROM EMPLOYEES;

-- 7. 사원들이 근무하는 부서의 갯수 조회하기
SELECT COUNT(DISTINCT DEPARTMENT_ID) AS 부서수
  FROM EMPLOYEES;
