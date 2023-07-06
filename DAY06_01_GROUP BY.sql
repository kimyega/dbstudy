/*
    GROUP BY 절
    1. 같은 값을 가진 대아터들을 하나의 그룹으로 묶어서 처리한다.
    2. 통계를 내는 목적으로 사용한다. (합계, 평균, 최댓값, 최솟값, 갯수등)
    3. SELECT 절에서 조회하려는 칼럼은 "반드시" GROUP BY 절에 명시되어 있어야 한다.
*/
-- 1. 사원테이블에서 동일한 부서번호를 가진 사원들을 그룹화하여 각 그룹별로 몇명의 사원이 있는지 조회하시오.
SELECT DEPARTMENT_ID,       -- GRUOP BY 절에서 지정한 칼럼만 조회가능하다.
       COUNT(*)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY DEPARTMENT_ID;

-- 2. 사원 테이블에서 같은 직업을 가지 사원들을 그룹화하여 각 그룹별로 연봉의 평균이 얼마인지 조회하시오

SELECT JOB_ID,
       ROUND(AVG(SALARY))
  FROM EMPLOYEES
 GROUP BY JOB_ID
 ORDER BY ROUND(AVG(SALARY));


-- 3. 사원 테이블에서 전화번호 앞 3자리가 같은 사원들을 그룹화하여 각 그룹별로 연봉의 합계가 얼마인지 조회하시오.

SELECT SUBSTR(PHONE_NUMBER, 1, 3),
       SUM(SALARY)
  FROM EMPLOYEES
 GROUP BY SUBSTR(PHONE_NUMBER, 1, 3)
 ORDER BY SUBSTR(PHONE_NUMBER, 1, 3);

/*
    참고. GROUP BY 절 없이 통계내기
*/
SELECT DISTINCT DEPARTMENT_ID AS 부서_ID,
       COUNT(*)           OVER(PARTITION BY DEPARTMENT_ID) AS 부서_ID_개수,
       ROUND(AVG(SALARY)  OVER(PARTITION BY DEPARTMENT_ID), 2) AS 연봉_평균
  FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID;

/*
    HAVING 절
    1. GROUP BY 절 이후에 나타난다.
    2. GROUP BY 절을 이용한 조회 결과에 조건을 지정하는 경우에 사용된다.
    3. GROUP BY 절이 필요하지 않는 조건은 WHERE 절로 지정한다.
*/

-- 4. 사원 테이블에서 각 부서별 사원수가 20명 이상인 부서를 조회하시오.
-- 조건 : 부서별 사원수 >=20
-- 조건에서 사용되는 부서별 사원수는 GROUP BY 절이 필요하므로 HAVING으로 처리한다.
SELECT DEPARTMENT_ID,
       COUNT(*)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 20;

-- 5. 사원테이블에서 각 부서별 사원수를 조회하시오. 단 부서번호가 없는 사원은 제외하시오.
-- 조건 : 부서번호 IS NOT NULL
-- 조건에서 사용되는 부서번호는 GROUP BY 절이 필요없으므로 WHERE 절로 처리한다.
SELECT DEPARTMENT_ID, 
       COUNT(*)
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IS NOT NULL            -- GROUP BY와 상관없는 조건은 HAVING 절을 굳이 쓸 필요가 없다. 이때는 WHERE절 사용.WHERE 절로 미리 제거해 성능차이가 나기 때문.
 GROUP BY DEPARTMENT_ID;                    -- HAVING은 그룹하기전 미리 빼두는데 이때 빼두는 그룹화 하는 양(모수)가 WHERE절로 미리 제거해 놓을 때보다 많아져서 그렇다.


