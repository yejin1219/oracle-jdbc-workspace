CREATE TABLE MEMBER(
    ID VARCHAR2(100) PRIMARY KEY,
    PASSWORD VARCHAR2(150) NOT NULL,
    NAME VARCHAR2(50) NOT NULL,
    ADDRESS VARCHAR2(200) NOT NULL
);
SELECT * FROM MEMBER;

INSERT INTO MEMBER
        VALUES('user1',1111,'김예진','강남');
COMMIT;



CREATE SEQUENCE SEQ_BOARD;

DROP SEQUENCE SEQ_BOARD;
DROP TABLE BOARD;


CREATE TABLE BOARD(
    NO NUMBER,
    TITLE VARCHAR2(200) NOT NULL,
    CONTENT VARCHAR2(2000) NOT NULL,
    WRITER VARCHAR2(50) NOT NULL,
    REGDATE DATE DEFAULT SYSDATE
);
ALTER TABLE board ADD url VARCHAR(200);
SELECT * FROM BOARD WHERE no=131088;

INSERT INTO board(no,title,content,writer)
(SELECT SEQ_BOARD.NEXTVAL, title, content, writer FROM board);
ROLLBACK;

INSERT INTO BOARD (NO, TITLE, CONTENT, WRITER)
VALUES(SEQ_BOARD.NEXTVAL,'','목요일입니다.','목요일');



ALTER TABLE board ADD CONSTRAINT PK_BOARD PRIMARY KEY(no);
SELECT * FROM BOARD ORDER BY no DESC;

-- 힌트 표현방식(INDEX 사용하여): /*+ INDEX_DESC(테이블명 프라이머리키)*/
-- 첫페이지
SELECT NUM,NO,TITLE,WRITER,REGDATE
FROM(SELECT /*+ INDEX_DESC(board PK_BOARD)*/
ROWNUM NUM, NO, TITLE, WRITER, REGDATE
FROM BOARD
WHERE ROWNUM <= 10)
WHERE NUM > 0;

-- 두번째 페이지 (11~20): 먼저 1-20 까지 구한후(FORM 절에서 인라인 뷰 사용) 조건걸기 
SELECT NUM,NO,TITLE,WRITER,REGDATE
FROM(SELECT /*+ INDEX_DESC(board PK_BOARD)*/
ROWNUM NUM, NO, TITLE, WRITER, REGDATE
FROM BOARD
WHERE ROWNUM <= 20)
WHERE NUM > 10;

-- 세번째 페이지 (21~30)
SELECT NUM,NO,TITLE,WRITER,REGDATE
FROM(SELECT /*+ INDEX_DESC(board PK_BOARD)*/
ROWNUM NUM, NO, TITLE, WRITER, REGDATE
FROM BOARD
WHERE ROWNUM <= 30)
WHERE NUM > 20;

SELECT COUNT(NO)
       FROM BOARD;
       
commit;


---------------------------------------------security--------------------------------------------------------------
drop table member;
create table member(
    id varchar2(50) primary key,
    password varchar2(100) not null,
    name varchar2(50) not null,
    address varchar2(200),
    auth varchar2(50) default 'ROLE_MEMBER' not null,
    enabled number(1) default 1 not null -- enabled springsecurity가 활성여부 체크 
);

select * from member;


---------------------------------------------restfulapi--------------------------------------------------------------
create table company (
	vcode varchar2(10) primary key,
	vendor  varchar2(20) not null
);
insert  into company values('10', '삼성');
insert  into company values('20', '애플');
create table Phone(
	num varchar2(10) primary key,
	model varchar2(20) not null,
	price number not null,
	vcode varchar2(10),
   constraint fk_vcode foreign key(vcode) references company(vcode)
);
insert into Phone values('ZF01','Galaxy Z Flip5', 1369000,'10');
insert into Phone values('S918N','Galaxy S23 Ultra', 1479000,'10');
insert into Phone values('IPO02','iPhone 14',1250000,'20');
create table userinfo (
	id varchar(20) primary key,
	pw varchar(20) not null
);
insert into userinfo values('member','member');
insert into userinfo values('admin','admin');
commit;


select *
from phone




