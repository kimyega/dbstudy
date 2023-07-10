/*
    뷰
    1. 테이블이나 다른 뷰를 이용해서 만든 가상 테이블이다.
    2. 데이터가 아닌 쿼리문만을 저장하고 있다.
    3. 자주 사용하고 복잡한 쿼리문을 뷰로 만들어 두면 쉽게 호출해서 사용할 수 있다.
*/

-- 뷰 만들기 
DROP VIEW V_EMP;
CREATE VIEW V_EMP AS (
    SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, E.JOB_ID, D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.LOCATION_ID
      FROM DEPARTMENTS D, EMPLOYEES E
     WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
);
-- 뷰 조회하기
SELECT *
  FROM  V_EMP;


-- 뷰를 이용한 조회 연습

-- 1. 사원번호, 사원명, 부서번호, 부서명, 지역번호, 도로명 주소를 조회하시오.
DROP VIEW V_DEPT;
CREATE VIEW V_DEPT AS (
    SELECT V.EMPLOYEE_ID, V.DEPARTMENT_ID, V.DEPARTMENT_NAME, L.LOCATION_ID, L.STREET_ADDRESS
      FROM V_EMP V, LOCATIONS L
     WHERE V.LOCATION_ID = L.LOCATION_ID
);
SELECT *
  FROM V_DEPT;
  
-- 2. 사원번호, 사원명, 직무번호, 직무이름(JOB_TITLE)을 조회하시오.

CREATE VIEW V_JOB AS (
    SELECT V.EMPLOYEE_ID, V.FIRST_NAME, V.LAST_NAME, J.JOB_ID, J.JOB_TITLE
      FROM JOBS J, V_EMP V
     WHERE J.JOB_ID = V.JOB_ID
);
SELECT *
  FROM V_JOB;
