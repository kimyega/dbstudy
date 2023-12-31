DROP TABLE SCHEDULE_TBL;
DROP TABLE PLAYER_TBL;
DROP TABLE EVENT_TBL;
DROP TABLE NATION_TBL;


CREATE TABLE NATION_TBL(
    N_CODE              NUMBER  (3)           NOT NULL,
    N_NAME              VARCHAR2(30 BYTE)     NOT NULL,
    N_PARTI_PERSON      NUMBER                NULL,
    N_PARTI_EVENT       NUMBER                NULL,
    N_PREV_RANK         NUMBER                NULL,
    N_CURR_RANK         NUMBER                NULL,
    CONSTRAINT NAT_PK       PRIMARY KEY(N_CODE)
);
CREATE TABLE EVENT_TBL(
    E_CODE              NUMBER                NOT NULL,
    E_NAME              VARCHAR2(30 BYTE)     NOT NULL,
    E_FIRST_YEAR        NUMBER  (4)           NULL,
    E_INFO              VARCHAR2(100 BYTE)    NULL,
    CONSTRAINT EVE_PK       PRIMARY KEY(E_CODE)
);
CREATE TABLE PLAYER_TBL(
    P_CODE              NUMBER  (3)           NOT NULL,
    P_NAME              VARCHAR2(30 BYTE)     NOT NULL,
    N_CODE              NUMBER  (3)           NOT NULL,
    E_CODE              NUMBER                NOT NULL,
    P_RANK              NUMBER                NULL,
    P_AGE               NUMBER  (3)           NULL,
    CONSTRAINT PLA_PK       PRIMARY KEY(P_CODE),
    CONSTRAINT NAT_PLA_FK   FOREIGN KEY(N_CODE) REFERENCES NATION_TBL(N_CODE) ON DELETE CASCADE,
    CONSTRAINT EVE_PLA_FK   FOREIGN KEY(E_CODE) REFERENCES EVENT_TBL(E_CODE)  ON DELETE CASCADE
);
CREATE TABLE SCHEDULE_TBL(
    S_NO                NUMBER  (3)           NOT NULL,
    N_CODE              NUMBER  (3)           NULL,
    E_CODE              NUMBER                NULL,
    S_START_DATE        DATE                  NULL,
    S_END_DATE          DATE                  NULL,
    S_INFO              VARCHAR2(100 BYTE)    NULL,
    CONSTRAINT SCH_PK       PRIMARY KEY(S_NO),
    CONSTRAINT NAT_SCH_FK   FOREIGN KEY(N_CODE) REFERENCES NATION_TBL(N_CODE) ON DELETE SET NULL,
    CONSTRAINT EVE_SCH_FK   FOREIGN KEY(E_CODE) REFERENCES EVENT_TBL(E_CODE)  ON DELETE SET NULL
);
--MODEL 보는 법
--P = PK
--F = FK 
--빨간 점 = NOT NULL 
--열쇠 = PK
--열쇠 화살표 = FK
--삼발이 X = CASCADE
--삼발이 O = SET NULL
--점선 = FK NULL
--실선 = FK NOT NULL

-- 국가 테이블의 기본키 삭제하기
-- 국가 테이블의 기본키를 참조하는 외래키를 먼저 삭제해야 한다.
ALTER TABLE PLAYER_TBL   DROP CONSTRAINT NAT_PLA_FK;
ALTER TABLE SCHEDULE_TBL DROP CONSTRAINT NAT_SCH_FK; 
ALTER TABLE NATION_TBL   DROP CONSTRAINT NAT_PK;

-- 선수 테이블의 EVE_PLA_FK 외래키 일시중지하기
ALTER TABLE PLAYER_TBL DISABLE CONSTRAINT EVE_PLA_FK;
-- 선수 테이블의 EVE_PLA_FK 외래키 다시시작하기
ALTER TABLE PLAYER_TBL ENABLE CONSTRAINT EVE_PLA_FK;