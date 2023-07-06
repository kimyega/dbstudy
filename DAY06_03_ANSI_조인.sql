/*
    조인
    
    1. 2개 이상의 테이블을 한번에 조회하는 방식이다.
    2. 각 테이블의 관계(1:M)를 이용해서 조인 조건을 만든다.
    3. 조인 종류
        1) 내부 조인 : 2개 테이블에 모두 존재하는 데이터만 조회하는 방식
        2) 외부 조인 : 2개 테이블에 모두 존재하지 않더라도 조회하는 방식
        
        회원          구매
        1   A       1   A   새우깡
        2   B       2   A   맛동산
        3   C       3   B   새우깡
        
        구매내역을 뽑아보자(내부 조인)
        A   새우깡
        A   맛동산
        B   새우깡
        
        구매내역이 없는 사람도 포함해서 구매내역을 뽑아보자(외부 조인)
        A   새우깡
        A   맛동산
        B   새우깡
        C   NULL

        드라이브 테이블 VS 드리븐 테이블
        
        1. 드라이브 테이블
            1) 조인 관계를 처리하는 메인 테이블
            2) 1:M 관계에서 1에 해당하는 테이블
            3) 일반적으로 데이터의 갯수가 적다.
            4) PK를 조인 조건으로 사용하기 때문에 인덱스(INDEX) 사용이 가능하다.(빠르다는 의미)
            
        2. 드리븐 테이블
            1) 1:M 관계에서 M에 해당하는 테이블
            2) 일반적으로 데이터의 갯수가 많다.
            3) FK를 조인 조건으로 사용하기 때문에 인덱스(INDEX) 사용이 불가능하다.(느리다는 의미)
        
        3. 드라이브 테이블을 드리븐 테이블보다 먼저 작성하면 성능에 도움이 된다.
*/

-- 내부조인

-- 1. 사원번호, 사원명, 부서번호, 부서명을 조회하시오.
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_ID,                         -- 여기도 반드시 명시 
       D.DEPARTMENT_NAME
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E     -- 같은 이름존재할때 반드시 명시, 1:M관계에서 순서도 1 INNER JOIN M 으로 하는 편이 좋다.
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 2. 사원번호, 사원명, 직업, 직업별 최대연봉, 직업별 최소연봉을 조회하시오.
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME,
       J.JOB_ID,
       SALARY,
       MAX_SALARY,
       MIN_SALARY
  FROM JOBS J INNER JOIN EMPLOYEES E
    ON J.JOB_ID = E.JOB_ID
 ORDER BY E.EMPLOYEE_ID;

-- 외부 조인
-- 3,4. 모든 사원들의 사원번호, 사원명, 부서번호, 부서명을 조회하시오.

SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_ID,                         
       D.DEPARTMENT_NAME
  FROM DEPARTMENTS D RIGHT OUTER JOIN EMPLOYEES E     -- 오른쪽 테이블의 모든(부서번호 NULL 포함) 데이터를 조회하시오. 방향이 바뀔경우 유령부서까지도 조회 = 결과가 바뀐다.
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 ORDER BY D.DEPARTMENT_ID;

-- 3개 이상 테이블 조인하기

-- 5. 사원번호, 사원명, 부서번호, 부서명, 근무지역을 조회하시오.
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       L.LOCATION_ID,
       L.CITY
  FROM LOCATIONS L INNER JOIN DEPARTMENTS D
    ON L.LOCATION_ID = D.LOCATION_ID INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 6. 부서번호, 부서이름, 근무 도시, 근무 국가를 조회하시오.
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       L.CITY,
       C.COUNTRY_NAME
  FROM COUNTRIES C INNER JOIN LOCATIONS L
    ON C.COUNTRY_ID = L.COUNTRY_ID INNER JOIN DEPARTMENTS D
    ON L.LOCATION_ID = D.LOCATION_ID;







