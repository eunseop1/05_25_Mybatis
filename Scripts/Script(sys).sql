-- http 포트 번호 확인
select dbms_xdb.gethttpport as "HTTP-Port" from dual;

-- 계정 정보 확인
select username,account_status,lock_date from dba_users;

-- 잠긴 HR계정을 풀어보자
--ALTER USER hr account unlock;
ALTER USER hr account unlock;

-- 계정 비밀번호 변경
-- ALTER USER 계정명 IDENTIFIED BY "비밀번호";
ALTER USER hr IDENTIFIED BY "123456";

-- 계정 생성
create user jspuser identified by "123456";

-- 권한 설정
grant connect, resource to jspuser;
-- 05-23
-- --------------------------------------------------------------------

-- 05-24
-- 실습할 테스트 계정을 만들자1
CREATE USER testuser IDENTIFIED BY "123456";

-- 일반적인 권한을 가지고 있는 롤(role)을 이용하여 권한을 설정1
GRANT CONNECT, resource TO testuser;

