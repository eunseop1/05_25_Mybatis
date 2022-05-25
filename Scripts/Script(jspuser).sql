SELECT * FROM tab;

-- 오라클은 절대로 from절을 생략 할수없다
SELECT SYSDATE FROM dual;

-- dual은 더미 테이블, 오라클은 from절을 생략할수 없기에 만든 것
SELECT * FROM dual;

SELECT 12 + 34 * 56 계산 FROM dual;

-- 오라클에는 auto_increment가 없다
-- 그래서 번호가 자동으로 증가하는 객체가 존재하는데, 이를 sequence라고 한다
-- 이름은 테이블명_키필드_seq 이름만 봐도 시퀀스로 알아보게끔 형태로 준다
CREATE SEQUENCE test_idx_seq;
DROP SEQUENCE test_idx_seq;

--다음 번호 생성
SELECT test_idx_seq.nextval FROM dual;
--현재 번호 생성
SELECT test_idx_seq.currval FROM dual;

CREATE TABLE test(
	idx NUMBER PRIMARY KEY,
	name varchar2(50)
);

SELECT * FROM tab;
SELECT * FROM test;
DROP TABLE test;

INSERT INTO test(idx, name) VALUES (test_idx_seq.nextval, '한사람');
INSERT INTO test(idx, name) VALUES (test_idx_seq.nextval, '두사람');
INSERT INTO test(idx, name) VALUES (test_idx_seq.nextval, '세사람');

