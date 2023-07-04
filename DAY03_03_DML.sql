/*
    DML
    1. DATA MANIPULATION LANGUAGE
    2. 데이터(행,ROW)를 조작 (삽입, 수정, 삭제)하는 언어이다.
    3. 트랜잭션대상이다.(작업이 완료되면 COMMIT, 작업을 취소하려면 ROLLBACK이 필요하다.)
        1) COMMIT   : 작업을 저장한다. COMMIT이 완료된 작업은 ROLLBACK으로 취소할 수 없다.
        2) ROLLBACK : 작업을 취소한다. COMMIT 이후 작업을 취소한다.
    4. 종류
        1) 삽입 : INSERT INTO VALUES
        2) 수정 : UPDATE SET WHERE
        3) 삭제 : DELETE FROM WHERE
*/
-- 참고
-- 자격증에서는 DML의 범주를 INSERT, UPDATE, DELETE + SELECT로 보기도 한다.



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

-- 날짜는 - 또는 / 로 구분한다.
COMMIT;

ROLLBACK; -- COMMIT 이후의 작업 취소 COMMIT 취소 X

--수정
/*
    UPDATE 테이블
    SET 업데이트할 내용, 업데이트할 내용
    WHERE 조건식 
*/
-- 1. 부서번호가 3인 부서의 지역을 '인천'으로 변경하시오.
UPDATE DEPARTMENT_TBL
   SET LOCATION = '인천'        -- SET 절의 등호(=)는 대입연산자
 WHERE DEPT_NO = 3;         -- WHERE 절의 등호(=)는 동등비교연산자

ROLLBACK;
-- 2. 부서번호가 2인 부서에 근무하는 모든 사원들의 연봉을 500000 증가시키오.
UPDATE EMPLOYEEL_TBL
   SET SALARY = SALARY + 500000
 WHERE DEPART = 2;

-- 삭제

/*
    DELETE
      FROM 테이블
     WHERE
*/
-- 1. 지역이 '인천'인 부서를 삭제하시오. 근무 사원 없음
DELETE
  FROM DEPARTMENT_TBL
 WHERE LOCATION = '인천';
-- 2. 지역이 '서울'인 부서를 삭제하시오. 근무 사원 있음 ON DELETE SET NULL 옵션에 의해서 부서정보가 NULL 값으로 처리된다.
DELETE
  FROM DEPARTMENT_TBL
 WHERE LOCATION = '서울';

