DROP TABLE VIDEO_LIKE;
DROP TABLE COMMENT_LIKE;
DROP TABLE VIDEO_COMMENT;
DROP TABLE SUBSCRIBE;
DROP TABLE VIDEO;
DROP TABLE CHANNEL;
DROP TABLE CATEGORY;
DROP TABLE MEMBER;

DROP SEQUENCE SEQ_CATEGORY;
DROP SEQUENCE SEQ_CHANNEL;
DROP SEQUENCE SEQ_COMMENT_LIKE;

DROP SEQUENCE SEQ_SUBSCIBE;
DROP SEQUENCE SEQ_VIDEO;
DROP SEQUENCE SEQ_VIDEO_COMMENT;
DROP SEQUENCE SEQ_VIDEO_LIKE;

-- 테이블명 USER, LIKE, COMMENT는 사용 할 수 없음
CREATE TABLE VIDEO(
    VIDEO_CODE NUMBER,
    VIDEO_TITLE VARCHAR2(100) NOT NULL,
    VIDEO_DESC VARCHAR2(200),
    VIDEO_DATE DATE DEFAULT SYSDATE,
    VIDEO_VIEWS NUMBER DEFAULT 0,
    VIDEO_URL VARCHAR2(300) NOT NULL,
    VIDEO_PHOTO VARCHAR2(300) NOT NULL,
    CATEGORY_CODE NUMBER,
    CHANNEL_CODE NUMBER,
    MEMBER_ID VARCHAR2(200)
);

CREATE TABLE CHANNEL(
    CHANNEL_CODE NUMBER,
    CHANNEL_NAME VARCHAR2(100) NOT NULL,
    CHANNEL_DESC VARCHAR2(200),
    CHANNEL_PHOTO VARCHAR2(300),
    CHANNEL_DATE DATE DEFAULT SYSDATE,
    MEMBER_ID VARCHAR2(200)
);

CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(200),
    MEMBER_PASSWORD VARCHAR2(200) NOT NULL,
    MEMBER_NICKNAME VARCHAR2(200) NOT NULL,
    MEMBER_EMAIL VARCHAR2(200),
    MEMBER_PHONE VARCHAR2(200),
    MEMBER_GENDER CHAR,
    MEMBER_AUTHORITY VARCHAR2(200)DEFAULT 'ROLE_USER'
);

CREATE TABLE VIDEO_LIKE(
    V_LIKE_CODE NUMBER,
    V_LIKE_DATE DATE DEFAULT SYSDATE,
    VIDEO_CODE NUMBER,
    MEMBER_ID VARCHAR2(200)
);

CREATE TABLE VIDEO_COMMENT(
    COMMENT_CODE NUMBER,
    COMMENT_DESC VARCHAR2(300) NOT NULL,
    COMMENT_DATE DATE DEFAULT SYSDATE,
    COMMENT_PARENT NUMBER,
    VIDEO_CODE NUMBER,
    MEMBER_ID VARCHAR2(200)
);

CREATE TABLE SUBSCRIBE(
    SUBS_CODE NUMBER,
    SUBS_DATE DATE DEFAULT SYSDATE,
    MEMBER_ID VARCHAR2(200),
    CHANNEL_CODE NUMBER
);

CREATE TABLE COMMENT_LIKE(
    COMM_LIKE_CODE NUMBER,
    COMM_LIKE_DATE DATE DEFAULT SYSDATE,
    COMMENT_CODE NUMBER,
    MEMBER_ID VARCHAR2(200)
);

CREATE TABLE CATEGORY(
    CATEGORY_CODE NUMBER,
    CATEGORY_NAME VARCHAR2(50)
);

-- 위 테이블 생성 먼저(제약 조건 제외하고)
-- ALTER TABLE로 PRIMARY KEY 설정, FOREIGN KEY 설정 
-- SEQUENCE 설정
-- 위 테이블에서 nott null,이나 default값 설정 

ALTER TABLE CATEGORY ADD CONSTRAINT CATEGORY_CODE_PK PRIMARY KEY(CATEGORY_CODE);
ALTER TABLE CHANNEL ADD CONSTRAINT CHANNEL_CODE_PK PRIMARY KEY(CHANNEL_CODE);
ALTER TABLE COMMENT_LIKE ADD CONSTRAINT COMMENT_LIKE_CODE_PK PRIMARY KEY(COMM_LIKE_CODE);
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_ID_PK PRIMARY KEY(MEMBER_ID);
ALTER TABLE SUBSCRIBE ADD CONSTRAINT SUBS_CODE_PK PRIMARY KEY(SUBS_CODE);
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_CODE_PK PRIMARY KEY(VIDEO_CODE);
ALTER TABLE VIDEO_COMMENT ADD CONSTRAINT VIDEO_COMMENT_CODE_PK PRIMARY KEY(COMMENT_CODE);
ALTER TABLE VIDEO_LIKE ADD CONSTRAINT V_LIKE_CODE_PK PRIMARY KEY(V_LIKE_CODE);

ALTER TABLE CHANNEL ADD CONSTRAINT CHANNEL_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE COMMENT_LIKE ADD CONSTRAINT COMMENT_LIKE_COMMENT_CODE_FK FOREIGN KEY(COMMENT_CODE) REFERENCES VIDEO_COMMENT;
ALTER TABLE COMMENT_LIKE ADD CONSTRAINT COMMENT_LIKE_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE SUBSCRIBE ADD CONSTRAINT SUBSCRIBE_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE SUBSCRIBE ADD CONSTRAINT SUBSCRIBE_CHANNEL_CODE_FK FOREIGN KEY(CHANNEL_CODE) REFERENCES CHANNEL;
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_CATEGORY_CODE_FK FOREIGN KEY(CATEGORY_CODE) REFERENCES CATEGORY;
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_CHANNEL_CODE_FK FOREIGN KEY(CHANNEL_CODE) REFERENCES CHANNEL;
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE VIDEO_COMMENT ADD CONSTRAINT VIDEO_COMMENT_VIDEO_CODE_FK FOREIGN KEY(VIDEO_CODE) REFERENCES VIDEO;
ALTER TABLE VIDEO_COMMENT ADD CONSTRAINT VIDEO_COMMENT_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE VIDEO_LIKE ADD CONSTRAINT VIDEO_LIKE_VIDEO_CODE_FK FOREIGN KEY(VIDEO_CODE) REFERENCES VIDEO;
ALTER TABLE VIDEO_LIKE ADD CONSTRAINT VIDEO_LIKE_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;

CREATE SEQUENCE SEQ_CATEGORY;
CREATE SEQUENCE SEQ_CHANNEL;
CREATE SEQUENCE SEQ_COMMENT_LIKE;

CREATE SEQUENCE SEQ_SUBSCIBE;
CREATE SEQUENCE SEQ_VIDEO;
CREATE SEQUENCE SEQ_VIDEO_COMMENT;
CREATE SEQUENCE SEQ_VIDEO_LIKE;

-- 바뀌지 않는 카테고리 먼저 넣기 
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '쇼핑');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '음악');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '영화');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '게임');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '스포츠');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '학습');

COMMIT;
-- CATEGORY잘 들어갔는지 확인 
SELECT * FROM CATEGORY; 


-- 테스트와 관련된 쿼리문들!
-- 회원가입(register)
INSERT INTO MEMBER(MEMBER_ID, MEMBER_PASSWORD, MEMBER_NICKNAME)VALUES('111','1111','김예진');
COMMIT;
SELECT * FROM MEMBER;

--로그인(login)
SELECT * FROM MEMBER WHERE MEMBER_ID = '111'  AND MEMBER_PASSWORD = '1111';

-- 채널 추가(addChannel)
INSERT INTO CHANNEL(CHANNEL_CODE, CHANNEL_NAME, MEMBER_ID)VALUES(SEQ_CHANNEL.NEXTVAL,'예진','111');
INSERT INTO CHANNEL(CHANNEL_CODE, CHANNEL_NAME, MEMBER_ID)VALUES(SEQ_CHANNEL.NEXTVAL,'예진2','111');
COMMIT;
SELECT * FROM CHANNEL;

--채널 수정(updateChannel)
UPDATE CHANNEL SET CHANNEL_NAME = '주황색 ORANGE MUSIC' WHERE CHANNEL_CODE = 1;

--채널 삭제(deleteChannel)
DELETE FROM CHANNEL WHERE CHANNEL_CODE=21;

-- 내 채널 보기(myChannel)
SELECT CHANNEL_CODE,CHANNEL_NAME, MEMBER_NICKNAME FROM CHANNEL JOIN MEMBER USING(MEMBER_ID) WHERE MEMBER_ID = '111';
COMMIT;
SELECT * FROM CHANNEL;

DELETE FROM CHANNEL WHERE CHANNEL_CODE=2;

-- 비디오 추가
INSERT INTO VIDEO(VIDEO_CODE, VIDEO_TITLE, VIDEO_URL, VIDEO_PHOTO, CATEGORY_CODE, CHANNEL_CODE, MEMBER_ID) 
VALUES(SEQ_VIDEO.NEXTVAL,'짱구','URL01','PHOTO01',1,1,'111');

INSERT INTO VIDEO(VIDEO_CODE, VIDEO_TITLE, VIDEO_URL, VIDEO_PHOTO, CATEGORY_CODE, CHANNEL_CODE, MEMBER_ID) 
VALUES(SEQ_VIDEO.NEXTVAL,'롯데 자이언츠','URL02','PHOTO02',5,22,'111');
COMMIT;

SELECT * FROM VIDEO;

-- 비디오 수정(updateVideo)
UPDATE VIDEO SET VIDEO_TITLE = '강남에서 만화까페'WHERE VIDEO_CODE =8;

-- 비디오 삭제(deleteVideo)
DELETE FROM VIDEO WHERE VIDEO_CODE=8;

COMMIT;

-- 비디오 전체 목록보기(videoAllList)
--비디오 코드(VIDEO_CODE), 비디오 썸네일(VIDEO_PHOTO), 비디오 제목(VIDEO_TITLE), 채널 프로필 사진(CHANNEL_PHOTO), 채널 제목(CHANNEL_NAME), 조회수(VIDEO_VIEWS), 비디오 업데이트 날짜(VIDEO_DATE)
SELECT VIDEO_CODE, VIDEO_PHOTO, VIDEO_TITLE, CHANNEL_PHOTO, CHANNEL_NAME, VIDEO_VIEWS, VIDEO_DATE FROM VIDEO JOIN CHANNEL USING(CHANNEL_CODE);

--채널별 목록 보기(channelVideoList) - 내 채널에 있는 비디오 목록 보기
SELECT VIDEO_CODE, VIDEO_PHOTO, VIDEO_TITLE, CHANNEL_PHOTO, CHANNEL_NAME, VIDEO_VIEWS, VIDEO_DATE, CHANNEL_CODE FROM VIDEO JOIN CHANNEL USING(CHANNEL_CODE) WHERE CHANNEL_CODE= 22;

-- 비디오 1개 보기(viewVideo) : VIDEO_CODE / VIDEO_TITLE / VIDEO_DATE / VIDEO_VIEWS / VIDEO_URL / CHANNEL_NAME / CHANNEL_PHOTO / CHANNEL_CODE
SELECT VIDEO_CODE, VIDEO_TITLE, VIDEO_DATE, VIDEO_VIEWS, VIDEO_URL, CHANNEL_NAME, CHANNEL_PHOTO, CHANNEL_CODE FROM VIDEO JOIN CHANNEL USING(CHANNEL_CODE) WHERE VIDEO_CODE=23;


-- 카테고리 보기
SELECT * FROM CATEGORY;

---------------------------------------------------------------------------------
-- 댓글 추가 (addComment)

SELECT * FROM VIDEO;

INSERT INTO VIDEO_COMMENT(COMMENT_CODE, COMMENT_DESC, VIDEO_CODE, MEMBER_ID) VALUES(SEQ_VIDEO_COMMENT.NEXTVAL, '좋아요~~', 23, '111'); 
COMMIT;
SELECT * FROM VIDEO_COMMENT;

-- 비디오 1개 보기에 따른 댓글들 보기 (videoCommentList)
SELECT COMMENT_CODE, MEMBER_NICKNAME, COMMENT_DESC FROM VIDEO_COMMENT JOIN MEMBER USING(MEMBER_ID) WHERE VIDEO_CODE=23;

--> 좋아요 포함하려고 해서 변경!
SELECT C.COMM_LIKE_CODE, V.COMMENT_CODE, V.COMMENT_DESC, M.MEMBER_NICKNAME FROM COMMENT_LIKE C
JOIN VIDEO_COMMENT V ON (C.COMMENT_CODE = V.COMMENT_CODE)
JOIN MEMBER M ON (V.MEMBER_ID = V.MEMBER_ID) WHERE V.VIDEO_CODE=23;

-- 댓글 수정 (updateComment)
UPDATE VIDEO_COMMENT SET COMMENT_DESC='싫진 않아요' WHERE COMMENT_CODE=1;
COMMIT;
SELECT * FROM VIDEO_COMMENT;

-- 댓글 삭제 (deleteComment)
DELETE FROM VIDEO_COMMENT WHERE COMMENT_CODE=1;
COMMIT;
SELECT * FROM VIDEO_COMMENT;

-- 댓글 좋아요 추가 (addCommentLike)
INSERT INTO COMMENT_LIKE(COMM_LIKE_CODE, COMMENT_CODE, MEMBER_ID) VALUES(SEQ_COMMENT_LIKE.NEXTVAL, 3, '111');
COMMIT;
SELECT * FROM COMMENT_LIKE JOIN VIDEO_COMMENT USING(COMMENT_CODE);

-- 댓글 좋아요 취소 (deleteCommentLike)
DELETE FROM COMMENT_LIKE WHERE COMM_LIKE_CODE=1;
COMMIT;
SELECT * FROM COMMENT_LIKE;

-- 좋아요 추가 (addLike)
INSERT INTO VIDEO_LIKE(V_LIKE_CODE, VIDEO_CODE, MEMBER_ID) VALUES(SEQ_VIDEO_LIKE.NEXTVAL, 3, '111');
COMMIT;
SELECT * FROM VIDEO_LIKE;

-- 좋아요 취소 (deleteLike)
DELETE FROM VIDEO_LIKE WHERE VIDEO_CODE=3 AND MEMBER_ID='111';
COMMIT;
SELECT * FROM VIDEO_LIKE;

-- 구독 추가(addSubscribe)
INSERT INTO SUBSCRIBE(SUBS_CODE, CHANNEL_CODE, MEMBER_ID) VALUES(SEQ_SUBSCRIBE.NEXTVAL, 22, '111');
COMMIT;
SELECT * FROM SUBSCRIBE;

-- 내가 구독한 채널 목록 보기(mySubscribeList)
SELECT C.CHANNEL_CODE, C.CHANNEL_NAME, C.CHANNEL_PHOTO 
FROM SUBSCRIBE S
JOIN CHANNEL C ON(S.CHANNEL_CODE = C.CHANNEL_CODE) 
WHERE S.MEMBER_ID='111';

-- 구독 취소(deleteSubscribe)
DELETE FROM SUBSCRIBE WHERE CHANNEL_CODE=1 AND MEMBER_ID='111';
COMMIT;
SELECT * FROM SUBSCRIBE;


SELECT CHANNEL_CODE, CHANNEL_NAME, MEMBER_NICKNAME 
FROM CHANNEL JOIN MEMBER USING(MEMBER_ID) 
WHERE MEMBER_ID='111';








