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

-- ms_board 테이블의 writer 속성의 타입을 number 변경하시오
alter table ms_board modify writer number;

-- 외래키 지정
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명
-- FOREIGN KEY (외래키컬럼) REFERENCES 참조테이블(기본키);

-- ms_board 테이블의 writer 속성에 대하여
-- ms_user의 user_no를 참도하도록 외래키로 지정하시오
ALTER TABLE ms_board ADD CONSTRAINT ms_board_writer_fk
FOREIGN KEY (writer) REFERENCES ms_user(user_no);

-- 테이블 MS_FILE 의 BOARD_NO 속성을 테이블 MS_BOARD 의 BOARD_NO 를 
-- 참조하는 외래키로 지정하는 SQL 문을 작성하시오.
alter table ms_file add constraint ms_filse_board_no_fk
foreign key (board_no) references ms_board(board_no);

-- 테이블 MS_REPLY 의 BOARD_NO 속성을 테이블 MS_BOARD 의 BOARD_NO 를 
-- 참조하는 외래키로 지정하는 SQL 문을 작성하시오.
alter table ms_reply add constraint ms_reply_board_no_fk
foreign key (board_no) references ms_board(board_no);

-- 제약조건 삭제
-- alter table 테이블명 drop constraint 제약조건명;

-- 테이블 MS_USER 에 아래 <예시> 과 같이 속성을 추가하는 SQL문을 작성하시오.
alter table ms_user add ctz_no char(14) null unique;
alter table ms_user add gender char(6) null;

comment on column ms_user.ctz_no is '주민번호';
comment on column ms_user.gender is '성별';

desc ms_user;

-- 테이블 MS_USER 의 GENDER 속성이 (‘여‘, ‘남‘, ‘기타‘) 값을 갖도록 하는 제약조건을 추가하는 SQL 문을 작성하시오.
alter table ms_user add constraint ms_user_gender_check
check (gender in ('여', '남', '기타'));

-- 확장자 속성을 추가하는 SQL 문을 작성하시오.
alter table ms_file add ext varchar2(10) null;
comment on column ms_file.ext is '확장자';

desc ms_file;

-- 테이블 MS_FILE 의 FILE_NAME 속성에서 확장자를 추출하여 EXT 속성에 UPDATE 하는 SQL 문을 작성하시오.
/*
    - FILE NAME 에서 추출한 확장자가 jpeg, jpg, gif, png 가 아니면 삭제한다.
    - FILE_NAME 에서 추출한 확장자를 EXT 속성에 UPDATE 한다.
*/
merge into ms_file T            -- 대상 테이블 지정
-- 사용할 데이터의 자원을 지정
using(select file_no, file_name from ms_file) f
-- on (update 될 조건)
on (t.file_no = f.file_no)
-- 매치조건에 만족할 경우
when matched then
    -- substr(문자열, 시작번호)
    update set t.ext = substr(f.file_name, instr(f.file_name, '.', -1) + 1)
    delete where substr(f.file_name, instr(f.file_name, '.', -1) + 1)
            not in ('jpeg', 'jpg', 'gif', 'png');
-- when not matched then
-- [매치가 안 될 떄]

select * from ms_file;
select * from ms_board;
select * from ms_user;

-- 파일 추가
insert into ms_file (FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
values (1, 1, '강아지.png', '123', sysdate, sysdate, 'png');

insert into ms_file (FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
values (2, 1, 'Main.fxml', '123', sysdate, sysdate, 'jpg');

-- 게시글 추가
insert into ms_board (BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT, DEL_YN, 
                        DEL_DATE, REG_DATE, UPD_DATE)
values (1, '제목', '내용', 1, 0, 0, 'N', null, sysdate, sysdate);  

-- 유저 추가
insert into ms_user (USER_NO, USER_ID, USER_PW, USER_NAME, BIRTH, 
                    TEL, ADDRESS, REG_DATE, UPD_DATE, CTZ_NO, GENDER)
values (1, 'JOEUN', '123456', '김조은', to_date('2020/01/01', 'yyyy/mm/dd'),
        '010-1234-1234', '부평', sysdate, sysdate, '200101-334444', '남');
        
-- 테이블 MS_FILE 의 EXT 속성이 (‘jpg’, ‘jpeg’, ‘gif’, ‘png’) 값을 갖도록 하는 제약조건을 추가하는 SQL문을 작성하시오.
alter table ms_file add constraint ms_file_ext_check
check (ext in ('jpg', 'jpeg', 'gif', 'png'));

insert into ms_file (FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
values (3, 1, 'Main.fxml', '123', sysdate, sysdate, 'java');

insert into ms_file (FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
values (4, 1, '고양이.jpg', '123', sysdate, sysdate, 'jpg');

insert into ms_file (FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
values (5, 1, '제목없음', '123', sysdate, sysdate, null);

-- 테이블의 모든 행을 삭제하는 SQL 문을 작성하시오.
-- 1. [MS_USER] 테이블의 모든 행을 삭제하시오.
delete from ms_user;
truncate table ms_user;

-- 2. [MS_BOARD] 테이블의 모든 행을 삭제하시오.
delete from ms_board;
truncate table ms_board;

-- 3. [MS_FILE] 테이블의 모든 행을 삭제하시오.
delete from ms_file;
truncate table ms_file;

-- 4. [MS_REPLY] 테이블의 모든 행을 삭제하시오.
delete from ms_reply;
truncate table ms_reply;

select * from ms_user;
select * from ms_board;
select * from ms_file;
select * from ms_reply;

/*
    DELETE VS TRUNCATE
    * DELETE    - 데이터 조작어(DML)
    - 한 행 단위로 데이터를 삭제한다
    - COMMIT, ROLLBACK 를 이용하여 변경사항을 적용하거나 되돌릴 수 있음
    
    * TRUNCATE  - 데이터 정의어(DDL)
    - 모든 행을 삭제한다
    - 삭제된 데이터를 되돌릴 수 없다.
*/

-- 주어진 테이블의 속성을 삭제하는 SQL 문을 작성하시오.
-- 1. [MS_BOARD] 테이블의 WRITER 속성을 삭제하시오.
alter table ms_board drop column writer;
-- 2. [MS_FILE] 테이블의 BOARD_NO 속성을 삭제하시오.
alter table ms_file drop column board_no;
-- 3. [MS_REPLY] 테이블의 BOARD_NO 속성을 삭제하시오.
alter table ms_reply drop column board_no;


-- <예시>에 주어진 속성들을 각 테이블에 추가한 뒤 외래키로 지정하시오. 참조 테이블에 대하여 삭제 시, 
-- 연결된 속성의 값도 삭제를 하는 제약조건도 추가하는 SQL 문을 작성하시오.
-- [MS_BOARD] 테이블의 WRITER 속성을 추가하시오.
alter table ms_board add writer number not null;

-- WRITER 속성을 외래키로 지정
-- 참조 테이블 삭제시, 연쇄적으로 함께 삭제하는 옵션 지정
alter table ms_board 
add constraint ms_board_writer_fk
foreign key (writer) references ms_user(user_no) 
on delete cascade;
-- ON DELETE [NO ACTTION, RESTRICT, CASCADE, SET NULL]
-- * RESTRICT   : 자식 테이블의 데이터가 존재하면, 삭제 안함
-- * CASCADE    : 자식 테이블의 데이터도 함께 삭제
-- * SET NULL   : 자식 체이블의 데이터를 NULL로 변경

-- [MS_FILE] 테이블의 BOARD_NO 속성을 추가하시오.
alter table ms_file add board_no number not null;

alter table ms_file 
add constraint ms_file_board_no_fk
foreign key (board_no) references ms_board(board_no) 
on delete cascade;


-- [MS_REPLY] 테이블의 BOARD_NO 속성을 추가하시오.
alter table ms_reply add board_no number not null;

alter table ms_reply 
add constraint ms_reply_board_no_fk
foreign key (board_no) references ms_board(board_no) 
on delete cascade;

select * from ms_user;
select * from ms_board;
select * from ms_file;
select * from ms_reply;

-- 회원탈퇴 (회원번호 : 1)
delete from ms_user where user_no = 1;

-- on delete cascade 옵션으로 외래키 지정 시,
-- ms_user 데이터를 삭제하면,
-- ms_board 의 참조된 데이터도 연쇄적으로 삭제된다.

-- ms_user 데이터를 삭제되면,
-- ms_file, ms_reply의 참조된 데이터도 연쇄적으로 삭제된다.

-- 외래키 제약조건 정리
-- alter table 테이블명
-- add constraint 제약조건명
-- foreign key (외래키 속성) references 참조테이블(참조 속성); 

-- 옵션
-- ON UPDATE        -- 참조 테이블 수정 시,
-- * CASCADE        : 자식 데이터 수정
-- * SET NULL       : 자식 데이터는 NULL
-- * SET DEFAULT    : 자식 데이터는 기본값
-- * RESTRICT       : 자식 테이블의 참조하는 데이터가 존재하면, 부모 데이터 수정불가
-- * NO ACTION      : 아무런 해위도 하지 않는다 (기본값)

-- ON DELETE        -- 참조 테이블 삭제 시,
-- * CASCADE        : 자식 데이터 삭제
-- * SET NULL       : 자식 데이터는 NULL
-- * SET DEFAULT    : 자식 데이터는 기본값
-- * RESTRICT       : 자식 테이블의 참조하는 데이터가 존재하면, 부모 데이터 수정불가
-- * NO ACTION      : 아무런 해위도 하지 않는다 (기본값)


-- joeun 덤프파일 임포트
-- imp userid=관리자계정/비밀번호 file=덤프파일경로 fromuser=덤프소유계정(덤프파일을생성한계정) touser=임포트할계정
imp userid=system/123456 file=D:\lsm\SQL\joeun.dmp fromuser=joeun touser=joeun

REVOKE DBA FROM joeun;
drop user joeun cascade;

alter session set "_oracle_script" = true; 
create user joeun identified by 123456;
alter user joeun quota unlimited on users;
grant dba to joeun;

/*
  서브 쿼리(Sub Query : 하위 질의)
  : SQL 문 내부에 사용하는 SELECT문
  * 메인쿼리 : 서브쿼리를 사용하는 최종적인 SELECT 문
  
  * 서브쿼리 종류
  - 스칼라 서브쿼리    : SELECT 절에서 사용하는 서브쿼리
  - 인라인 뷰         : FROM 절에서 사용하는 서브쿼리
  - 서브 쿼리         : WHERE 절에서 사용하는 서브쿼리
*/


-- 스칼라 서브쿼리로 출력결과를 조회하는 SQL 문을 작성하시오.
select emp_id 사원번호
      ,emp_name 직원명  
      ,(select dept_title from department d
        where e.dept_code = d.dept_id) as 부서명 
      ,(select job_name from job j
        where j.job_code = e.job_code ) as 직급명
from employee e; 

select * from employee;
select * from department;
select * from job;

-- 인라인 뷰를 이용하여 부서별로 최고급여를 받는 직원을 조회하는 SQL 문을 작성하시오.

-- 1. 부서별로 최고급여 조회
select dept_code
      ,max(salary) 최고급여
      ,min(salary) 최저급여
      ,avg(salary) 평균급여
from employee
group by dept_code;

-- 2. 부서별 최고급여 조회결과를 서브쿼리(인라인 뷰)로 지정
select emp_id 사원번호
      ,emp_name 직원명  
      ,dept_title 부서명
      ,salary 급여
      ,MAX_SAL 최대급여
      ,MIN_SAL 최저급여
      ,round(AVG_SAL, 2) 평균급여
from employee e, department d,
    (
    select dept_code
      ,max(salary) MAX_SAL
      ,min(salary) MIN_SAL
      ,avg(salary) AVG_SAL
    from employee
    group by dept_code
     )t
 where e.dept_code = d.dept_id        -- 부서를 가지고 있는 사원을 의미함
   and e.salary = t.Max_SAL;          -- 부서를 가지고 있고 최고급여를 받는 사원을 의미함


-- 중첩 서브쿼리를 이용하여 직원명이 ‘이태림'인 사원과 같은 부서의 직원들 을 조회하는 SQL 문을 작성하시오.
select emp_id 사원번호
      ,emp_name 직원명
      ,email 이메일
      ,phone 전화번호
from employee
where dept_code = 
(select dept_code from employee where emp_name = '이태림');

-- 테이블 EMPLOYEE 와 DEPARTMENT 의 DEPT_CODE 와 DEPT_ID 속성이 일치하는 행이 존재하는 경우, 
-- 테이블 DEPARTMENT 의 데이터를 조회하는 SQL 문을 작성하시오.
-- 사원이 있는 부서 : D1, D2, D5, D6, D8, D9

-- 1) 서브쿼리
select dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
from department
where dept_id in 
            (select dept_code 
             from employee 
             where dept_code is not null)
order by dept_id;

-- 2) EXISTS
select dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
from department d
where exists
            (select *
             from employee e
             where e.dept_code = d.dept_id)
order by dept_id;           

-- 테이블 EMPLOYEE 와 DEPARTMENT 의 DEPT_CODE 와 DEPT_ID 속성이 일치하는 행이 존재하지 않는 경우, 
-- 테이블 DEPARTMENT 의 데이터를 조회하는 SQL 문을 작성하시오.
-- 1) 서브쿼리
select dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
from department
where dept_id not in 
            (select dept_code 
             from employee 
             where dept_code is not null)
order by dept_id;

-- 2) not EXISTS
select dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
from department d
where not exists
            (select *
             from employee e
             where e.dept_code = d.dept_id)
order by dept_id;         

-- 테이블 EMPLOYEE 의 DEPT_CODE 가 ‘D1’인 부서의 최대급여보다 
-- 더 큰 급여를 받는 사원을 조회하는 SQL 문을 작성하시오.
select e.emp_id 사원번호
      ,e.emp_name 직원명
      ,e.dept_code 부서번호
      ,d.dept_title 부서명
      ,to_char(e.salary, '999,999,999') 급여
from employee e, department d
where e.dept_code = d.dept_id and
      e.salary > (
                select max(salary) 최대급여
                from employee
                where dept_code = 'D1')
order by 급여;

-- ALL
-- : 모든 조건이 만족할 떄, 결과를 출력하는 연산자
select e.emp_id 사원번호
      ,e.emp_name 직원명
      ,e.dept_code 부서번호
      ,d.dept_title 부서명
      ,to_char(e.salary, '999,999,999') 급여
from employee e, department d
where e.dept_code = d.dept_id and
      e.salary > all (
                select salary
                from employee
                where dept_code = 'D1')
order by 급여;


-- 테이블 EMPLOYEE 의 DEPT_CODE 가 ‘D9’인 부서의 최저급여보다 
-- 더 큰 급여를 받는 사원을 조회하는 SQL 문을 작성하시오.
select e.emp_id 사원번호
      ,e.emp_name 직원명
      ,e.dept_code 부서번호
      ,d.dept_title 부서명
      ,to_char(e.salary, '999,999,999') 급여
from employee e, department d
where e.dept_code = d.dept_id and
      e.salary > (
                select min(salary) 최저급여
                from employee
                where dept_code = 'D9')
order by 급여 desc;

-- ANY
-- : 조건이 만족하는 값이 하나라도 있으면 결과를 출력하는 연산자
select e.emp_id 사원번호
      ,e.emp_name 직원명
      ,e.dept_code 부서번호
      ,d.dept_title 부서명
      ,to_char(e.salary, '999,999,999') 급여
from employee e, department d
where e.dept_code = d.dept_id and
      e.salary > any (
                select salary
                from employee
                where dept_code = 'D9')
order by 급여 desc;



-- 테이블 EMPLOYEE 와 DEPARTMENT 를 조인하여 출력하되, 
-- 부서가 없는 직원도 포함하여 출력하는 SQL 문을 작성하시오.
select emp_id 사원번호
      ,emp_name 직원명
      ,nvl(dept_id, '(없음)') 부서번호
      ,nvl(dept_title, '(없음)') 부서명
from employee e left join department d 
                on ( dept_code = dept_id );

select emp_id 사원번호
      ,emp_name 직원명
      ,nvl(dept_id, '(없음)') 부서번호
      ,nvl(dept_title, '(없음)') 부서명
from employee, department 
where dept_code = dept_id(+);

-- 테이블 EMPLOYEE 와 DEPARTMENT 를 조인하여 출력하되, 
-- 직원이 없는 부서도 포함하여 출력하는 SQL 문을 작성하시오.
select nvl(emp_id, '(없음)') 사원번호
      ,nvl(emp_name, '(없음)') 직원명
      ,dept_id 부서번호
      ,dept_title 부서명
from employee e right join department d 
                on ( dept_code = dept_id );
                
select nvl(emp_id, '(없음)') 사원번호
      ,nvl(emp_name, '(없음)') 직원명
      ,dept_id 부서번호
      ,dept_title 부서명
from employee, department 
where dept_code(+) = dept_id;    
                
-- 테이블 EMPLOYEE 와 DEPARTMENT 를 조인하여 출력하되, 
-- 직원 및 부서 유무에 상관없이 출력하는 SQL 문을 작성하시오.                
select nvl(emp_id, '(없음)') 사원번호
      ,nvl(emp_name, '(없음)') 직원명
      ,nvl(dept_id, '(없음)') 부서번호
      ,nvl(dept_title, '(없음)') 부서명
from employee e full join department d 
                on ( dept_code = dept_id );             
                
-- 사원번호, 직원명, 부서번호, 지역명, 국가명, 급여, 입사일자를 출력하시오
-- 지역명 : location.local_name
-- 국가명 : national.national_name
select * from location;
select * from national;

select e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_id 부서번호
        ,d.dept_title 부서명
        ,l.local_name 지역명
        ,e.salary 급여
        ,e.hire_date 입사일자
from employee e
    left join department d on e.dept_code = d.dept_id
    left join location l on d.location_id= l.local_code
    left join national n on l.national_code = n.national_code;

-- 사원들 주 매니저를 출력하시오    
-- 사원번호, 직원명, 부서명, 직급, 구분(매니저)을 출력하시오.

-- 1) maanager_id 컬럼이 null이 아닌 사원을 중복없이 조회
-- 매니저들의 사원번호
select distinct manager_id
from employee
where manager_id is not null;

-- 2) employee, department, job 테이블을 조인하여 조회
select *
from employee e
    left join department d on e.dept_code = d.dept_id
    join job j on e.job_code = j.job_code;

-- 3) 조인 결과 중, emp_id가 매니저 사원번호인 경우만 조회
select e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_id 부서번호
        ,d.dept_title 부서명
        ,j.job_name 직급
        ,'매니저' 구분
from employee e
    left join department d on e.dept_code = d.dept_id
    join job j on e.job_code = j.job_code
where emp_id in (
                select distinct manager_id
                from employee
                where manager_id is not null
                );
      
-- 사원(매니저가 아닌)만 조회하시오                
select e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_id 부서번호
        ,d.dept_title 부서명
        ,j.job_name 직급
        ,'사원' 구분
from employee e
    left join department d on e.dept_code = d.dept_id
    join job j on e.job_code = j.job_code
where emp_id not in (
                select distinct manager_id
                from employee
                where manager_id is not null
                );

--  조인을 이용하여, <예시> 와 같이 출력되는 SQL 문을 완성하시오.
-- (단, UNION 키워드를 이용하시오.)
select e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_id 부서번호
        ,d.dept_title 부서명
        ,j.job_name 직급
        ,'매니저' 구분
from employee e
    left join department d on e.dept_code = d.dept_id
    join job j on e.job_code = j.job_code
where emp_id in (
                select distinct manager_id
                from employee
                where manager_id is not null
                )
union
select e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_id 부서번호
        ,d.dept_title 부서명
        ,j.job_name 직급
        ,'사원' 구분
from employee e
    left join department d on e.dept_code = d.dept_id
    join job j on e.job_code = j.job_code
where emp_id not in (
                select distinct manager_id
                from employee
                where manager_id is not null
                );

-- 조인을 이용하여, <예시> 와 같이 출력되는 SQL 문을 완성하시오.
-- (단, CASE 키워드를 이용하시오.)
select e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_id 부서번호
        ,d.dept_title 부서명
        ,j.job_name 직급
        ,case
            when emp_id in (
                            select distinct manager_id
                            from employee
                            where manager_id is not null
                            )
            then '매니저'
            else '사원'
        end 구분
        ,case 
            when substr(emp_no, 8, 1) in ('1', '3') then '남자' 
            when substr(emp_no, 8, 1) in ('2', '4') then '여자' 
            end 성별
        ,to_char(sysdate, 'yyyy') -
         to_number(case
                when substr(emp_no, 8, 1) in ('1', '2') then '19' 
                when substr(emp_no, 8, 1) in ('3', '4') then '20'
                end || substr(emp_no, 1, 2)) 나이
        ,TRUNC (MONTHS_BETWEEN( sysdate, TO_DATE(
                                    CASE 
                                          WHEN SUBSTR(emp_no, 8, 1) IN ('1','2') THEN '19'
                                          WHEN SUBSTR(emp_no, 8, 1) IN ('3','4') THEN '20'
                                    END || SUBSTR(emp_no, 1, 6) 
                                 )
                     ) / 12 ) 만나이
        --,substr(emp_no, 1, 8) || char(substr(emp_no, ), '******') 주민등록번호
        ,rpad(substr(emp_no, 1, 8), 14, '*') 주민등록번호
from employee e
    left join department d on e.dept_code = d.dept_id
    join job j using(job_code);
-- using : 조인하고자 하는 두 테이블의 컬럼명이 같으면,
--          on 키워드 대신 조인 조건을 간단하게 작성하는 키워드

-- 주민등록번호로부터 성별 구하기
--     주민번호 뒷자리 첫글자가 1,3이면 남자
--     주민번호 뒷자리 첫글자가 2,4이면 여자
select case 
        when substr(emp_no, 8, 1) in ('1', '3') then '남자' 
        when substr(emp_no, 8, 1) in ('2', '4') then '여자' 
        end 성별
from employee;


-- 주민등록번호로부터 나이 구하기
-- 오늘날짜 - 생년월일 날짜
--      주민번호 뒷자리 첫글자가 1,2이면 1900년대생
--      주민번호 뒷자리 첫글자가 3,4이면 2000년대생
select 
    to_char(sysdate, 'yyyy') -
    to_number(case
                when substr(emp_no, 8, 1) in ('1', '2') then '19' 
                when substr(emp_no, 8, 1) in ('3', '4') then '20'
                end || substr(emp_no, 1, 2)) 만나이       
from employee;


-- 나이 구하기
select 
    to_char(sysdate, 'yyyy') -
    (case
            when substr(emp_no, 8, 1) in ('1', '2') then '19' 
            when substr(emp_no, 8, 1) in ('3', '4') then '20'
            end || substr(emp_no, 1, 2)) + 1 나이       
from employee;

-- 만 나이
SELECT emp_name
      ,TRUNC (MONTHS_BETWEEN( sysdate, TO_DATE(
                                    CASE 
                                          WHEN SUBSTR(emp_no, 8, 1) IN ('1','2') THEN '19'
                                          WHEN SUBSTR(emp_no, 8, 1) IN ('3','4') THEN '20'
                                    END || SUBSTR(emp_no, 1, 6) 
                                 )
                     ) / 12 ) 만나이
FROM employee
;



----------------------
select ROWNUM 순번
        ,e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_id 부서번호
        ,d.dept_title 부서명
        ,j.job_name 직급
        ,case
            when emp_id in (
                            select distinct manager_id
                            from employee
                            where manager_id is not null
                            )
            then '매니저'
            else '사원'
        end 구분
        ,case 
            when substr(emp_no, 8, 1) in ('1', '3') then '남자' 
            when substr(emp_no, 8, 1) in ('2', '4') then '여자' 
            end 성별
        ,to_char(sysdate, 'yyyy') -
         to_number(case
                when substr(emp_no, 8, 1) in ('1', '2') then '19' 
                when substr(emp_no, 8, 1) in ('3', '4') then '20'
                end || substr(emp_no, 1, 2)) 나이
        ,TRUNC (MONTHS_BETWEEN( sysdate, TO_DATE(
                                    CASE 
                                          WHEN SUBSTR(emp_no, 8, 1) IN ('1','2') THEN '19'
                                          WHEN SUBSTR(emp_no, 8, 1) IN ('3','4') THEN '20'
                                    END || SUBSTR(emp_no, 1, 6) 
                                 )
                     ) / 12 ) 만나이
        ,rpad(substr(emp_no, 1, 8), 14, '*') 주민등록번호
        --,to_char(sysdate, 'yyyy') - to_char(hire_date, 'yyyy') 근속연수
        ,trunc(months_between(sysdate, hire_date) / 12) 근속연수
        ,to_char(hire_date, 'yyyy.mm.dd') 입사일자
        ,to_char((salary + nvl(salary * bonus, 0)) * 12, '999,999,999,999') 연봉
from employee e
    left join department d on e.dept_code = d.dept_id
    join job j using(job_code);
    
------------------------------------------------------
-- 데이터 사전 뷰
select *
from user_tables
where table_name like '%EMP%';
    

-- 뷰 생성하기
-- 사원, 부서 테이블 조인한 결과를 뷰로 생성
-- 1. 사원, 부서 테이블 조인
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id;
   
-- 2. 뷰로 생성
CREATE VIEW v_emp_dept AS
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
;

-- 3. 뷰 조회
SELECT * FROM v_emp_dept;

-- 뷰 삭제
DROP VIEW v_emp_dept;

    
    
    
    

    
    
    