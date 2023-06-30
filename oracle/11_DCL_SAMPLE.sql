 --3. SAMPLE 계정에서 테이블을 생성할 수 있는 CREATE TABLE 권한 부여
 CREATE TABLE TEST(
    TID NUMBER );

SELECT * FROM TEST;

--4. TABLESPACE(테이블, 뷰, 인덱스 등 객체들이 저장되는 공간)에 대한 권한 부여 후 생성
INSERT INTO TEST VALUES(1);

--5. KH.EMPLOYEE 테이블을 조회할 수 있는 권한 부여 후
SELECT * FROM KH.EMPLOYEE;--(KH계정에 있는 EMPLOYEE 객체에 접근하고 싶을 때)

--6. KH.DEPARTMENT 테이블에 데이터를 삽입할 수 있는 권한 부여 후(삽입만 가능 이때, 조회는 불가능)
INSERT INTO KH.DEPARTMENT(DEPT_ID, DEPT_TITLE, LOCATION_ID)
VALUES('D0','개발부','L1');

--7. KH.DEPARTMENT 테이블을 조회할 수 있는 권한 부여 후 조회 가능 
SELECT * FROM KH.DEPARTMENT; 