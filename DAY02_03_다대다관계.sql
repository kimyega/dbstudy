/*
    M:N 관계
    1. 현실세계에서 빈번히 나타나지만 주의해야하는 관계이다.
    2. M:N 관계를 가진 두개의 테이블은 직접관계를 맺는것이 불가능하다.
    3. 관계를 맺기 위해서 별도의 테이블이 추가로 필요하다.
    4, M:N 관계는 1:M 관계 2개로 구현할 수 있다.
*/

--노래마다 해시태그 달기
--노래 - 노래,해시태그 - 해시태그
--A      A    NEW          NEW
--B      A    HOT          HOT
DROP TABLE ENROLL_T;
DROP TABLE STUDENT_T;
DROP TABLE UNIV_SUBJECT_T;

CREATE TABLE UNIV_STUDENT_T(
    STU_NO      NUMBER           NOT NULL,
    STU_NAME    CHAR(10 BYTE)    NOT NULL,
    STU_AGE     NUMBER           NOT NULL,
    CONSTRAINT PK_US  PRIMARY KEY(STU_NO)
);

CREATE TABLE SUBJECT_T(
    SUB_CODE        VARCHAR2(5 BYTE)     NOT NULL,        
    SUB_NAME        VARCHAR2(10 BYTE)    NOT NULL,    
    SUB_PROFES      VARCHAR2(10 BYTE)    NOT NULL,
    CONSTRAINT PK_SUB  PRIMARY KEY(SUB_CODE)
);


CREATE TABLE ENROLL_T(
    ENR_NO      NUMBER          NOT NULL,
    STU_NO      NUMBER,
    SUB_CODE    VARCHAR2(5 BYTE),
    CONSTRAINT PK_ENR  PRIMARY KEY(ENR_NO),
    CONSTRAINT FK_STU_EN FOREIGN KEY(STU_NO) REFERENCES UNIV_STUDENT_T(STU_NO),
    CONSTRAINT FK_SUB_EN FOREIGN KEY(SUB_CODE) REFERENCES SUBJECT_T(SUB_CODE)
);

