CREATE TABLE MEMBER2(
  
 ID VARCHAR2(200) PRIMARY KEY,
 PASSWORD VARCHAR2(200) NOT NULL,
 NAME VARCHAR2(200)NOT NULL,
 ADDRESS VARCHAR2(200) NOT NULL
);

SELECT *
FROM MEMBER2;

SELECT *
FROM MEMBER2
WHERE ID='user' AND PASSWORD='1234';
SELECT * FROM MEMBER2 WHERE ID='dpwls1219';

UPDATE MEMBER2
SET PASSWORD='', NAME=''
WHERE ID='';

DROP TABLE MEMBER2;

CREATE TABLE ITEM(
    ITEM_ID NUMBER PRIMARY KEY,
    ITEM_NAME VARCHAR2(45),
    PRICE NUMBER,
    DESCRIPTION VARCHAR2(100),
    PICTURE_URL VARCHAR2(45),
    COUNT NUMBER
);
CREATE SEQUENCE SEQ_ITEM;
INSERT INTO ITEM VALUES(SEQ_ITEM.NEXTVAL, '딸기', 4500, '면역력을 강화시켜 질병에 효과적이다.', 'img/berry.jpg', 0);
INSERT INTO ITEM VALUES(SEQ_ITEM.NEXTVAL, '포도', 5000, '철분이 많고 빈혈을 예방한다.', 'img/grape.jpg', 0);
INSERT INTO ITEM VALUES(SEQ_ITEM.NEXTVAL, '귤', 4000, '눈 건강 살리고 피로 회복, 혈압 안정시키는 비타민 A가 많다.', 'img/gual.jpg', 0);
INSERT INTO ITEM VALUES(SEQ_ITEM.NEXTVAL, '키위', 8000, '키위 1개에 함유된 비타민 C는 오렌지의 2배, 비타민 E는 사과의 6배나 된다.', 'img/kiwi.jpg', 0);
INSERT INTO ITEM VALUES(SEQ_ITEM.NEXTVAL, '레몬', 3000, '구연산 비타민C가 풍부하여 피로회복에 도움이 된다.', 'img/lemon.jpg', 0);
COMMIT;
SELECT * FROM ITEM;

CREATE TABLE MEMBER3(
    MEMBERID VARCHAR2(100) PRIMARY KEY,
    MEMBERPASS VARCHAR2(150) NOT NULL,
    MEMBERNAME VARCHAR2(50) NOT NULL,
    MEMBERADDR VARCHAR2(200) NOT NULL
);
INSERT INTO MEMBER3(MEMBERID, MEMBERPASS, MEMBERNAME, MEMBERADDR)
SELECT ID, PASSWORD, NAME, ADDRESS
FROM MEMBER2;

COMMIT;

SELECT memberid, memberpass, membername, memberaddr
	FROM MEMBER3;
    
    SELECT id, password, name, address
		FROM MEMBER2;