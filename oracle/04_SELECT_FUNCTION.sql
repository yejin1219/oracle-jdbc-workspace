/*
 함수 : 전달된 컬럼값을 읽어들여서 함수를 실행한 결과를 반환
    - 단일행 함수 : N개의 값을 읽어서 N개의 결과값을 리턴(매 행마다 함수 실행 결과 반환)
    - 그룹 함수 : N개의 값을 읽어서 1개의 결과값을 리턴(그룹별로 함수 실행 결과 반환)
    >> SELECT 절에 단일행 함수와 그룹 함수는 함께 사용하지 못함!
      왜? 결과 행의 갯수가 다르기 때문에!
    
    >> 함수식을 기술할 수 있는 위치 : SELECT, WHERE, ORDER BY, GRUD BY, HAVING
    
*/

-- 단일행 함수 ---------------------------------------------------------------
/*
 문자 처리 함수
 
 LENGTH / LENGTHB
 - LENGTH(컬럼|'문자열 값') : 해당 값의 글자 수 반환 // | :또는 
 - LENGTHB(컬럼|'문자열 값') : 해당 값의 바이트 수 반환
 
 한글 한 글자 -> 3BYTE
 영문자, 숫자, 특수문자 한 글자 -> 1BYTE
*/

SELECT LENGTH('오라클'),LENGTHB('오라클'),LENGTH('ORACLE'), LENGTHB('ORACLE')
FROM DUAL; -- 가상 테이블 (오라클에서 제공하는 )

-- 사원명, 사원명의 글자수, 사원명의 바이트 수, 이메일, 이메일의 글자 수, 이메일의 바이트 수 조회
SELECT EMP_NAME,LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL,LENGTH(EMAIL),LENGTHB(EMAIL)
FROM EMPLOYEE;

/*
 INSTR 
 - INSTR(STRING, STR [, POSITION, OCCURRENCE])
 - 지정한 위치부터 지정된 숫자 번째로 나타나는 문자의 시작 위치를 반환
 
 설명
 - STRING : 문자 타입 컬럼 또는 문자열
 - STR : 찾으려는 문자열
 - POSITION : 찾을 위치의 시작 값(생략 하면 기본값 1(앞에서부터 찾음))
    1 : 앞에서부터 찾는다. 
    -1 : 뒤에서부터 찾는다.
 - OCCURRENCE : 찾을 문자값이 반복될 때 지정하는 빈도(명시하지 않을 시 기본값 1_),
                음수 사용 불가
*/
SELECT INSTR('AABAACAABBAA','B') FROM DUAL; --B가 문자열에 몇번째 위치해 있는지
SELECT INSTR('AABAACAABBAA','B',-1) FROM DUAL; -- -1을넣으면 뒤에서부터 찾음 
SELECT INSTR('AABAACAABBAA','B',1,2) FROM DUAL; --앞에서부터 2번째 위치해 있는B를 찾음


-- 'S'가 포함되어 있는 이메일 중 이메일, 이메일의 @위치,
-- 이메일에서 뒤에서 2번째 있는 'S'위치 조회
SELECT EMAIL,INSTR(EMAIL,'@'),INSTR(EMAIL,'S',-1,2)
FROM EMPLOYEE
WHERE EMAIL LIKE '%s%';

/*
 LPAD / RPAD
 - 문자열을 조회할 때 통일감있게 조회하고자 할 때 사용
 - LPAD / RPAD(STRING, 최종적으로반환할 문자의 길이, [덧붙이고자하는 문자])
 - 문자열에 덧붙이고자하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열을 반환
*/
SELECT LPAD('HELLO', 10) FROM DUAL; --덧붙이고자하는 문자 생략시 공백으로 채운다.
SELECT LPAD('HELLO', 10,'A') FROM DUAL; -- 공백은 A문자로 채움
SELECT RPAD('HELLO', 10) FROM DUAL;
SELECT RPAD('HELLO', 10,'*') FROM DUAL;

/*
 LTRIM / RTRIM
 - 문자열에서 특정 문자를 제거한 나머지를 반환
 - LTRIM / RTRIM(STRING, [제거하고자하는문자들])
 - 문자열의 왼쪽 또는 오른쪽에서 제거하고자하는문자들을 찾아서 제거한 나머지 문자열을 반환
*/
--제거하고자하는문자 생략 시 기본값으로 공백 제거 
SELECT LTRIM('    K H     ') FROM DUAL; --기본값으로 왼쪽 공백들 제거 
SELECT LTRIM('ACABACCKH', 'ABC')FROM DUAL;
SELECT RTRIM('5782KH123', '0123456789')FROM DUAL; --오른쪽에서 123제거됨

/*
 TRIM
 - 문자열의 양쪽(앞 / 뒤)에 있는 지정한 문자들을 제거한 나머지 문자열 반환
 - TRIM([LEADING|TRAILING|BOTH] 제거하고자하는문자들 REOM STRING)
*/
SELECT TRIM('        K H      ')FROM DUAL; --제거하고자 하는 문자 지정안했을 때 기본값으로 양쪽 공백 제거
SELECT TRIM('Z' FROM 'ZZZKHZZZ')FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')FROM DUAL;-- LEADING 쓰면 LTRIM이랑 같은 역할(왼쪽 Z 제거)
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')FROM DUAL;--TRAILING쓰면 RTRIM이랑 같은 역할
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ')FROM DUAL; -- 기본값이랑 똑같음 (양쪽 으로 Z 제거)

/*
 SUBSTR
 - 문자열에서 특정 문자열을 추출해서 반환
 - SUBSTR(STRING, POSITION, [LENGTH])
   STRING : 문자타입컬럼 또는 '문자열값'
   POSITION :  문자열을 추출할 시작위치값(음수값도 가능)
   LENGEH : 추출할 문자 개수 (생략시 끝까지)
*/
SELECT SUBSTR('PROGRAMMING',5,2) FROM DUAL; -- 5번째부터 2개 추출
SELECT SUBSTR('PROGRAMMING',-8,3) FROM DUAL; -- 뒤에서 8번째부터 3개 추출

-- 여자사원들의 이름만 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN(2,4);

-- 남자사원들의 이름만 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN(1,3);

-- 사원명과 주민등록번호(991212-1******)조회
SELECT EMP_NAME, RPAD( SUBSTR (EMP_NO,1,8 ),14,'*')
FROM EMPLOYEE;

-- 직원명, 이메일, 아이디(이메일에서 '@'앞의 문자) 조회 
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)AS "아이디"
FROM EMPLOYEE;

/*
 LOWER / UPPER / INITCAP
 - LOWER/UPPER/INITCAP(STRING)
 LOWER : 다 소문자로 변경한 문자열 반환
 UPPER : 다 대문자로 변경한 문자열 반환
 INITCAP : 단어 앞글자마다 대문자로 변경한 문자열 반환
*/
SELECT LOWER('Welcome To My World!')FROM DUAL;
SELECT UPPER('Welcome To My World!')FROM DUAL;
SELECT INITCAP('welcome to my world!')FROM DUAL;

/*
  CONCAT
  - 문자열 두개 전달받아 하나로 합친 후 결과 반환
  - CONCAT(STRING, STRING)
*/
SELECT CONCAT('가나다라', 'ABCD') FROM DUAL; --연결연산자와 동일!
SELECT '가나다라'||'ABCD' FROM DUAL; 

SELECT '가나다라'||'ABCD'||'1234' FROM DUAL;
SELECT CONCAT('가나다라','ABCD','1234')FROM DUAL; -- 실행안됨(문자열 2개만 받을 수 잇음)
SELECT CONCAT(CONCAT('가나다라','ABCD'),'1234')FROM DUAL; -- CONCAT 2개 사용해야 함 

/*
 REPLACE
 - REPLACE(STRING,STR1,STR2)
   STRING : 컬럼 또는 문자열값
   STR1 : 변경시킬문자열
   STR2 : STR1을 변경할 문자열
*/

SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;

-- 이메일의 kh.or.kr를 gmail.com 으로 변경해서 조회
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL,'kh.or.kr','gmail.com')
FROM EMPLOYEE;

---↑여기까지 문자 처리하는 함수↑ --------------------------------------------------

---↓숫자 처리하는 함수↓ ----------------------------------------------------------

/*
 숫자 처리 함수
 ABS(NUMBER) : 숫자의 절대값을 구해주는 함수 
*/
SELECT ABS(-10) FROM DUAL;

/*
 MOD(NUMBER, NUMBER) : 두 수를 나눈 나머지값을 반환해주는 함수
*/
SELECT MOD(10,3) FROM DUAL;

/*
 ROUND(NUMBER, [위치]) : 반올림한 결과를 반환하는 함수
*/
SELECT ROUND(123.456) FROM DUAL; -- 위치 생략시 0(소수점을 다 생략)
SELECT ROUND(123.456, 1) FROM DUAL; --소수점 첫번째 자리까지 보여줌(두번째 자리에서 반올림)
SELECT ROUND(123.456,-2) FROM DUAL;-- 100

/*
 CEIL(NUMBER) : 올림처리해주는 함수
*/
SELECT CEIL(123.152)FROM DUAL; --124

/*
 FLOOR(NUMBER) : 소수점 아래 버림처리해주는 함수(소수점 지정못함)
*/
SELECT FLOOR(123.952) FROM DUAL; --123

/*
 TRUNC(NUMBER, [위치]) : 위치 지정 가능한 버림처리해주는 함수
*/
SELECT TRUNC(123.952)FROM DUAL; -- 위치 지정안하면 소수점 다 지워버림
SELECT TRUNC(123.952,1)FROM DUAL; --123.9
SELECT TRUNC(123.952,-1)FROM DUAL; --120


---↓날짜 처리하는 함수↓ ----------------------------------------------------------
/*
 날짜 처리하는 함수
 
 SYSDATE : 시스템의 날짜를 반환 (현재 날짜를 반환)
*/
SELECT SYSDATE FROM DUAL;

-- 날짜 포맷 변겅
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD'; -- 원래 포맷으로 변경

/*
 MONTHS_BETWEEN(DATE,DATE)
 - 입력받는 두 날짜 사이의 개월 수를 반환
*/
SELECT MONTHS_BETWEEN(SYSDATE, '20230521')FROM DUAL;
-- 1반환(컴퓨터에 따라 1반환 안될수도,,,,그러면 다른 방법써야함)

-- 직원명, 입사일, 근무 개월 수 조회
SELECT 
    EMP_NAME,HIRE_DATE,
    CEIL(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) AS "근무 개월 수"
FROM EMPLOYEE;

/*
 ADD_MONTHS(DATE,NUMBER)
 - 특정 날짜에 입력받는 숫자만큼의 개월 수를 더한 날짜를 반환
*/
SELECT ADD_MONTHS(SYSDATE,5)FROM DUAL;


--직원명, 입사일, 입사 후 6개월이 된 날짜를 조회
SELECT EMP_NAME, HIRE_DATE,ADD_MONTHS(HIRE_DATE,6)
FROM EMPLOYEE;

/*
 NEXT_DAY(DATE, 요일(문자|숫자))
 - 특정 날짜에서 구하려는 요일의 가장 가까운 날짜를 리턴
 - 요일 : 1 - 일요일, 2-월요일, ...,7-토요일
*/
SELECT SYSDATE, NEXT_DAY(SYSDATE, '월요일')FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금')FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 4)FROM DUAL;

-- 현재 언어가 KOREAN이기 때문에 에러!
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY')FROM DUAL;

-- 언어 변경
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- 언어변경 후 
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY')FROM DUAL; -- 다시 실행

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

/*
 LAST DAY(DATE)
 - 해당 월의 마지막 날짜를 반환
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('20230515')FROM DUAL;
SELECT LAST_DAY('23/11/01')FROM DUAL;

-- 직원명, 입사일, 입사월의 마지막 날짜, 입사한 월에 근무한 일수(주말포함) 조회
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE)- HIRE_DATE+1
FROM EMPLOYEE;

/*
 EXTRACT(YEAR|MONTH|DAY FROM DATE)
  - 특정 날짜에서 연도, 월, 일, 정보를 추출해서 반환
   YEAR : 연도만 추출
   MONTH : 월만 추출
   DAY : 일만 추출
*/


-- 직원명, 입사년도, 입사월, 입사일 조회
SELECT 
    EMP_NAME, 
    EXTRACT(YEAR FROM HIRE_DATE) "입사년도", 
    EXTRACT(MONTH FROM HIRE_DATE) "입사월",
    EXTRACT(DAY FROM HIRE_DATE) "입사일"
FROM EMPLOYEE
-- ORDER BT HIRE_DATE 로 한번에 정렬해도 되지만 ORDER BY 여러 개 쓸려면 ↓
-- ORDER BY EXTRACT(YEAR FROM HIRE_DATE), EXTRACT(MONTH FROM HIRE_DATE) ASC, EXTRACT(DAY FROM HIRE_DATE) ASC; -- 년, 월, 일 다 오름차순 정렬
ORDER BY 2, 3 ASC, 4 ASC; --(숫자로 지정해서 정렬)
-- 2 는 SELECT절에서 2번째 컬럼을 뜻함
-- 3 는 SELECT절에서 3번째 컬럼을 뜻함
-- 4 는 SELECT절에서 4번째 컬럼을 뜻함+

/*
  형 변환 함수
 
  TO_CHAR(날짜|숫자, [포맷])
   - 날짜 또는 숫자형 데이터를 문자 타입으로 변환해서 반환
*/
SELECT TO_CHAR(1234, 'L999999') FROM DUAL; --현재 설정된 나라의 화폐단위
SELECT TO_CHAR(1234,'$999999')FROM DUAL;
SELECT TO_CHAR(1234, 'L99') FROM DUAL; --포맷자리수가 안맞음!
SELECT TO_CHAR(1234, 'L999,999') FROM DUAL;

-- 직원명, 급여, 연봉(위의 TO_CHAR를 이용해서)조회
SELECT EMP_NAME,TO_CHAR( SALARY,'L999,999,999'), TO_CHAR(SALARY*12,'L999,999,999') "연봉"
FROM EMPLOYEE
ORDER BY "연봉";

-- 날짜 -> 문자
SELECT TO_CHAR(SYSDATE,'PM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH24:MI:SS')FROM DUAL;
-- DY,DAY : 요일 / DD : 일
SELECT TO_CHAR(SYSDATE, 'MON DY,YYYY ')FROM DUAL; -- 6월 수,2023
SELECT TO_CHAR(SYSDATE, 'MON DD,DY,YYYY ')FROM DUAL; -- 6월 21,수,2023


-- 년도와 관련된 포맷
SELECT 
  TO_CHAR(SYSDATE,'YYYY'), --2023
  TO_CHAR(SYSDATE,'YY'), --23
  TO_CHAR(SYSDATE,'RRRR'), --2023
  TO_CHAR(SYSDATE,'RR'), --23
  TO_CHAR(SYSDATE,'YEAR') -- TWENTY TWENTY-THREE
FROM DUAL;

-- 월과 관련된 포맷
SELECT
   TO_CHAR(SYSDATE, 'MM'), --06
   TO_CHAR(SYSDATE, 'MON'), --6월
   TO_CHAR(SYSDATE, 'MONTH'), --6월
   TO_CHAR(SYSDATE, 'RM')--VI (로마기호)
FROM DUAL;

-- 일과 관련된 포맷
SELECT
  TO_CHAR(SYSDATE, 'D'), --4 (주 기준)
  TO_CHAR(SYSDATE, 'DD'), --21 (월 기준)
  TO_CHAR(SYSDATE, 'DDD') --172 (년 기준)
FROM DUAL;

-- 요일과 관련된 포맷
SELECT
  TO_CHAR(SYSDATE, 'DAY'), --수요일
  TO_CHAR(SYSDATE, 'DY') -- 수
FROM DUAL;



-- 직원명, 입사일 조회
-- 단, 입사일은 포맷을 지정해서 조회! (2023년 06월 21일 (수))
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MON DD"일" (DY)')
FROM EMPLOYEE;

/*
 TO_DATE(숫자|문자, [포맷])
 - 숫자 또는 문자형 데이터를 날짜 타입으로 변환해서 반환
*/

--날짜 포맷 변경!
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

-- 숫자 --> 날짜
SELECT TO_DATE(20230621) FROM DUAL;
SELECT TO_DATE(20230621153410) FROM DUAL; --에러!
SELECT TO_DATE(20230621153410,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

-- 문자 --> 날짜
SELECT TO_DATE('20230621','YYYYMMDD')FROM DUAL;
SELECT TO_DATE('20230621 033823','YYYYMMDD HH24MISS')FROM DUAL;

/*
 TO_NUMBER('문자값', [포맷])
 - 문자형 데이터를 숫자 타입으로 변환해서 반환
*/
SELECT '1000000' + '550000' FROM DUAL;
SELECT '1,000,000' + '550,000' FROM DUAL; -- 에러 발생(수치가 부적합)
SELECT TO_NUMBER('1,000,000','9,999,999') + TO_NUMBER('550,000','999,999')
FROM DUAL;

/*

 NULL 처리 함수
 
 NVL(값1, 값2)
 - 값 1이 NULL이 아니면 값1을 반환하고 값1이 NULL이면 값2를 반환
*/
-- 사원명, 보너스 조회
SELECT EMP_NAME, NVL(BONUS,0)
FROM EMPLOYEE;

-- 사원명, 보너스포함연봉 = (월급 + 월급*보너스)*12조회
SELECT EMP_NAME, (SALARY + NVL(BONUS,0)*SALARY)*12 AS "보너스포함연봉"
FROM EMPLOYEE;

-- 사원명, 부서코드 조회(부서코드가 NULL이면 "부서없음")조회
SELECT EMP_NAME,NVL(DEPT_CODE,'부서없음')
FROM EMPLOYEE;

/*
 NVL2(값1, 값2, 값3)
 - 값1이 NULL이 아니면 값2를 반환하고 값1이 NULL이면 값3를 반환
*/

-- 사원명, 부서코드가 있는 경우 "부서있음", 없는 경우는 "부서없음" 조회 
SELECT EMP_NAME, NVL2(DEPT_CODE,'부서있음','부서없음')
FROM EMPLOYEE;

/*
 NULLIF(값1, 값2)
 - 두 개의 값이 동일하면 NULL을 반환하고, 두 개의 값이 동일하지 않으면 값1을 반환
*/
SELECT NULLIF('123','123') FROM DUAL;
SELECT NULLIF('123','456') FROM DUAL;

/*
  선택함수 : 여러 가지 경우에 선택을 할 수 있는 기능을 제공하는 함수
  
  DECODE(컬럼|산술연산|함수식, 조건값1, 결과값1, 조건값2, 결과값2,..., 결과값N)
  - 비교하고자 하는 값이 조건값과 일치할 경우 그에 해당하는 결과값을 반환해주는 함수
*/

-- 사번, 사원명, 주민번호, 성별(남,여) 조회
SELECT EMP_ID, EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO,8,1),1,'남',2,'여') "성별"
FROM EMPLOYEE;

-- 사원명, 직급코드, 기존 급여, 인상된 급여를 조회
-- 직급코드가 J7인 사원은 급여를 10% 인상
-- 직급코드가 J6인 사원은 급여를 15% 인상
-- 직급코드가 J5인 사원은 급여를 20% 인상
-- 그 외의 직급의 사원은 급여를 5%만 인상
-- 정렬 : 직급 코드 J1부터, 인상된 급여 높은 순서대로 

SELECT EMP_NAME,
       JOB_CODE, 
       SALARY, 
       DECODE(JOB_CODE,'J7',SALARY+SALARY*0.1,'J6',SALARY+SALARY*0.15,'J5',SALARY+SALARY*0.2,SALARY+SALARY*0.5) "인상된 급여"
FROM EMPLOYEE
ORDER BY 2, "인상된 급여" DESC;

/*
 CASE WHEN 조건식1 THEN 결과값1
      WHEN 조건식2 THEN 결과값2
      ...
      ELSE 결과값N
 END     
*/
-- 사번, 사원명, 주민번호, 성별(남자, 여자)조회
SELECT 
   EMP_ID,
   EMP_NAME,
   EMP_NO,
   CASE WHEN SUBSTR(EMP_NO,8,1) = 1 THEN '남자'
        WHEN SUBSTR(EMP_NO,8,1) = 2 THEN '여자'
        ELSE '잘못된 주민번호 입니다.'
       END AS "성별"
FROM EMPLOYEE;


--사원명, 급여, 급여 등급(1~4등급) 조회
-- 급여 값이 500만원 초과일 경우 1등급
-- 급여 값이 500만원 이하 350만원 초과일 경우 2등급
-- 급여 값이 350만원 이하 200만원 초과일 경우 3등급
-- 그 외의 경우 4등급

SELECT 
   EMP_NAME,
   SALARY,
   CASE WHEN SALARY > 5000000 THEN '1등급'
        WHEN SALARY > 3500000 THEN '2등급'
        WHEN SALARY > 2000000 THEN '3등급'
        ELSE '4등급'
        END AS "급여 등급"
FROM EMPLOYEE;

------그룹 함수----------------------------------------------------------------------

/*
 그룹 함수(결과값이 1개!!)
 - 대량의 데이터들로 집계나 통계 같은 작업을 처리해야 하는 경우 사용되는 함수들
 - 모든 그룹 함수는 NULL 값을 자동으로 제외하고 값이 있는 것들만 계산
 
 SUM(NUMBER)
 - 해당 컬럼 값들의 총 합계를 반환
*/
-- 전체 사원의 총 급여 합
SELECT TO_CHAR( SUM(SALARY), 'FM999,999,999') --FM 붙이면 앞에 공백 제거 
FROM EMPLOYEE;

-- 부서코드가 D5인 사원들의 총 연봉 합
SELECT TO_CHAR(SUM(SALARY*12),'FM999,999,999')
FROM EMPLOYEE
WHERE DEPT_CODE ='D5';


/*
 AVG(NUMBER)
 - 해당 컬럼값들의 평균값을 반환
 - 모든 그룹 함수는 NULL값을 제외 -> AVG 함수를 사용할 때 NVL 함수와 사용하는 것을 권장 
*/
-- 전체 사원의 평균 급여를 조회
SELECT TO_CHAR(ROUND(AVG(SALARY)),'FM999,999,999') "평균 급여"
FROM EMPLOYEE;

SELECT AVG(BONUS) FROM EMPLOYEE;
SELECT AVG(NVL(BONUS,0)) FROM EMPLOYEE;

/*
 MIN / MAX(모든타입의 컬럼)
 - MIN : 해당 컬럼 값들 중에 가장 작은 값을 반환
 - MAX : 해당 컬럼 값들 중에 가장 큰 값을 반환
*/

-- 가장 작은 값에 해당하는 사원명, 급여, 입사일
-- 가장 큰 값에 해당하는 사원명, 급여, 입사일 조회
SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE),
    MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;


/*  ** 그룹 함수 중 가장 많이 쓰임**
 COUNT(*|컬럼|DISTINCT 컬럼)
 - 컬럼 또는 행의 개수를 세서 반환
 
 COUNT(*) : 조회 결과에 해당하는 모든 행 개수를 반환
 COUNT(컬럼) : 해당 컬럼값이 NULL이 아닌 행의 개수를 반환
 COUNT(DISTINCT 컬럼) : 해당 컬럼값의 중복을 제거한 행의 개수를 반환
*/

-- 전체 사원 수
SELECT COUNT(*)
FROM EMPLOYEE;

-- 보너스를 받는 사원 수
SELECT COUNT(BONUS)
FROM EMPLOYEE;

-- 부서가 배치된 사원 수
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- 현재 사원들이 속해있는 부서 수
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

-- 현재 사원들이 속해있는 직급 수
SELECT COUNT(DISTINCT JOB_CODE)
FROM EMPLOYEE;

-- 퇴사한 직원 수
SELECT COUNT(ENT_DATE)
FROM EMPLOYEE;











