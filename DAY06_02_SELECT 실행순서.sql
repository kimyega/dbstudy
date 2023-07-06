/*
    SELECT 문의 실행순서
    SELECT 칼럼       5
      FROM 칼럼       1
     WHERE 테이블     2
     GROUP BY 그룹    3
    HAVING 그룹조건   4
     ORDER BY 정렬    6
*/

-- 사원 테이블에서 부서별 연봉 평균과 사원수를 조회하시오. 부서별 사원수가 2명 이상인 부서만 조회하시오.
SELECT E.DEPARTMENT_ID          AS 부서_ID,
       ROUND(AVG(SALARY), 2)    AS 연봉_평균,
       COUNT(*)                 AS 부서별_사원수
  FROM EMPLOYEES E
 GROUP BY E.DEPARTMENT_ID       -- 실행순서로 인해 부서_ID 로 대체하지 못한다.
HAVING COUNT(*) >= 2 
 ORDER BY 부서_ID;









