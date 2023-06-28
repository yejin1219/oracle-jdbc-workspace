--1. 
SELECT STUDENT_NO, STUDENT_NAME, ENTRANCE_DATE
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY 3;

--2.
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) !=3
ORDER BY 1;

--3.
SELECT PROFESSOR_NAME , (100-  SUBSTR(PROFESSOR_SSN,1,2)) + 23 AS "나이"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1) = 1
ORDER BY 2;
-- extra, SUBSTR이용 (생일 상관없이 할려면) 
--4. 
SELECT SUBSTR(PROFESSOR_NAME,2) "이름"
FROM TB_PROFESSOR
ORDER BY "이름";

--5.
SELECT SUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE ;


 

--6. 

--7. 
--TO_DATE(‘99/10/11’, ‘YY/MM/DD’), TO_DATE(‘49/10/11’, ‘YY/MM/DD’) 은 각각 몇 년 몇 월 몇
--일을 의미할까? 또 TO_DATE(‘99/10/11’, ‘RR/MM/DD’), TO_DATE(‘49/10/11’, ‘RR/MM/DD’)은 각각
--몇 년 몇 월 몇 일을 의미할까



--8. 춘 기술대학교의 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다. 2000년도 이전 학
--번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.



--9.
SELECT ROUND(AVG(POINT),1) "평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

--10.
SELECT DEPARTMENT_NO "학과번호", COUNT(DEPARTMENT_NO) "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--11.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12.학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 단, 이때 출
--력 화면의 헤더는 “년도”, “년도 별 평점” 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한
--자리까지만 표시한다.
SELECT SUBSTR(TERM_NO,1,4) "년도", ROUND(AVG(POINT),1) "년도 별 평점"
FROM TB_GRADE 
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 1;

--13.학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을 작성하시오
SELECT  DEPARTMENT_NO "학과코드 명", COUNT(ABSENCE_YN) "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO, ABSENCE_YN
HAVING ABSENCE_YN = 'Y'
ORDER BY 1;

--14.춘 대학교에 다니는 동명이인 학생들의 이름을 찾고자 한다. 어떤 SQL 문장을 사용하면 가능
--하겠는가 -- 풀기
SELECT STUDENT_NAME "동명이인", COUNT(STUDENT_NAME) "동명인 수"
FROM TB_STUDENT;

--15.학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점, 총 평점을 구하
--  는 SQL 문을 작성하시오. (단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.
SELECT SUBSTR(TERM_NO,1,4) "년도", SUBSTR(TERM_NO,5,2) "학기", ROUND(AVG(POINT),1) "학기 별 평점"
FROM TB_GRADE 
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP (SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2)); 




