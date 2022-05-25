-- 메모장 테이블 만들기
-- 시퀀스 부터 만든다
CREATE SEQUENCE memo_idx_seq;
-- 테이블을 만들자
CREATE TABLE memo(
	idx NUMBER PRIMARY KEY,
	name varchar2(100) NOT NULL,
	password varchar2(100) NOT NULL,
	content varchar2(100) NOT NULL,
	regdate timestamp DEFAULT sysdate,
	ip varchar2(100) NOT NULL	
);

INSERT INTO 
	memo(idx, name, password, content, ip)
VALUES 
	(memo_idx_seq.nextval, '한사람', '1234', '와~~~ 1빠다!!!', '192.168.0.124');

SELECT * FROM memo;