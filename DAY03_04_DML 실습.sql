DROP TABLE ENROLL_TBL;
DROP TABLE LECTURE_TBL;
DROP TABLE STUDENT_TBL;
DROP TABLE COURSE_TBL;
DROP TABLE PROFESSOR_TBL;

CREATE TABLE PROFESSOR_TBL(
    PRO_NO              VARCHAR2(5 BYTE)        NOT NULL,
    PRO_NAME            VARCHAR2(30 BYTE)       NULL,
    PRO_MAJOR           VARCHAR2(30 BYTE)       NULL,
    CONSTRAINT PRO_PK       PRIMARY KEY(PRO_NO)
);
CREATE TABLE COURSE_TBL(
    COU_NO              VARCHAR2(5 BYTE)        NOT NULL,
    COU_SBJNAME         VARCHAR2(30 BYTE)       NULL,
    COU_SCORE           NUMBER  (3,1)           NULL,
    CONSTRAINT COU_PK        PRIMARY KEY(COU_NO)
);
CREATE TABLE STUDENT_TBL(
    STU_NO              VARCHAR2(5 BYTE)        NOT NULL,
    STU_NAME            VARCHAR2(20 BYTE)       NULL,
    STU_ADDRESS         VARCHAR2(100 BYTE)      NULL,
    STU_GRADE           NUMBER  (1)             NULL,
    PRO_NO              VARCHAR2(20 BYTE)       NOT NULL,
    CONSTRAINT STU_PK       PRIMARY KEY(STU_NO),
    CONSTRAINT PRO_STU_FK   FOREIGN KEY(PRO_NO) REFERENCES PROFESSOR_TBL(PRO_NO)
    ON DELETE CASCADE
);

CREATE TABLE LECTURE_TBL(
    LEC_NO              NUMBER                  NOT NULL,
    PRO_NO              VARCHAR2(5 BYTE)        NULL,
    COU_NO              VARCHAR2(5 BYTE)        NULL,
    LEC_NAME            VARCHAR2(100 BYTE)      NULL,
    LEC_LOCA            VARCHAR2(100 BYTE)      NULL,
    CONSTRAINT LEC_PK        PRIMARY KEY(LEC_NO),
    CONSTRAINT PRO_LEC_FK    FOREIGN KEY(PRO_NO) REFERENCES PROFESSOR_TBL(PRO_NO)
    ON DELETE SET NULL,
    CONSTRAINT COU_LEC_FK    FOREIGN KEY(COU_NO) REFERENCES COURSE_TBL(COU_NO)
    ON DELETE SET NULL
);
CREATE TABLE ENROLL_TBL(
    ENR_NO              NUMBER                  NOT NULL,
    STU_NO              VARCHAR2(20 BYTE)       NOT NULL,
    LEC_NO              NUMBER                  NOT NULL,
    ENR_DATE            DATE                    NULL,
    CONSTRAINT ENR_PK        PRIMARY KEY(ENR_NO),
    CONSTRAINT STU_ENR_FK    FOREIGN KEY(STU_NO) REFERENCES STUDENT_TBL(STU_NO)
    ON DELETE CASCADE,
    CONSTRAINT LEC_ENR_FK    FOREIGN KEY(LEC_NO) REFERENCES LECTURE_TBL(LEC_NO)
    ON DELETE CASCADE
);

INSERT INTO PROFESSOR_TBL(PRO_NO, PRO_NAME, PRO_MAJOR) VALUES('12523', '이재운', '물리');
INSERT INTO PROFESSOR_TBL(PRO_NO, PRO_NAME, PRO_MAJOR) VALUES('33123', '김학수', '언어');
INSERT INTO PROFESSOR_TBL(PRO_NO, PRO_NAME, PRO_MAJOR) VALUES('12213', '오군명', '사회');

INSERT INTO COURSE_TBL(COU_NO, COU_SBJNAME, COU_SCORE) VALUES('79625', '사회 과학', 4.5);
INSERT INTO COURSE_TBL(COU_NO, COU_SBJNAME, COU_SCORE) VALUES('21784', '물리', 3.5);
INSERT INTO COURSE_TBL(COU_NO, COU_SBJNAME, COU_SCORE) VALUES('27933', '디지털 언어', 5);

INSERT INTO STUDENT_TBL(STU_NO, STU_NAME, STU_ADDRESS, STU_GRADE, PRO_NO) VALUES('21042', '이학렬', '경기도 광명시', 1, '33123');
INSERT INTO STUDENT_TBL(STU_NO, STU_NAME, STU_ADDRESS, STU_GRADE, PRO_NO) VALUES('21050', '김성태', '서울 잠실', 2, '12523');
INSERT INTO STUDENT_TBL(STU_NO, STU_NAME, STU_ADDRESS, STU_GRADE, PRO_NO) VALUES('21060', '우사기', '서울 대치동', 3, '33123');
INSERT INTO STUDENT_TBL(STU_NO, STU_NAME, STU_ADDRESS, STU_GRADE, PRO_NO) VALUES('21010', '김진효', '경기도 인천시', 3, '33123');
INSERT INTO STUDENT_TBL(STU_NO, STU_NAME, STU_ADDRESS, STU_GRADE, PRO_NO) VALUES('21080', '소이해', '서울 강남', 1, '12213');
INSERT INTO STUDENT_TBL(STU_NO, STU_NAME, STU_ADDRESS, STU_GRADE, PRO_NO) VALUES('21090', '강지혜', '독도', 2, '12213');

DROP SEQUENCE LEC_SEQ;
CREATE SEQUENCE LEC_SEQ NOORDER;

INSERT INTO LECTURE_TBL(LEC_NO, PRO_NO, COU_NO, LEC_NAME, LEC_LOCA) VALUES(LEC_SEQ.NEXTVAL, '33123', '27933', '언어의 역사와 미래', 'A관 3층 B강의실');
INSERT INTO LECTURE_TBL(LEC_NO, PRO_NO, COU_NO, LEC_NAME, LEC_LOCA) VALUES(LEC_SEQ.NEXTVAL, '12213', '21784', '돈과 사회', 'B관 2층 대강의실');
INSERT INTO LECTURE_TBL(LEC_NO, PRO_NO, COU_NO, LEC_NAME, LEC_LOCA) VALUES(LEC_SEQ.NEXTVAL, '12523', '79625', '3차 산업과 물리세상', 'A관 1층 C강의실');

DROP SEQUENCE ENR_SEQ;
CREATE SEQUENCE ENR_SEQ NOORDER;

INSERT INTO ENROLL_TBL(ENR_NO, STU_NO, LEC_NO, ENR_DATE) VALUES(ENR_SEQ.NEXTVAL,'21060', 1,'23-05-20');
INSERT INTO ENROLL_TBL(ENR_NO, STU_NO, LEC_NO, ENR_DATE) VALUES(ENR_SEQ.NEXTVAL,'21050', 3,'23-06-01');
INSERT INTO ENROLL_TBL(ENR_NO, STU_NO, LEC_NO, ENR_DATE) VALUES(ENR_SEQ.NEXTVAL,'21042', 2,'23-05-29');

COMMIT;
-- 오라클은 칼럼이름 모두 넣을 경우 생략 가능하다. 하지만 안하는게 좋다.







