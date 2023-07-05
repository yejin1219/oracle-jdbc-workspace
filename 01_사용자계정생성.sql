--사용자 생성하는 구문 : 관리자 계정만이 할 수 있는 역할
--[표현법] CREATE USER 계정명 IENVTIFIED BY 비밀번호;
CREATE user kh IDENTIFIED BY kh;

--위에서 만들어진 사용자 계정에게 최소한의 권한(데이터 관린, 접속) 부여
--[표현법] GRANT 권한1, 권한2,...TO 계정명;
--RESOURCE 는 객체(생성,수정,삭제), 데이터(입력,수정,조회,삭제)권한 
--CONNECT 권한이 없으면 해당 유저로 접속이 되지 않음 
GRANT RESOURCE, CONNECT TO kh;

GRANT UNLIMITED TABLESPACE TO kh;

CREATE user study IDENTIFIED BY study;
GRANT RESOURCE, CONNECT TO study;
GRANT UNLIMITED TABLESPACE TO study;

--jdbc 
CREATE USER jdbc IDENTIFIED BY jdbc;
GRANT RESOURCE, CONNECT TO jdbc; 
GRANT UNLIMITED TABLESPACE TO jdbc;