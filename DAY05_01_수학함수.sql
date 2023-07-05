-- 1. 절대값 
SELECT ABS(-5)
  FROM DUAL;

-- 2. 제곱근(루트)
SELECT SQRT(25)
  FROM DUAL;

-- 3. 부호 판별
SELECT SIGN(4),     -- 양수 1
       SIGN(-5),    -- 음수 -1
       SIGN(0)      -- 0은 0
  FROM DUAL;

-- 4. 제곱
SELECT POWER(2, 10),    -- 2의 10제곱
       POWER(3, -1),
       POWER(0, 3)
  FROM DUAL;

-- 5. 나머지
SELECT MOD(5,3),
       MOD(20,-3)
  FROM DUAL;
-- 어떤 값을 순환 반복 시킬때 사용

-- 6. 정수로 올림
SELECT CEIL(-1.1)
  FROM DUAL;
-- 큰 정수로 올림

-- 7. 정수로 내림
SELECT FLOOR(-1.5)
  FROM DUAL;
-- 작은 정수로 내림

-- 8. 원하는 자릿수로 반올림
SELECT ROUND(123.456),
       ROUND(123.456, 1),
       ROUND(123.456, -1),
       ROUND(123.456, 0)
  FROM DUAL;
-- 기본값은 정수로 반올림 
-- ,1 소수 1자리로 반올림
-- ,-1 일의 자리에서 반올림

-- 9. 원하는 자릿수로 절사 (꼬리 자르기)
SELECT TRUNC(123.456),
       TRUNC(123.456, 1),
       TRUNC(123.456, -1),
       TRUNC(123.456, 0)
  FROM DUAL;
