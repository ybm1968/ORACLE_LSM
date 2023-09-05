-- 커서 실행 단축키 : ctrl + enter
-- 문서 전체 실행 : F5
select 1+1
from dual;

-- 1. 계정 접속 명령어
-- conn 계정명/비밀번호;
conn system/123456;

-- 2. 
-- SQL 은 대/소문자 구분이 없다.
-- 명령어 키워드 대문자, 식별자는 소문자 주로 사용한다
select user_id, username
from all_users;
-- where username = 'HR';

-- 3. HR 계정 생성
-- create user 계정명 identified by 비밀번호;
create user HR identified by 123456;

-- 4. 테이블 스페이스 변경
-- HR 계정의 기본테이블 영역을 'users'영역으로 지정
-- alter user 계정명 default tablespace users;
alter user HR default tablespace users;

-- 5. 계정이 사용할 수 있는 용량 설정
-- HR 계정의 사용 용량을 무한대로 지정
--alter user 계정명 quota unlimited on 테이블스페이스;
alter user HR quota unlimited on users;

-- 6. 계정에 권한을 부여
-- HR 계정에 connect, resource 권한을 부여
-- grant 권한명1, 권한명2 to 계정명;
grant connect, resource to HR;

-- 7. c##없이 계정 생성
alter session set '_oracle_script' = true; 

-- 기본 계정 생성
alter session set "_oracle_script" = true; 
create user HR identified by 123456;
alter user HR default tablespace users;
alter user HR quota unlimited on users;
grant connect, resource to HR;



-- 계정 삭제
-- HR 계정 삭제
-- drop user 계정명 [cascade];
drop user HR [cascade];

-- 계정 잠금 해제
-- alter user 계정명 account unlock;
alter user HR account unlock;

-- HR 샘플 스키마(데이터) 가져오기
-- 1. SQL PLUS
-- 2. HR 계정 접속
-- 3. 명령어 입력
-- @[경로]\hr_main.sql
-- @? : 오라클이 설치된 기본 경로
-- @?/demo/schema/human_resources/hr_main.sql
-- 4. 123456 비밀번호
-- 5. user[tablespace]
-- 6. temp[temp tablespace]
-- 7. [log 경로] - @?/demo/schema/log


-- 테이블 EMPLOYEES 의 테이블 구조를 조회하는 SQL 문을 작성하시오.
desc employees;

-- 테이블 EMPLOYEES 에서 EMPLOYEE_ID, FIRST_NAME (회원번호, 이름) 를 조회하는 SQL 문을 작성하시오.
-- * 사원 테이블의 사원번호와 이름을 조회
select employee_id, first_name
from employees;

-- 테이블 EMPLOYEES 이 <예시>와 같이 출력되도록 조회하는 SQL 문을 작성하시오.
-- 뛰어쓰기가 없으면, 따옴표 생략가능
-- ex) employee_id 사원 번호(X), employee_id "사원 번호"(O), employee_id 사원번호(O)
-- AS 생력가능
-- 한글 별칭을 부여하여 조회
select employee_id as "사원 번호"
      ,first_name as 이름
      ,last_name as 성
      ,email as 이메일
      ,phone_number as 전화번호
      ,hire_date as 입사일자
      ,salary as 급여
from employees
;

select *
from employees;

-- 테이블 EMPLOYEES 의 JOB_ID를 중복된 데이터를 제거하고 조회하는 SQL 문을 작성하시오.
-- distinct 컬럼명 : 중복된 데이터를 제거하고 조회하는 키워드
select distinct job_id, 
from employees;

-- 테이블 EMPLOYEES 의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
select *
from employees
where salary > 6000;

-- 테이블 EMPLOYEES 의 SALARY(급여)가 10000인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
select *
from employees 
where salary = 10000;

-- 테이블 EMPLOYEES 의 모든 속성들을 SALARY 를 기준으로 내림차순 정렬하고, FIRST_NAME 을 기준으로 오름차순 정렬
-- 하여 조회하는 SQL 문을 작성하시오.
select * 
from employees
order by salary desc, first_name asc; 

-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성
select *
from employees 
where job_id in('FI_ACCOUNT', 'IT_PROG');
-- where job_id = 'FI_ACCOUNT' or job_id = 'IT_PROG';

-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 아닌 사원의 모든 컬럼을 조회하는 SQL 문을 작성
select *
from employees
where job_id not in('FI_ACCOUNT', 'IT_PROG');

-- 테이블 EMPLOYEES 의 JOB_ID가 ‘IT_PROG’ 이면서 SALARY 가 6000 이상인 사원의 모든 컬럼을 조회하는 SQL 문을 작성
select *
from employees
where job_id = 'IT_PROG' and salary >= 6000;

-- 테이블 EMPLOYEES 의 FIRST_NAME 이 ‘S’로 시작하는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
select *
from employees 
where first_name like 'S%';

-- 테이블 EMPLOYEES 의 FIRST_NAME 이 ‘s’로 끝나는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
select *
from employees
where first_name like '%s';

-- 테이블 EMPLOYEES 의 FIRST_NAME 에 ‘s’가 포함되는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
select *
from employees
where first_name like '%s%';

-- 테이블 EMPLOYEES 의 FIRST_NAME 이 5글자인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
select *
from employees
where first_name like '_____';
-- where length(first_name) = 5;
-- length(컬럼명) : 글자수를 반환하는 함수

-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
select *
from employees
where commission_pct is null;

-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL이 아닌 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
select *
from employees
where commission_pct is not null;

-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년 이상인 모든 컬럼을 조회하는 SQL 문을 작성하시오.
select *
from employees
where hire_date >= '04/01/01';         -- SQL Developer 에서 문자형 데이터를 날짜형 데이터로 자동 변환

-- to_date() : 문자형 데이터를 날짜형 데이터로 변환하는 함수
select *
from employees
where hire_date >= to_date('20040101', 'yyyymmdd');   

-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년도부터 05년도인 모든 컬럼을 조회하는 SQL 문을 작성하시오.
select *
from employees
where hire_date >= '04/01/01' and hire_date <= '05/12/31';

select *
from employees
where hire_date >= to_date('20040101', 'yyyymmdd'); 
  and hire_date <= to_date('20051231', 'yyyymmdd'); 
  
-- 컬럼 between A and B; 
select *
from employees
where hire_date between to_date('20040101', 'yyyymmdd')
  and to_date('20051231', 'yyyymmdd'); 
  
select *
from employees
where hire_date between '04/01/01' and '05/12/31'; 

-- 12.45, -12.45 보다 크거나 같은 정수 중 제일 작은 수를 계산하는 SQL 문을 각각 작성하시오.
-- dual : 산술연산, 함수 결과 등을 확인해볼 수 있는 임시 테이블
-- ceil : 지정한 값보다 크거나 같은 정수 중 제일 작은 수를 반환하는 함수
select CEil(12.45) from dual;
select ceil(-12.45) from dual;
select ceil(12.45), ceil(-12.45) from dual;

-- 12.55와 -12.55 보다 작거나 같은 정수 중 가장 큰 수를 계산하는 SQL 문을 각각 작성하시오.
-- floor : 지정한 값보다 작거나 같은 정수 중 가장 큰 수를 반환하는 함수
select floor(12.55) from dual;
select floor(-12.55) from dual;
select floor(12.45), floor(-12.45) from dual;

-- round(값, 자리수) : 지정한 값을 해당자리에서 반올림하는 함수
-- a a a a.bbbbb
--    -2 1 0123
--- 0.54 를 소수점 아래 첫째 자리에서 반올림하시오.
select round(0.54, 0) from dual;

--- 0.54 를 소수점 아래 둘째 자리에서 반올림하시오.
select round(0.54, 1) from dual;

--- 125.67 을 일의 자리에서 반올림하시오.
select round(125.67, -1) from dual;

--- 125.67 을 십의 자리에서 반올림하시오.
select round(125.67, -2) from dual;

-- MOD(A, B) : A를 B로 나눈 나머지를 구하는 함수
-- 3을 8로 나눈 나머지를 구하시오.
select mod(3, 8) from dual;

-- 30을 4로 나눈 나머지를 구하시오.
select mod(30, 4) from dual;

-- POWER(A, B) : A의 B제곱을 구하는 함수
-- 2의 10제곱을 구하시오.
select power(2, 10) from dual;

-- SQRT(A) : A의 제곱근을 구하는 함수(A는 양의 정수와 실수만 사용가능)
-- 2의 31제곱을 구하시오.
select power(2, 31) from dual;

-- 2의 제곱근을 구하시오.
select sqrt(2) from dual;

-- 100의 제곱근을 구하시오.
select sqrt(100) from dual;

-- TRUNC(값, 자리수) : 지정한 값을 해당자리에서 절삭하는 함수
-- a a a a.bbbbb
--    -2 1 0123
-- 527425.1234 을 소수점 아래 첫째 자리에서 절삭하시오.
select trunc(527425.1234, 0) from dual;

-- 527425.1234 을 소수점 아래 첫째 자리에서 절삭하시오.
select trunc(527425.1234, 1) from dual;

-- 527425.1234 을 일의 자리에서 절삭하시오.
select trunc(527425.1234, -1) from dual;

-- 527425.1234 을 십의 자리에서 절삭하시오.
select trunc(527425.1234, -2) from dual;

-- ABS(A) : 값 A의 절댓값을 구하여 반환하는 함수
-- -20 의 절댓값을 구하시오.
select abs(-20) from dual;

-- -12.456 의 절댓값을 구하시오.
select abs(-12.456) from dual;

-- 문자열을 대문자, 소문자, 첫글자만 대문자로 변환하는 SQL문을 작성하시오.
select 'AlohA WoRlD~!' as 원문
       ,upper('AlohA WoRlD~!') as 대문자
       ,lower('AlohA WoRlD~!') as 소문자
       ,initcap('AlohA WoRlD~!') as "첫글자만 대문자"
from dual;

-- 영문자, 공백, 숫자 : 1byte, 한글 : 3byte(UTF-8)
-- LENGTH('문자열') : 글자수
-- LENGTHB('문자열') : 바이트 수
-- 문자열의 글자 수와 바이트 수를 출력하는 SQL문을 작성하시오.
select length('ALOHA WORLD') as "글자 수"
      ,lengthb('ALOHA WORLD') as "바이트 수"
from dual;

select length('알로하 월드') as "글자 수"
      ,lengthb('알로하 월드') as "바이트 수"
from dual;


-- 함수와 기호를 이용하여 두 문자열을 병합하여 출력하는 SQL문을 작성하시오.
select concat('ALOHA', 'WORLD') as 함수
      ,'ALOHA' || 'WORLD' as 기호
from dual;

-- SUBSTR(문자열, 시작번호, 글자수)
-- 문자열의 일부만 출력하는 SQL문을 작성하시오.
select substr('www.alohacampus.com', 1, 3) as "1"
      ,substr('www.alohacampus.com', 5, 11) as "2"
      ,substr('www.alohacampus.com', -3, 3) as "3"
from dual;

select substrb('www.alohacampus.com', 1, 3) as "1"
      ,substrb('www.alohacampus.com', 5, 11) as "2"
      ,substrb('www.alohacampus.com', -3, 3) as "3"
from dual;

-- www.알로하캠퍼스.com
select substr('www.알로하캠퍼스.com', 1, 3) as "1"
      ,substr('www.알로하캠퍼스.com', 5, 6) as "2"
      ,substr('www.알로하캠퍼스.com', -3, 3) as "3"
from dual;

select substrb('www.알로하캠퍼스.com', 1, 3) as "1"
      ,substrb('www.알로하캠퍼스.com', 5, 6*3) as "2"
      ,substrb('www.알로하캠퍼스.com', -3, 3) as "3"
from dual;

-- INSTR(문자열, 찾을문자, 시작번호, 순서)
-- 문자열에서 특정 문자의 위치를 구하는 SQL문을 작성하시오.
select instr('ALOHACAMPUS', 'A', 1, 1) as "1번째 A"
      ,instr('ALOHACAMPUS', 'A', 1, 2) as "2번째 A"
      ,instr('ALOHACAMPUS', 'A', 1, 3) as "3번째 A"
from dual;

-- RPAD(문자열, 칸의 수, 채울 문자)
-- : 문자열에 지정한 칸(바이트)을 확보하고 오른쪽에 특정문자로 채움
-- LPAD(문자열, 칸의 수, 채울 문자)
-- : 문자열에 지정한 칸(바이트)을 확보하고 완쪽에 특정문자로 채움
-- 대상 문자열을 왼쪽/오른쪽에 출력하고 빈공간을 특정 문자로 채우는 SQL문을 작성하시오.
select lpad('ALOHACAMPUS', 20, '#') as 왼쪽
      ,rpad('ALOHACAMPUS', 20, '#') as 오른쪽
from dual;

-- TO_CHAR(데이터, '날짜/숫자 형식') : 특정 데이터를 문자열 형식으로 변환하는 함수
-- 날짜형 -> 문자형
-- 테이블 EMPLOYEES 의 FIRST_NAME과 HIRE_DATE 를 검색하되 <예시>와 같이 날짜 형식을 지정하는 SQL 문을 작성
select first_name as 이름 
      ,to_char(hire_date,'yyyy-mm-dd (dy) hh:mi:ss') as 입사일자
      ,hire_date
from employees;

-- 숫자형 -> 문자형
-- 테이블 EMPLOYEES 의 FIRST_NAME과 SALARY 를 검색하되 <예시>와 같이 날짜 형식을 지정하는 SQL 문을 작성
select first_name as 이름
      ,to_char(salary, '$999,999,999') as 급여
from employees;

-- T0_DATE(데이터, 날짜형식) : 문자형 데이터를 날짜형 데이터로 변환하는 함수
-- * 해당 문자형 데이터를 날짜형으로 분석할 수 있는 위치와 형식을 지정해야함.
-- 문자형 -> 날짜형
-- 문자형으로 주어진 데이터를 날짜형 데이터로 변환하는 SQL 문을 작성하시오.
select 20230822 as 문자
      ,to_date('20230822', 'yyyymmdd') as 날짜1
      ,to_date('2023.08.22', 'yyyy.mm.dd') as 날짜2
      ,to_date('2023/08/22', 'yyyy/mm/dd') as 날짜3
      ,to_date('2023-08-22', 'yyyy-mm-dd') as 날짜4
from dual;

-- TONUMBER(데이터, 형식) : 문자형 데이터를 숫자형 데이터로 변환하는 함수
-- 문자형으로 주어진 데이터를 숫자형 데이터로 변환하는 SQL 문을 작성하시오.
select '1,200,000' as 문자
       ,to_number('1,200,000', '999,999,999') as 숫자
from dual;

-- sysdate : 현재 날짜/시간 정보를 가지고 있는 키워드
-- 현재 날짜를 반환하는 SQL 문을 작성하시오.
select sysdate-1 as 어제
      ,sysdate as 오늘
      ,sysdate+1 as 내일
from dual;

-- MONTHS_BETWEEN(A, B)
-- : 날짜 A부터 B까지 개월 수 차이를 반환하는 함수
-- (단, A > B 즉, A가 더 최근 날짜로 지정되어야 양수로 반환)
-- 입사일자와 오늘 날짜를 계산하여 근무달수와 근속연수를 구하는 SQL 문을 작성하시오.
select first_name as 이름
      ,to_char(hire_date, 'yyyy.mm.dd') as 입사일자
      ,to_char(sysdate, 'yyyy.mm.dd')  as 오늘
      ,trunc(sysdate - hire_date, 0) || '일' as 근무일수
      ,trunc(months_between(sysdate, hire_date)) || '개월' as 근무달수
      ,trunc(months_between(sysdate, hire_date) / 12) || '년' as 근속연수
from employees;

-- ADD_MONTHS(날짜, 개월수) 
-- : 지정한 날짜로부터 해당 개월 수 후의 날짜를 반환하는 함수
-- 오늘 날짜와 6개월 후의 날짜를 출력하는 SQL 문을 작성하시오.
select sysdate as 오늘
      ,add_months(sysdate, 6) as "6개월후"
from dual;

select '2023/07/25' as 개강
      ,add_months('2023/07/25', 6) as 종강
from dual;

-- NEXT_DAY(날짜, 요일) : 지정한 날짜 이후 돌아오는 요일을 반환하는 함수
-- * 요일(일1 ~ 토7)
-- 오늘 날짜와 오늘 이후 돌아오는 토요일의 날짜를 출력하는 SQL 문을 작성하시오.
select sysdate as 오늘
      ,next_day(sysdate, 7) as "다음 토요일"
from dual;

select next_day(sysdate, 1) as "다음 일요일"
      ,next_day(sysdate, 2) as "다음 월요일"
      ,next_day(sysdate, 3) as "다음 화요일"
      ,next_day(sysdate, 4) as "다음 수요일"
      ,next_day(sysdate, 5) as "다음 목요일"
      ,next_day(sysdate, 6) as "다음 금요일"
      ,next_day(sysdate, 7) as "다음 토요일"
from dual;

-- LAST_DAY(날짜) : 지정한 날짜와 동일한 월의 월말 일자를 반환하는 함수
-- 날짜 : XXXXX.YYYYY -> 1970년1월1일 00시00분00초00ms -> 2023년08월22일...
-- 지난 일자를 정수로 계산, 시간정보는 소수부분으로 계산
-- XXXXX.YYYYY 날짜 데이터를 월 단위로 절삭하면, 월초를 구할 수 있다.
-- 오늘 날짜와 월초, 월말 일자를 구하는 SQL 문을 작성하시오.
select sysdate 오늘
      , trunc(sysdate, 'mm') 월초
      , last_day(sysdate) 월말
from dual;

-- NVL(값, 대체할 값) : 해당 값이 NULL이면 지정된 값으로 변환하는 함수
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
-- 테이블 EMPLOYEES 의 COMMISSION_PCT 를 중복없이 검색하되, NULL 이면 0으로 조회하고 
-- 내림차순으로 정렬하는 SQL 문을 작성하시오.
select distinct nvl(commission_pct, 0) as "커미션(%)"
from employees
order by nvl(commission_pct, 0) desc;

-- 조회한 컬럼의 별칭으로 ORDER BY 절에서 사용할 수 있다.
select distinct nvl(commission_pct, 0) as "커미션(%)"
from employees
order by "커미션(%)" desc;

-- NVL2(값, null 아닐 떄 값, null 일 때 값)
-- 테이블 EMPLOYEES 의 FIRST_NAME, SALARY, COMMISSION_PCT 속성을 이용하여 <예시>와 같이 
-- SQL 문을 작성하시오.
select first_name 이름
       ,salary 급여
       ,nvl(commission_pct, 0) 커미션
       ,salary + (salary * nvl(commission_pct, 0)) 최종급여
       ,nvl2(commission_pct, salary + (salary * commission_pct), salary) 최종급여2
from employees
order by 최종급여 desc;

-- DECODE(컬럼명, 조건값1, 반환값1, 조건값2, 반환값2...)
-- : 지정한 컬럼의 값이 조건값에 일치하면 바로 뒤의 반환값을 출력하는 함수
-- 테이블 EMPLOYEES 의 FIRST_NAME, DEPARTMENT_ID 속성을 이용하여 <예시>와 같이 SQL 문을 작성하시오.
select first_name as 이름
      ,decode(department_id, 10, 'Administration', 
                             20, 'Marketing',
                             30, 'Marketing',
                             40, 'Marketing',
                             50, 'Marketing',
                             60, 'IT',
                             70, 'Public Relations',
                             80, 'Sales',
                             90, 'Executive',
                             100, 'Finance') 부서
from employees;

-- CASE문 : 조건식을 만족할때, 출력할 값을 지정하는 구문
-- CASE
--      WHEN 조건식 THEN 반환값1
--      WHEN 조건식 THEN 반환값2
--      WHEN 조건식 THEN 반환값3
--      ...
-- END
-- 한 줄 복사 : ctrl + shift + D
-- 테이블 EMPLOYEES 의 FIRST_NAME, DEPARTMENT_ID 속성을 이용하여 <예시>와 같이 SQL 문을 작성하시오.
select first_name as 이름
      ,case when department_id = 10 then 'Administration'
            when department_id = 20 then 'Marketing'
            when department_id = 30 then 'Marketing'
            when department_id = 40 then 'Marketing'
            when department_id = 50 then 'Marketing'
            when department_id = 60 then 'IT'
            when department_id = 70 then 'Public Relations'
            when department_id = 80 then 'Sales'
            when department_id = 90 then 'Executive'
            when department_id = 100 then 'Finance'
            end 부서
from employees;

-- COUNT(컬럼명) : 컬럼을 지정하여 null을 제외한 데이터 개수를 반환하는 함수
-- * null 이 없는 데이터라면 어떤 컬럼을 지정하더라도 개수가 같기 떄문에
-- 일반적으로, count(*)로 개수를 구한다.
-- 테이블 EMPLOYEES 의 사원 수를 구하는 SQL 문을 작성하시오.
select count(*) as 사원수 
      ,count(commission_pct) 커미션받는사원수
      ,count(department_id) 부서가있는사원수
from employees;

-- 테이블 EMPLOYEES 의 최고급여, 최저급여를 구하는 SQL 문을 작성하시오.
select max(salary) as 최고급여
      ,min(salary) as 최저급여
from employees;

-- 테이블 EMPLOYEES 의 급여합계, 급여평균을 구하는 SQL 문을 작성하시오.
select sum(salary) 급여합계
      ,round(avg(salary), 2) 급여평균
from employees;

-- 테이블 EMPLOYEES 의 급여표준편자와 급여분산을 구하는 SQL 문을 작성하시오.
select round(stddev(salary), 2) 급여표준편차
      ,round(variance(salary), 2) 급여분산
from employees;


-- 테이블 생생
-- 
/*
    CREATE TABLE 테이블명 (
        컬럼명1 타입 [DEFAULT 기본값] [NOT NULL/NULL] [제약조건],
        컬럼명2 타입 [DEFAULT 기본값] [NOT NULL/NULL] [제약조건],
        컬럼명3 타입 [DEFAULT 기본값] [NOT NULL/NULL] [제약조건],
        .....
    );
*/

-- TABLE 기술서를 참고하여 MS_STUDENT 테이블을 생성하는 SQL 문을 작성하시오.
create table MS_STUDENT (
     st_no      number              not null           primary key,
     name       varchar2(20)        not null,
     ctz_no     char(14)            not null,
     email      varchar2(100)       null               unique,
     address    varchar2(1000)      null,
     dept_no    number              not null,
     mj_no      number              not null,
     reg_date   date                default sysdate     not null,
     upd_date   date                default sysdate     not null,
     etc        varchar2(1000)      default '없음'       null
);

comment on table ms_student is '학생들의 정보를 관리한다.';
comment on column ms_student.st_no is '학생 번호';
comment on column ms_student.name is '이름';
comment on column ms_student.ctz_no is '주민등록번호';
comment on column ms_student.email is '이메일';
comment on column ms_student.address is '주소';
comment on column ms_student.dept_no is '학부번호';
comment on column ms_student.mj_no is '전공번호';
comment on column ms_student.reg_date is '등록일자';
comment on column ms_student.upd_date is '수정일자';
comment on column ms_student.etc is '특이사항';

drop table ms_student;
     
-- 테이블에 속성 추가
-- ALTER TABLE 테이블명 ADD 컬렴명 타입 DEFAULT 기본값 [NOT NULL];
-- MS_STUDENT 테이블에 속성을 추가하는 SQL 문을 작성하시오.
alter table ms_student add gender char(6) default '기타' not null;
comment on column ms_student.gender is '성별';

alter table ms_student add status varchar2(10) default '대기' not null;
comment on column ms_student.status is '재적';

alter table ms_student add adm_date date null;
comment on column ms_student.adm_date is '입학일자';

alter table ms_student add grd_date date null;
comment on column ms_student.grd_date is '졸업일자';

desc ms_student;
    
-- 테이블 속성 삭제
-- ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
ALTER TABLE MS_STUDENT DROP COLUMN gender;
ALTER TABLE MS_STUDENT DROP COLUMN status;
ALTER TABLE MS_STUDENT DROP COLUMN adm_date;
ALTER TABLE MS_STUDENT DROP COLUMN grd_date;
    
-- 데이터 타입을 date 로 수정
-- 설명도 '생년월일'로 변경
-- MS_STUDENT 테이블의 주민번호 속성을 생년월일 속성으로 수정하는 SQL 문을 작성하시오.
alter table ms_student rename column ctz_no to birth;
alter table ms_student modify birth date;
comment on column ms_student.birth is '생년월일';

-- 속성변경 - 타입 변경
alter table ms_student modify birth date; 
-- 속성변경 - null 여부 변경
alter table ms_student modify birth null;
-- 속성변경 - default 변경
alter table ms_student modify birth default sysdate;

-- 동시에 적용 가능
alter table ms_student modify birth date default sysdate not null;

-- MS_STUDENT 테이블의 학부번호 속성을 삭제하는 SQL 문을 작성하시오.
alter table ms_student drop column dept_no;

-- MS_STUDENT 테이블을 삭제하는 SQL 문을 작성하시오.
drop table ms_student;

-- TABLE 기술서를 참고하여 MS_STUDENT 테이블을 생성하는 SQL 문을 작성하시오.
CREATE TABLE MS_STUDENT (
     ST_NO      NUMBER          NOT NULL   PRIMARY KEY
    ,NAME       VARCHAR2(20)    NOT NULL
    ,BIRTH      DATE            NOT NULL
    ,EMAIL      VARCHAR2(100)   NOT NULL
    ,ADDRESS    VARCHAR2(1000)  NULL
    ,MJ_NO      VARCHAR2(10)    NOT NULL
    ,GENDER     CHAR(6)         DEFAULT '기타'    NOT NULL
    ,STATUS     VARCHAR2(10)    DEFAULT '대기'    NOT NULL
    ,ADM_DATE   DATE    NULL
    ,GRD_DATE   DATE    NULL
    ,REG_DATE   DATE    DEFAULT sysdate NOT NULL
    ,UPD_DATE   DATE    DEFAULT sysdate NOT NULL
    ,ETC        VARCHAR2(1000)  DEFAULT '없음' NULL
);

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';

COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-- 데이터 삽입(INSERT)
-- 참고하여 MS_STUDENT 테이블에 데이터를 삽입하는 SQL 문을 작성하시오.
insert into ms_student (ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC)
values ('20180001', '최서아', '991005', 'cas@univ.ac.kr', '서울', 'I01',
        '여', '재학', '2018/03/01', null, sysdate, sysdate, null);
        

INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20210001', '박서준', TO_DATE('2002/05/04', 'YYYY/MM/DD'), 'psj@univ.ac.kr', '서울', 'B02',
         '남', '재학', TO_DATE('2021/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20210002', '김아윤', TO_DATE('2002/05/04', 'YYYY/MM/DD'), 'kay@univ.ac.kr', '인천', 'S01',
         '여', '재학', TO_DATE('2021/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20160001', '정수안', TO_DATE('1997/02/10', 'YYYY/MM/DD'), 'jsa@univ.ac.kr', '경남', 'J01',
         '여', '재학', TO_DATE('2016/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20150010', '윤도현', TO_DATE('1996/03/11', 'YYYY/MM/DD'), 'ydh@univ.ac.kr', '제주', 'K01',
         '남', '재학', TO_DATE('2016/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20130007', '안아람', TO_DATE('1994/11/24', 'YYYY/MM/DD'), 'aar@univ.ac.kr', '경기', 'Y01',
         '여', '재학', TO_DATE('2013/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, '영상예술 특기자' );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20110002', '한성호', TO_DATE('1992/10/07', 'YYYY/MM/DD'), 'hsh@univ.ac.kr', '서울', 'E03',
         '남', '재학', TO_DATE('2015/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );
         
SELECT * FROM MS_STUDENT;

/*
    UPDATE 테이블명
       SET 컬럼1 = 변경할 값,
           컬럼2 = 변경할 값,
           ....
       WHERE 조건
*/
-- MS_STUDENT 테이블에 데이터를 수정하는 SQL 문을 작성하시오.
update ms_student 
   set address = '서울'
      ,status = '휴학' 
where st_no = '20160001';

update ms_student 
   set address = '서울'
      ,status = '졸업'
      ,grd_date = '20200220' 
      ,upd_date = sysdate
      ,etc = '수석'
where st_no = '20150010';

update ms_student 
   set status = '졸업'
       ,grd_date = '20200220' 
       ,upd_date = sysdate
where st_no = '20130007';

update ms_student 
   set status = '퇴학'
       ,upd_date = sysdate
       ,etc = '자진 퇴학'
where st_no = '20110002';

select * from ms_student;

-- MS_STUDENT 테이블에 데이터를 삭제하는 SQL 문을 작성하시오.
delete from ms_student where st_no = '20110002';

-- MS_STUDENT 테이블의 모든 속성을 조회하는 SQL 문을 작성하시오.
select * from ms_student;

-- 백업 테이블 만들기
-- 테이블의 모든 속성을 조회하여 MS_STUDENT_BACK 테이블을 생성하는 SQL 문을 작성하시오.
create table ms_student_back
as select * from ms_student;

select * from ms_student_back;

-- MS_STUDENT 테이블의 튜플을 삭제하는 SQL 문을 작성하시오.
delete from ms_student;

select * from ms_student;

-- MS_STUDENT_BACK 테이블의 모든 속성을 조회하여 MS_STUDENT 테이블에 삽입하는 SQL 문을 작성하시오.
insert into ms_student  
select * from ms_student_back;

select * from ms_student;

-- MS_STUDENT 테이블의 성별 속성이 (‘여’, ‘남‘, ‘기타‘ ) 값만 입력가능하도록 하는 제약조건을 추가하시오.
alter table ms_student 
add constraint ms_std_gender_check
check(gender in ('여', '남', '기타'));

update ms_student
    set gender = '???';
    
-- 제약조건
-- 기본키(PRIMARY KEY) : 중복 불가, NULL불가 (필수 입력)
-- * 해당 테이블의 데이터를 고유하게 구분할 수 있는 속성으로 지정

-- 고유키(UNIQUE KEY) : 중복 불가, NULL 허용
-- * 중복되지 않아야할 데이터(ID, 주민번호, 이메일 ...)

-- CHECK : 지정한 값만 입력/수정 가능하도록 제한하는 조건
-- 지정한 값이 아닌 다른 값을 입력/수정하는 경우
-- "체크 제약조건(HR.MS_STD_GENDER_CHECK)이 위배되었습니다" 에러 발생 
    

-- 주어진 “community.dmp” 덤프파일을 ‘joeun2’ 계정에 import 하는 명령어를 작성하시오.

-- joeun 계정 생성
alter session set "_oracle_script" = true; 
create user joeun identified by 123456;
alter user joeun default tablespace users;
alter user joeun quota unlimited on users;
grant connect, resource to joeun;

-- 덤파파일 import 하기 (CMD에서 실행)
-- imp userid=관리자계정/비밀번호 file=덤프파일경로 fromuser=덤프소유계정(덤프파일을생성한계정) touser=임포트할계정
imp userid=system/123456 file=D:\lsm\SQL\community.dmp fromuser=joeun touser=joeun

-- 사용 중인 계정(‘joeun’)이 소유하고 있는 데이터를 “community.dmp” 덤프파일로 export 하는 명령어를 작성하시오.
-- exp userid=생성계정/비밀번호 file=덤프파일경로 log=로그파일경로
-- 생성계정은 import 할 떄 fromueser로 쓰인다.
exp userid=joeun/123456 file=D:\lsm\SQL\community2.dmp log=D:\lsm\SQL\community2.log

-- 테이블 MS_BOARD 에서 WRITER 속성을 아래 <예시>와 같이 데이터 타입을 변경하고, 테이블 MS_USER 의
-- USER_NO 를 참조하는 외래키를 지정하는 SQL 문을 작성하시오.





