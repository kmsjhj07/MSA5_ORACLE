-- Active: 1709190476105@@127.0.0.1@1521@orcl@HR
-- 1. system 계정에 접속하는 SQL
conn system/123456

-- 2. HR 계정이 있는지 확인하는 SQL
SELECT *
FROM all_users
WHERE username = 'HR';

-- HR이 있을 때, 계정 잠금 해제
ALTER USER HR ACCOUNT UNLOCK;

-- HR이 없을 때, 계정 생성
-- c## 없이 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER HR IDENTIFIED BY 123456;
-- 테이블 스페이스 변경
ALTER USER HR DEFAULT TABLESPACE users;
-- 계정이 사용할 수 있는 용량 설정 (무한대)
ALTER USER HR QUOTA UNLIMITED ON users;
-- 계정에 권한 부여 
GRANT connect, resource TO HR;

-- 계정 삭제
DROP USER HR CASCADE;

-- 3. employees 테이블의 구조 조회하는 명령
desc employees;

SELECT employee_id, first_name
FROM employees;

-- 4.
-- AS (alias)   : 출력되는 컬럼명에 별명을 짓는 명령어
-- AS 사원번호      : 별칭 그대로 작성
-- AS "사원 번호"   : 띄어쓰기가 있으면 ""로 감싸서 작성
-- AS '사원 번호'     (에러)
SELECT employee_id AS "사원 번호"
      ,first_name AS 이름
      ,last_name AS 성
      ,email AS 이메일
      ,phone_number AS 전화번호
      ,hire_date AS 입사일자
      ,salary 급여
FROM employees;

-- 모든 컬럼 조회 : (*) [에스터리크
SELECT *
FROM employees;

-- 5.
-- 테이블 EMPLOYEES 의 JOB_ID를 중복된 데이터를 제거하고
-- 조회하는 SQL 문을 작성하시오.
SELECT DISTINCT job_id
FROM employees;

-- 6.
-- 테이블 EMPLOYEES 의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE salary > 6000;

-- 7.
-- 테이블 EMPLOYEES 의 SALARY(급여)가 10000인 사원의 모든 컬럼을
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE salary = 10000;

-- 8.
-- 테이블 EMPLOYEES 의 모든 속성들을
-- SALARY 를 기준으로 내림차순 정렬하고,
-- FIRST_NAME 을 기준으로 오름차순 정렬하여 조회하는 SQL 문을 작성하시오.

-- 정렬
-- ORDER BY 컬럼명 [ASC/DESC];
-- * ASC    : 오름차순
-- * DESC   : 내림차순
-- * (생략)  : 오름차순이 기본값
SELECT *
FROM employees
ORDER BY salary DESC, first_name ASC;

-- 9.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 조건 연산
-- OR 연산 : ~또는, ~이거나
-- WHERE A OR B;
SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT'
   OR job_id = 'IT_PROG';

-- 10.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 단, IN 키워드를 사용하시오.
SELECT *
FROM employees
WHERE job_id IN ('FI_ACCOUNT', 'IT_PROG');

-- 11.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 아닌
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 단, IN 키워드를 사용하시오.
SELECT *
FROM employees
WHERE job_id NOT IN ('FI_ACCOUNT', 'IT_PROG');
   
-- 12.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘IT_PROG’ 이면서 SALARY 가 6000 이상인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE job_id = 'IT_PROG'
  AND salary >= 6000;

-- 13.
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 ‘S’로 시작하는
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- 14.
-- 's' 로 끝나는
SELECT *
FROM employees
WHERE first_name LIKE '%s';

-- 15.
-- 's' 가 포함되는
SELECT *
FROM employees
WHERE first_name LIKE '%s%';

-- 16.
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 5글자인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. 

-- 1) LIKE 키워드 사용
SELECT *
FROM employees
WHERE first_name LIKE '_____'; -- 언더바 5개

-- 2) LENGTH() 함수 사용
-- *  LENGTH(컬럼명) : 글자 수를 반환하는 함수
SELECT *
FROM employees
WHERE LENGTH(first_name) = 5;

-- 17.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL 인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- 18.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL이 아닌
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. 
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;

-- 19.
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년 이상인
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오.

-- 1) 문자열 --> 암시적 형변환하여 조회
SELECT *
FROM employees
WHERE hire_date >= '01/JAN/04';
-- * 데이터의 월 값이 숫자면 --> '01/01/04'
-- * 데이터의 월 값이 문자면 --> '01/JAN/04'

-- 2) TO_DATE 함수로 변환하여 조회
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('04/01/01', 'YY/MM/DD')
ORDER BY hire_date ASC;

-- 20.
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년도부터 05년도인
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오
SELECT *
FROM employees
WHERE hire_date >= '01/JAN/04'
  AND hire_date <= '31/DEC/05';
  
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('04/01/01', 'YY/MM/DD')
  AND hire_date <= TO_DATE('05/12/31', 'YY/MM/DD');

-- 21.
-- 12.45, -12.45 보다 크거나 같은 정수 중 제일 작은 수를
-- 계산하는 SQL 문을 각각 작성하시오.
-- * dual ?
-- : 산술 연산, 함수 결과 등을 확인해볼 수 있는 임시 테이블
SELECT CEIL(12.45), CEIL(-12.45)
FROM dual;

-- 22.
-- 12.55와 -12.55 보다 작거나 같은 정수 중 가장 큰 수를
-- 계산하는 SQL 문을 각각 작성하시오.
SELECT FLOOR(12.55), FLOOR(-12.55)
FROM dual;

-- 23.
-- ROUND(값, 자리수)
-- : 지정한 값을, 해당 자리수에서 반올림하는 함수
-- a a a a a.bbbb
-- ...  -2-1.0123
-- 0.54 를 소수점 아래 첫째 자리에서 반올림하시오
SELECT ROUND(0.54, 0) FROM dual;

-- 0.54 를 소수점 아래 둘째 자리에서 반올림하시오
SELECT ROUND(0.54, 1) FROM dual;

-- 125.67 을 일의 자리에서 반올림하시오.
SELECT ROUND(125.67, -1) FROM dual;

-- 125.67 을 십의 자리에서 반올림하시오.
SELECT ROUND(125.67, -2) FROM dual;

-- 24.
-- 각 소문제에 제시된 두 수를 이용하여 나머지를 구하는 SQL문을 작성하시오.
-- MOD(A, B)
-- : A를 B로 나눈 나머지를 구하는 함수

-- 3을 8로 나눈 나머지
SELECT MOD(3, 8)
FROM dual;

-- 30을 4로 나눈 나머지
SELECT MOD(30, 4)
FROM dual;

-- 25. 제곱수 구하기
-- POWER( A, B )
-- : A 의 B 제곱을 구하는 함수
-- 2의 10 제곱을 구하시오.
SELECT POWER(2,10)
FROM dual;

-- 2의 31제곱을 구하시오
SELECT POWER(2,31)
FROM dual;

-- 26. 제곱근 구하기
-- SQRT( A )
-- : A의 제곱근을 구하는 함수
--   A는 양의 정수와 실수만 사용 가능
-- 2의 제곱근을 구하시오.
SELECT SQRT(2)
FROM dual;

-- 100의 제곱근을 구하시오.
SELECT SQRT(100)
FROM dual;

-- 27.
-- TRUNC(실수, 자리수)
-- : 해당 수를 절삭하는 함수
-- 527425.1234 소수점 아래 첫째 자리에서 절삭
SELECT TRUNC(527425.1234, 0)
FROM dual;

-- 527425.1234 소수점 아래 둘째 자리에서 절삭
SELECT TRUNC(527425.1234, 1)
FROM dual;

-- 527425.1234 일의 자리에서 절삭
SELECT TRUNC(527425.1234, -1)
FROM dual;

-- 527425.1234 십의 자리에서 절삭
SELECT TRUNC(527425.1234, -2)
FROM dual;
-- 28. 절댓값 구하기
-- ABS( A )
-- : 값 A 의 절댓값을 구하여 변환하는 함수

-- -20 의 절댓값 구하기
SELECT ABS(-20)
FROM dual;

-- -12.456 의 절댓값 구하기
SELECT ABS(-12.456)
FROM dual;

-- 29.
-- <예시>와 같이 문자열을 대문자, 소문자, 첫글자만 대문자로
-- 변환하는 SQL문을 작성하시오.
-- 원문 : 'AlOhA WoRlD~!'
SELECT 'AlOhA WoRlD~!' AS 원문
      , UPPER('AlOhA WoRlD~!') AS 대문자
      , LOWER('AlOhA WoRlD~!') AS 소문자
      , INITCAP('AlOhA WoRlD~!') AS "첫 글자만 대문자"
FROM dual;

-- 30.
-- <예시>와 같이 문자열의 글자 수와 바이트 수를
-- 출력하는 SQL문을 작성하시오.
-- LENGTH('문자열')  : 글자 수
-- LENGTHB('문자열') : 바이트 수
-- * 영문, 숫자, 빈칸 : 1 byte
-- * 한글             : 3 byte
SELECT LENGTH('ALOHA WORLD') AS "글자 수",
       LENGTHB('ALOHA WORLD') AS "바이트 수"
FROM dual;

SELECT LENGTH('알로하 월드') AS "글자 수",
       LENGTHB('알로하 월드') AS "바이트 수"
FROM dual;

-- 31.
-- 두 문자열을 연결하기
SELECT CONCAT('ALOHA', 'CLASS') AS "함수",
       'ALOHA' || 'CLASS' AS "기호"
FROM dual;

-- 32.
-- 문자열 부분 출력하기
-- SUBSTR(문자열, 시작번호, 글자수)
-- 'www.alohaclass.kr'
SELECT SUBSTR('www.alohaclass.kr', 1, 3) AS "1",
       SUBSTR('www.alohaclass.kr', 5, 10) AS "2",
       SUBSTR('www.alohaclass.kr', -2, 2) AS "3"
FROM dual;

SELECT SUBSTR('www.알로하클래스.com', 1, 3) AS "1",
       SUBSTR('www.알로하클래스.com', 5, 6) AS "2",
       SUBSTR('www.알로하클래스.com', -3, 3) AS "3"
FROM dual;

SELECT SUBSTRB('www.알로하클래스.com', 1, 3) AS "1",
       SUBSTRB('www.알로하클래스.com', 5, 18) AS "2",
       SUBSTRB('www.알로하클래스.com', -3, 3) AS "3"
FROM dual;

-- 33.
-- 문자열에서 특정 문자의 위치를 구하는 함수
-- INSTR( 문자열, 찾을 문자, 시작 번호, 순서 )
-- ex) 'ALOHACLASS'
-- 해당 문자열에서 첫글자 부터 찾아서, 2번째 A의 위치를 구하시오.
-- INSTR('ALOHACLASS', 'A', 1, 2)

SELECT INSTR('ALOHACLASS', 'A', 1, 1) AS "1번째 A",
       INSTR('ALOHACLASS', 'A', 1, 2) AS "2번째 A",
       INSTR('ALOHACLASS', 'A', 1, 3) AS "3번째 A",
       INSTR('ALOHACLASS', 'A', 1, 4) AS "4번째 A"
FROM dual;

-- 34.
-- 문자열을 왼쪽/오른쪽에 출력하고, 빈공간을 특정 문자로 채우는 함수
-- LPAD( 문자열, 칸의 수, 채울 문자 )
-- : 문자열에 지정한 칸을 확보하고, 왼쪽에 특정 문자로 채움

-- RPAD( 문자열, 칸의 수, 채울 문자 )
-- : 문자열에 지정한 칸을 확보하고, 오른쪽에 특정 문자로 채움
-- 'ALOHACLASS'
SELECT LPAD('ALOHACLASS', 20, '#') AS "왼쪽",
       RPAD('ALOHACLASS', 20, '#') AS "오른쪽"
FROM dual;

SELECT RPAD(SUBSTR('020415-3123456', 1, 8), 14, '#') 주민번호
FROM dual;









