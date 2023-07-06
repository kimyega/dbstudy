-- 내부조인

-- 1. 사원번호, 사원명, 부서번호, 부서명을 조회하시오.
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_ID,                         -- 여기도 반드시 명시 
       D.DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E               -- INNER JOIN 대신 콤마 사용
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID;       -- ON 대신 WHERE을 사용한다.

-- 2. 사원번호, 사원명, 직업, 직업별 최대연봉, 직업별 최소연봉을 조회하시오.
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME,
       J.JOB_ID,
       E.SALARY,
       J.MAX_SALARY,
       J.MIN_SALARY
  FROM JOBS J, EMPLOYEES E
 WHERE J.JOB_ID = E.JOB_ID
 ORDER BY E.EMPLOYEE_ID;

-- 외부 조인
-- 3,4. 모든 사원들의 사원번호, 사원명, 부서번호, 부서명을 조회하시오.

SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_ID,                         
       D.DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E     -- 오른쪽 테이블의 모든(부서번호 NULL 포함) 데이터를 조회하시오. 방향이 바뀔경우 유령부서까지도 조회 = 결과가 바뀐다.
 WHERE D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID -- RIGHT OUTER JOIN은 반대방향(LEFT)에 (+) 를 추가한다.
 ORDER BY D.DEPARTMENT_ID;

-- 3개 이상 테이블 조인하기

-- 5. 사원번호, 사원명, 부서번호, 부서명, 근무지역을 조회하시오.
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       L.LOCATION_ID,
       L.CITY
  FROM LOCATIONS L, DEPARTMENTS D, EMPLOYEES E
 WHERE L.LOCATION_ID = D.LOCATION_ID
   AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 6. 부서번호, 부서이름, 근무 도시, 근무 국가를 조회하시오.
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       L.CITY,
       C.COUNTRY_NAME
  FROM COUNTRIES C, LOCATIONS L, DEPARTMENTS D
 WHERE C.COUNTRY_ID = L.COUNTRY_ID
   AND L.LOCATION_ID = D.LOCATION_ID;