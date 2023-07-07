DROP TABLE EMPLOYEEL_TBL;
DROP TABLE DEPARTMENT_TBL;


CREATE TABLE DEPARTMENT_TBL(
    DEPT_NO             NUMBER              NOT NULL,
    DEPT_NAME           VARCHAR2(15 BYTE)   NOT NULL,
    LOCATION            VARCHAR2(15 BYTE)   NOT NULL,
    CONSTRAINT DPT_PK         PRIMARY KEY(DEPT_NO)
);
CREATE TABLE EMPLOYEEL_TBL(
    EMP_NO              NUMBER              NOT NULL,
    NAME                VARCHAR2(20 BYTE)   NOT NULL,
    DEPART              NUMBER              NULL,
    POSITION            VARCHAR2(20 BYTE)   NULL,
    GENDER              CHAR    (2 BYTE)    NULL,
    HIRE_DATE           DATE                NULL,
    SALARY              NUMBER              NULL,
    CONSTRAINT  EMP_PK       PRIMARY KEY(EMP_NO),
    CONSTRAINT  DPT_EMP_FK   FOREIGN KEY(DEPART)    REFERENCES  DEPARTMENT_TBL(DEPT_NO) 
    ON DELETE SET NULL
);

-- 부서번호를 생성하는 시퀀스 만들기  (기본값)
/*
DROP SEQUENCE DPT_SEQ;
CREATE SEQUENCE DPT_SEQ
    INCREMENT BY 1  -- 1 씩 증가하는 번호 만들기 
    START WITH 1    -- 1 부터 번호를 만든다.
    NOMAXVALUE      -- 번호의 상한선이 없다.
    NOMINVALUE      -- 번호의 하한선이 없다.
    NOCYCLE         -- 번호의 순환이 없다.
    CACHE 20        -- 20개씩 번호를 미리 만들어 둔다.
    NOORDER         -- 번호를 순서대로 사용하지 않는다. - 번호를 순서대로 사용하는 ORDER 옵션으로 바꿔서 시퀀스를 생성한다.
;
*/
-- 
DROP SEQUENCE DPT1_SEQ;
CREATE SEQUENCE DPT1_SEQ ORDER;

INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DPT1_SEQ.NEXTVAL, '영업부', '대구');
INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DPT1_SEQ.NEXTVAL, '인사부', '서울');
INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DPT1_SEQ.NEXTVAL, '총무부', '대구');
INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DPT1_SEQ.NEXTVAL, '기획부', '서울');

DROP SEQUENCE EMP_SEQ;
CREATE SEQUENCE EMP_SEQ 
START WITH 1001
ORDER;

INSERT INTO EMPLOYEEL_TBL(EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY)
VALUES(EMP_SEQ.NEXTVAL, '구창민', 1, '과장', 'M', '95-05-01', 5000000);

INSERT INTO EMPLOYEEL_TBL(EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY)
VALUES(EMP_SEQ.NEXTVAL, '김민서', 1, '사원', 'M', '17-09-01', 2500000);

INSERT INTO EMPLOYEEL_TBL(EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY)
VALUES(EMP_SEQ.NEXTVAL, '이은영', 2, '부장', 'F', '90-09-01', 5500000);

INSERT INTO EMPLOYEEL_TBL(EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY)
VALUES(EMP_SEQ.NEXTVAL, '한성일', 2, '과장', 'M', '93-04-01', 5000000);

COMMIT;

-- 1. 사원번호가 1001인 사원과 동일한 직급(POSITION)을 가진 사원을 조회하시오.
SELECT *
  FROM EMPLOYEEL_TBL
 WHERE POSITION = (SELECT POSITION
                     FROM EMPLOYEEL_TBL
                    WHERE EMP_NO = 1001);

-- 2. 부서번호가 2인 부서와 동일한 지역에 있는 부서를 조회하시오.
SELECT *
  FROM DEPARTMENT_TBL
 WHERE LOCATION = (SELECT LOCATION
                     FROM DEPARTMENT_TBL
                    WHERE DEPT_NO = 2);

-- 3. 가장 높은 급여를 받는 사원을 조회하시오.
SELECT *
  FROM EMPLOYEEL_TBL
 WHERE SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEEL_TBL);

-- 4. 평균 급여 이하를 받는 사원을 조회하시오.
SELECT *
  FROM EMPLOYEEL_TBL
 WHERE SALARY <= (SELECT AVG(SALARY)
                    FROM EMPLOYEEL_TBL);

-- 5. 평균 근속 개월 수 이상을 근무한 사원을 조회하시오.
SELECT EMP_NO, NAME, DEPART, GENDER, POSITION, HIRE_DATE, SALARY
  FROM EMPLOYEEL_TBL
 WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= (SELECT AVG(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))
                                               FROM EMPLOYEEL_TBL);



-- 6. 부서번호가 2인 부서에 근무하는 사원들의 직급과 일치하는 사원을 조회하시오.
SELECT *
  FROM EMPLOYEEL_TBL
 WHERE POSITION IN (SELECT POSITION
                      FROM EMPLOYEEL_TBL
                     WHERE DEPART = 2);

-- 7. 부서명이 '영업부'인 부서에 근무하는 사원을 조회하시오.
SELECT *
  FROM EMPLOYEEL_TBL
 WHERE DEPART IN (SELECT DEPT_NO
                    FROM DEPARTMENT_TBL
                   WHERE DEPT_NAME = '영업부');

-- 8. 직급이 '과장'인 사원들이 근무하는 부서 정보를 조회하시오.
SELECT *
  FROM DEPARTMENT_TBL
 WHERE DEPT_NO IN (SELECT DEPART
                     FROM EMPLOYEEL_TBL
                    WHERE POSITION = '과장');
  

-- 9. '영업부'에서 가장 높은 급여를 받는 사람보다 더 높은 급여를 받는 사원을 조회하시오.
SELECT *
  FROM EMPLOYEEL_TBL
 WHERE SALARY > (SELECT MAX(SALARY)
                   FROM EMPLOYEEL_TBL
                   WHERE DEPART IN (SELECT DEPT_NO
                                      FROM DEPARTMENT_TBL
                                     WHERE DEPT_NAME = '영업부'))


-- 10. 3 ~ 4번째로 입사한 사원을 조회하시오.

SELECT 입사순,
       EMP_NO, 
       DEPART, 
       GENDER, 
       POSITION, 
       HIRE_DATE, 
       SALARY,
       NAME
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY HIRE_DATE ASC) AS 입사순,
               EMP_NO, 
               NAME, 
               DEPART, 
               GENDER, 
               POSITION, 
               HIRE_DATE, 
               SALARY
          FROM EMPLOYEEL_TBL)
 WHERE 입사순 BETWEEN 3 AND 4;
 



