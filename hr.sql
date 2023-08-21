-- Ŀ�� ���� ����Ű : ctrl + enter
-- ���� ��ü ���� : F5
select 1+1
from dual;

-- 1. ���� ���� ��ɾ�
-- conn ������/��й�ȣ;
conn system/123456;

-- 2. 
-- SQL �� ��/�ҹ��� ������ ����.
-- ��ɾ� Ű���� �빮��, �ĺ��ڴ� �ҹ��� �ַ� ����Ѵ�
select user_id, username
from all_users
-- where username = 'HR';

-- 3. HR ���� ����
-- create user ������ identified by ��й�ȣ;
create user HR identified by 123456;

-- 4. ���̺� �����̽� ����
-- HR ������ �⺻���̺� ������ 'users'�������� ����
-- alter user ������ default tablespace users;
alter user HR default tablespace users;

-- 5. ������ ����� �� �ִ� �뷮 ����
-- HR ������ ��� �뷮�� ���Ѵ�� ����
--alter user ������ quota unlimited on ���̺����̽�;
alter user HR quota unlimited on users;

-- 6. ������ ������ �ο�
-- HR ������ connect, resource ������ �ο�
-- grant ���Ѹ�1, ���Ѹ�2 to ������;
grant connect, resource to HR;

-- 7. c##���� ���� ����
alter session set '_oracle_script' = true; 

-- �⺻ ���� ����
alter session set "_oracle_script" = true; 
create user HR identified by 123456;
alter user HR default tablespace users;
alter user HR quota unlimited on users;
grant connect, resource to HR;

-- ���� ����
-- HR ���� ����
-- drop user ������ [cascade];
drop user HR [cascade];

-- ���� ��� ����
-- alter user ������ account unlock;
alter user HR account unlock;

-- HR ���� ��Ű��(������) ��������
-- 1. SQL PLUS
-- 2. HR ���� ����
-- 3. ��ɾ� �Է�
-- @[���]\hr_main.sql
-- @? : ����Ŭ�� ��ġ�� �⺻ ���
-- @?/demo/schema/human_resources/hr_main.sql
-- 4. 123456 ��й�ȣ
-- 5. user[tablespace]
-- 6. temp[temp tablespace]
-- 7. [log ���] - @?/demo/schema/log


-- ���̺� EMPLOYEES �� ���̺� ������ ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
desc employees;

-- ���̺� EMPLOYEES ���� EMPLOYEE_ID, FIRST_NAME (ȸ����ȣ, �̸�) �� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- * ��� ���̺��� �����ȣ�� �̸��� ��ȸ
select employee_id, first_name
from employees;

-- ���̺� EMPLOYEES �� <����>�� ���� ��µǵ��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- �پ�Ⱑ ������, ����ǥ ��������
-- ex) employee_id ��� ��ȣ(X), employee_id "��� ��ȣ"(O), employee_id �����ȣ(O)
-- AS ���°���
-- �ѱ� ��Ī�� �ο��Ͽ� ��ȸ
select employee_id as "��� ��ȣ"
      ,first_name as �̸�
      ,last_name as ��
      ,email as �̸���
      ,phone_number as ��ȭ��ȣ
      ,hire_date as �Ի�����
      ,salary as �޿�
from employees
;

select *
from employees;

-- ���̺� EMPLOYEES �� JOB_ID�� �ߺ��� �����͸� �����ϰ� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- distinct �÷��� : �ߺ��� �����͸� �����ϰ� ��ȸ�ϴ� Ű����
select distinct job_id, 
from employees;

-- ���̺� EMPLOYEES �� SALARY(�޿�)�� 6000�� �ʰ��ϴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
select *
from employees
where salary > 6000;

-- ���̺� EMPLOYEES �� SALARY(�޿�)�� 10000�� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
select *
from employees 
where salary = 10000;

-- ���̺� EMPLOYEES �� ��� �Ӽ����� SALARY �� �������� �������� �����ϰ�, FIRST_NAME �� �������� �������� ����
-- �Ͽ� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
select * 
from employees
order by salary desc, first_name asc; 

-- ���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ�
select *
from employees 
where job_id in('FI_ACCOUNT', 'IT_PROG');
-- where job_id = 'FI_ACCOUNT' or job_id = 'IT_PROG';

-- ���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �ƴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ�
select *
from employees
where job_id not in('FI_ACCOUNT', 'IT_PROG');

-- ���̺� EMPLOYEES �� JOB_ID�� ��IT_PROG�� �̸鼭 SALARY �� 6000 �̻��� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ�
select *
from employees
where job_id = 'IT_PROG' and salary >= 6000;

-- ���̺� EMPLOYEES �� FIRST_NAME �� ��S���� �����ϴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
select *
from employees 
where first_name like 'S%';

-- ���̺� EMPLOYEES �� FIRST_NAME �� ��s���� ������ ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
select *
from employees
where first_name like '%s';

-- ���̺� EMPLOYEES �� FIRST_NAME �� ��s���� ���ԵǴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
select *
from employees
where first_name like '%s%';

-- ���̺� EMPLOYEES �� FIRST_NAME �� 5������ ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
select *
from employees
where first_name like '_____';
-- where length(first_name) = 5;
-- length(�÷���) : ���ڼ��� ��ȯ�ϴ� �Լ�

-- ���̺� EMPLOYEES �� COMMISSION_PCT�� NULL �� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
select *
from employees
where commission_pct is null;

-- ���̺� EMPLOYEES �� COMMISSION_PCT�� NULL�� �ƴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
select *
from employees
where commission_pct is not null;

-- ���̺� EMPLOYEES �� ����� HIRE_DATE�� 04�� �̻��� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
select *
from employees
where hire_date >= '04/01/01';         -- SQL Developer ���� ������ �����͸� ��¥�� �����ͷ� �ڵ� ��ȯ

-- to_date() : ������ �����͸� ��¥�� �����ͷ� ��ȯ�ϴ� �Լ�
select *
from employees
where hire_date >= to_date('20040101', 'yyyymmdd');   

-- ���̺� EMPLOYEES �� ����� HIRE_DATE�� 04�⵵���� 05�⵵�� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
select *
from employees
where hire_date >= '04/01/01' and hire_date <= '05/12/31';

select *
from employees
where hire_date >= to_date('20040101', 'yyyymmdd'); 
  and hire_date <= to_date('20051231', 'yyyymmdd'); 
  
-- �÷� between A and B; 
select *
from employees
where hire_date between to_date('20040101', 'yyyymmdd')
  and to_date('20051231', 'yyyymmdd'); 
  
select *
from employees
where hire_date between '04/01/01' and '05/12/31'; 

-- 12.45, -12.45 ���� ũ�ų� ���� ���� �� ���� ���� ���� ����ϴ� SQL ���� ���� �ۼ��Ͻÿ�.
