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
from all_users
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
