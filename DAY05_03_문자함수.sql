-- 1. 대소문자 변환하기
SELECT UPPER(EMAIL),    -- 모두 대문자
       LOWER(EMAIL),    -- 모두 소문자
       INITCAP(EMAIL)   -- 첫 글자만 대문자
  FROM EMPLOYEES;
-- 2. 글자 수
SELECT FIRST_NAME,
       LENGTH(FIRST_NAME)
  FROM EMPLOYEES;
-- 3. 바이트 수
SELECT FIRST_NAME,
       LENGTHB(FIRST_NAME)
  FROM EMPLOYEES;

-- 4. 연결하기
--  1) || 연산자 (오라클 전용)
--  2) CONCAT 함수 
--     CONCAT(A, B) : 인수를 2개만 전달할 수 있다.
--     CONCAT(CONCAT(A, B), C) : 인수 3개 이상은 CONCAT 함수 여러 개로 해결한다.
SELECT *
  FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE CONCAT('515', '%');
 
SELECT *
  FROM EMPLOYEES
 WHERE EMAIL LIKE CONCAT(CONCAT('%', 'A'), '%');        -- A가 포함
 
-- 5. 일부만 반환 
SELECT SUBSTR(PHONE_NUMBER, 1, 3)       -- 전화번호의 첫번째 글자부터 3글자를 반환
  FROM EMPLOYEES;

-- 6. 특정 문자의 위치 반환하기
--    문자의 위치는 1부터 시작한다.
--    못 찾으면 0을 반환한다.
--    여러개 있을경우 최초 위치를 반환한다.
SELECT EMAIL,
       INSTR(EMAIL, 'R')
  FROM EMPLOYEES;

-- 7. 바꾸기
SELECT EMAIL,
       REPLACE(EMAIL, 'A', '$')     -- A를 $로
  FROM EMPLOYEES;

-- 8. 채우기
--      1) LPAD(표현식, 전체폭, 채울문자)
--      2) RPAD(표현식, 전체폭, 채울문자)
SELECT LPAD(DEPARTMENT_ID, 3, '0'),
       EMAIL,
       RPAD(SUBSTR(EMAIL, 1, 2), 5, '*')
  FROM EMPLOYEES;

-- 9. 공백 제거 
SELECT '[' || LTRIM('     HELLO     WORLD     ') || ']',        -- 왼쪽 공백 제거
       '[' || RTRIM('     HELLO     WORLD     ') || ']',        -- 오른쪽 공백 제거
       '[' ||  TRIM('     HELLO     WORLD     ') || ']'         -- 양쪽 공백 제거
  FROM EMPLOYEES;

-- 실습
-- 1. 사원테이블의 JOB_ID 에서 밑줄(_) 앞/뒷 부분만 부분 분리 조회하기
SELECT JOB_ID,
       SUBSTR(JOB_ID, 1, INSTR(JOB_ID, '_') -1),
       SUBSTR(JOB_ID, INSTR(JOB_ID, '_') + 1)       -- INSTR 3번째 비어있으면 끝까지 반환.
  FROM EMPLOYEES
 ORDER BY EMPLOYEE_ID;

-- 2. FIRST_NAME 과 LAST_NAME을 연결해서 모두 대문자로 바꾼 FULL_NAME 조회하기
SELECT UPPER(FIRST_NAME) || ' '|| UPPER(LAST_NAME)
  FROM EMPLOYEES
 ORDER BY EMPLOYEE_ID;






