
SELECT * FROM TB_DEPARTMENT;

-- 1번
-- 춘 기술대학교의 학과 이름과 계열을 조회하시오.
-- 단, 출력 헤더(컬럼명)는 "학과 명", "계열"으로 표시하도록 한다.
-- TB_DEPARTMENT

SELECT DEPARTMENT_NAME "학과 명", CATEGORY 계열
FROM TB_DEPARTMENT; 


-- 2 번
-- 학과의 학과 정원을 다음과 같은 형태로 조회하시오.
SELECT DEPARTMENT_NAME || '의 정원은 ' || CAPACITY || '명 입니다.' AS "학과별 정원" 
FROM TB_DEPARTMENT;


-- 3번
-- "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 조회하시오.
-- (국문학과의 학과코드(DEPARTMENT_NO)는 001)
SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001'
AND ABSENCE_YN = 'Y'; 


-- 4번
-- 도서관에서 대출 도서 장기 연체자들을 찾아 이름을 게시하고자 한다.
-- 그 대상자들의 학번이 다음과 같을 때 대상자들을 찾는 적절한 SQL구문을 작성하시오.
-- A513079, A513090, A513091, A513110, A513119
SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');


-- 5번
-- 입학 정원이 20명 이상 30명 이하인 학과들의 학과 이름과 계열을 조회하시오.
SELECT DEPARTMENT_NAME , CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30; 



-- 6번
-- 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다.
-- 그럼 춘 기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
SELECT PROFESSOR_NAME 
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;



-- 7번
-- 수강신청을 하려고 한다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는 과목들은
-- 어떤 과목인지 과목 번호를 조회하시오.
SELECT CLASS_NO 
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;



-- 8번
-- 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회해 보시오.
SELECT DISTINCT CATEGORY 
FROM  TB_DEPARTMENT;


-- 9번
-- 02학번 전주 거주자들의 모임을 만들려고 한다. 휴학한 사람들은 제외한 재학중인 학생들의
-- 학번, 이름, 주민번호를 조회하는 구문을 작성하시오
SELECT STUDENT_NO , STUDENT_NAME, STUDENT_SSN 
FROM TB_STUDENT
WHERE ABSENCE_YN = 'N'
AND STUDENT_ADDRESS LIKE '%전주%'
AND STUDENT_NO LIKE '_21%'; 


--------------------------------------------------------------------------------------------------------------

-- 1번
-- 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를
-- 입학 년도가 빠른 순으로 표시하는 SQL을 작성하시오.
-- (단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
SELECT STUDENT_NO , STUDENT_NAME, ENTRANCE_DATE 
FROM TB_STUDENT 
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE ASC;


-- 2번
-- 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 두 명 있다고 한다.
-- 그 교수의 이름과 주민번호를 조회하는 SQL을 작성하시오
SELECT PROFESSOR_NAME, PROFESSOR_SSN 
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';


-- 3번
-- 춘 기술대학교의 남자 교수들의 이름과 나이를 나이 오름차순으로 조회하시오.
-- (단, 교수 중 2000년 이후 출생자는 없으며 출력 헤더는 "교수이름"으로 한다.
-- 나이는 '만'으로 계산한다.)
SELECT PROFESSOR_NAME 교수이름,
	FLOOR(
		MONTHS_BETWEEN(
			SYSDATE ,TO_DATE('19' || SUBSTR(PROFESSOR_SSN, 1, 6), 'YYYYMMDD')
		) / 12) AS "나이"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY PROFESSOR_SSN DESC;



-- 4번
-- 교수들의 이름 중 성을 제외한 이름만 조회하시오. 출력 헤더는 "이름"이 찍히도록 한다.
-- (성이 2자인 경우의 교수는 없다고 가정)
SELECT SUBSTR(PROFESSOR_NAME, 2, LENGTH(PROFESSOR_NAME) -1) AS 이름
FROM TB_PROFESSOR;



-- 5번
-- 춘 기술대학교의 재수생 입학자를 조회하시오.
-- (19살에 입학하면 재수를 하지 않은 것!)
--> 입학 년도 - 태어날 년도 == 나이
SELECT STUDENT_NO , STUDENT_NAME
--	, CEIL(
--		MONTHS_BETWEEN(ENTRANCE_DATE, TO_DATE('19' || SUBSTR(STUDENT_SSN, 1, 6), 'YYYYMMDD')) / 12
--	)
FROM TB_STUDENT
WHERE 
	CEIL(
		MONTHS_BETWEEN(ENTRANCE_DATE, TO_DATE('19' || SUBSTR(STUDENT_SSN, 1, 6), 'YYYYMMDD')) / 12
	) != 19;


-- 6번
-- 춘 기술대학교의 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다.
-- 2000년도 이전 학번을 받은 학생들의 학번과 이름 조회하는 SQL을 작성하시오
SELECT SUBSTR(STUDENT_NO, 1, LENGTH(STUDENT_NO)) , STUDENT_NAME 
FROM TB_STUDENT 
WHERE SUBSTR(STUDENT_NO, 1, 1) != 'A';


-- 7번
-- 학번이 A517178인 한아름 학생의 학점 총 평점을 구하는 SQL문을 작성하시오.
-- 단, 이때 출력 화면의 헤더는 "평점"이라고 찍히게 하고,
-- 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT ROUND(AVG(POINT),1) 
FROM TB_STUDENT
JOIN TB_GRADE ON(TB_STUDENT.STUDENT_NO = TB_GRADE.STUDENT_NO)
WHERE TB_STUDENT.STUDENT_NO = 'A517178';

-- 8번
-- 학과별 학생 수를 구하여 "학과번호", "학생수(명)"의 형태로 조회하시오.
SELECT DEPARTMENT_NO AS 학과번호, COUNT(*) AS "학생수(명)"
FROM TB_STUDENT 
GROUP BY DEPARTMENT_NO 
ORDER BY DEPARTMENT_NO;


-- 9번
-- 지도 교수를 배정받지 못한 학생의 수를 조회하시오
SELECT COUNT(*)
FROM TB_STUDENT 
WHERE COACH_PROFESSOR_NO IS NULL;




-- 10번
-- 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL문을 작성하시오.
-- 단, 이때 출력화면의 헤더는 "년도", "년도 별 평점"이라고 찍히게 하고,
-- 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT SUBSTR(TERM_NO, 1, 4) AS 년도, ROUND(AVG(POINT),1) AS "년도 별 평점"
FROM TB_STUDENT
JOIN TB_GRADE ON(TB_STUDENT.STUDENT_NO = TB_GRADE.STUDENT_NO)
WHERE TB_STUDENT.STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY SUBSTR(TERM_NO, 1, 4);



-- 11번
-- 학과 별 휴학생 수를 파악하고자 한다.
-- 학과 번호와 휴학생 수를 조회하는 SQL을 작성하시오.
SELECT 
	DEPARTMENT_NO, 
--		COUNT(DECODE(ABSENCE_YN, 'Y', '휴학생')) AS "휴학생 수"
		SUM(DECODE(ABSENCE_YN, 'Y', 1, 'N', 0)) AS "휴학생 수"
FROM 
	TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;


-- 12번
-- 춘 대학교에 다니는 동명이인인 학생들의 이름, 동명인 수를 조회하시오.
SELECT 
	STUDENT_NAME , COUNT(*)
FROM
	TB_STUDENT MAIN
GROUP BY STUDENT_NAME 
HAVING COUNT(*) > 1
ORDER BY STUDENT_NAME ;
	
	
-- 13번
-- 학번이 A112113인 김고운 학생의 학점을 조회하려고 한다.
-- 년도, 학기 별 평점과 년도 별 누적 평점, 총 평점을 구하는 SQL을 작성하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
SELECT 
	NVL(SUBSTR(TERM_NO, 1, 4), ' ') AS "년도",
	NVL(SUBSTR(TERM_NO, 5), ' ') AS "학기",
	ROUND(AVG(POINT), 1) AS "평점"
FROM 
	TB_GRADE 
WHERE 
	STUDENT_NO = 'A112113'
GROUP BY
	ROLLUP(SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5))
ORDER BY
	SUBSTR(TERM_NO, 1, 4) ASC;

-----------------------------------------------------------------------------------------------------

-- 1번
-- 학생이름과 주소지를 조회하시오
-- 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 정렬
SELECT STUDENT_NAME AS "학생 이름" , STUDENT_ADDRESS AS "주소지" 
FROM TB_STUDENT 
ORDER BY STUDENT_NAME ASC;




-- 2번
-- 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서 조회하시오
SELECT STUDENT_NAME , STUDENT_SSN 
FROM TB_STUDENT 
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;


-- 3번
-- 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의
-- 이름과 학번, 주소를 이름 오름차순으로 조회하시오.
-- 단, 출력헤더에는 "학생이름", "학번", "거주지 주소"가 출력되도록 한다
SELECT STUDENT_NAME "학생이름", STUDENT_NO 학번, STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT 
WHERE 
	STUDENT_ADDRESS LIKE '%강원도%'
OR STUDENT_ADDRESS LIKE '%경기도%'
AND STUDENT_NO NOT LIKE 'A%'
ORDER BY STUDENT_NAME;


-- 4번
-- 현재 법학과 교수의 이름, 주민등록 번호를 나이가 많은 순서부터 조회하시오.
SELECT P.PROFESSOR_NAME , P.PROFESSOR_SSN 
FROM TB_PROFESSOR P
JOIN TB_DEPARTMENT T ON (P.DEPARTMENT_NO = T.DEPARTMENT_NO)
WHERE T.DEPARTMENT_NAME = '법학과'
ORDER BY PROFESSOR_SSN ASC;



-- 5번
-- 2004년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다.
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 조회하시오.
-- (참고) 소수점 아래 2자리까지 0으로 표현 : TO_CHAR(NUMBER, 'FM9.00')
-- (FM : 조회 결과 양쪽 공백 제거)
SELECT S.STUDENT_NO , G.POINT 학점
FROM TB_STUDENT S
JOIN TB_GRADE G ON (S.STUDENT_NO = G.STUDENT_NO)
WHERE G.CLASS_NO = 'C3118100'
AND TERM_NO = '200402'
ORDER BY POINT DESC, STUDENT_NO ASC;



-- 6번
-- 학생 번호, 학생 이름, 학과 이름을 학생 이름 오름차순으로 조회하시오.
SELECT S.STUDENT_NO "학생 번호", S.STUDENT_NAME "학생 이름", D.DEPARTMENT_NAME 
FROM TB_STUDENT S
JOIN 
	TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
ORDER BY S.STUDENT_NAME;




-- 7번
-- 춘 기술대학교의 과목 이름, 해당 과목을 수업하는 학과 이름을 조회하시오.
SELECT C.CLASS_NAME, D.DEPARTMENT_NAME
FROM TB_CLASS C
JOIN TB_DEPARTMENT D ON (C.DEPARTMENT_NO = D.DEPARTMENT_NO);



-- 8번
-- 과목, 해당 과목 교수 이름을 조회하시오
SELECT CLASS_NAME , P.PROFESSOR_NAME 
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR CP ON (C.CLASS_NO = CP.CLASS_NO)
JOIN TB_PROFESSOR P ON (CP.PROFESSOR_NO = P.PROFESSOR_NO);




-- 9번
-- 8번의 결과 중 '인문 사회' 계열에 속한
-- 과목명, 교수이름을 과목명 오름차순으로 조회하시오.
SELECT CLASS_NAME , P.PROFESSOR_NAME 
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR CP ON (C.CLASS_NO = CP.CLASS_NO)
JOIN TB_PROFESSOR P ON (CP.PROFESSOR_NO = P.PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE D.CATEGORY = '인문사회'
ORDER BY CLASS_NAME;





-- 10번
-- 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 조회하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
SELECT S.STUDENT_NO , S.STUDENT_NAME ,TRUNC(AVG(G.POINT) , 1)
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
JOIN TB_GRADE G ON (G.STUDENT_NO = S.STUDENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME
ORDER BY S.STUDENT_NO;




-- 11 번
-- 학번이 A313047인 학생의 학과이름, 학생이름, 지도교수 이름을 조회하시오.
SELECT D.DEPARTMENT_NAME , S.STUDENT_NAME , P.PROFESSOR_NAME 
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR P ON (P.PROFESSOR_NO = S.COACH_PROFESSOR_NO)
WHERE S.STUDENT_NO = 'A313047';




-- 12번
-- 2007년도에 '인간관계론' 과목을 수강한 학생을 찾아
-- 학생이름과 수강학기를 조회하는 SQL을 작성하시오
SELECT S.STUDENT_NAME , G.TERM_NO 
FROM TB_STUDENT S
JOIN TB_GRADE G ON (S.STUDENT_NO = G.STUDENT_NO)
JOIN TB_CLASS C ON (C.CLASS_NO = G.CLASS_NO)
WHERE G.TERM_NO LIKE '2007%'
AND C.CLASS_NAME = '인간관계론';



-- 13번
-- 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아
-- 과목 이름, 학과 이름을 조회하시오.
SELECT C.CLASS_NAME , D.DEPARTMENT_NAME 
FROM TB_CLASS C
JOIN TB_DEPARTMENT D ON (D.DEPARTMENT_NO = C.DEPARTMENT_NO)
LEFT JOIN TB_CLASS_PROFESSOR CP ON (C.CLASS_NO = CP.CLASS_NO)
WHERE D.CATEGORY = '예체능'
AND CP.PROFESSOR_NO IS NULL;




-- 14 번
-- 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다.
-- 학생이름, 지도교수이름 학번이 높은 순서로 조회하는 SQL을 작성하시오.
-- 단, 지도교수가 없을 경우 "지도교수 미지정"으로 표시
SELECT S.STUDENT_NAME , NVL(P.PROFESSOR_NAME, '지도교수 미지정')
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
LEFT JOIN TB_PROFESSOR P ON (S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE D.DEPARTMENT_NAME = '서반아어학과'
ORDER BY S.STUDENT_NO ASC;







-- 15번
-- 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아
-- 학생의 학번, 이름, 학과, 이름, 평점을 조회하시오.
SELECT S.STUDENT_NO 학번, S.STUDENT_NAME 이름, D.DEPARTMENT_NAME "학과 이름", AVG(POINT) 평점
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON (D.DEPARTMENT_NO = S.DEPARTMENT_NO)
JOIN TB_GRADE G ON (S.STUDENT_NO = G.STUDENT_NO)
WHERE S.STUDENT_NO IN (
	SELECT 
		CASE 
			WHEN 
				AVG(POINT) >= 4
			THEN
				S2.STUDENT_NO
		END
	FROM TB_STUDENT S2
	JOIN TB_GRADE G2 ON (S2.STUDENT_NO = G2.STUDENT_NO)
	WHERE S2.ABSENCE_YN != 'Y' 
	GROUP BY S2.STUDENT_NO
)
GROUP BY S.STUDENT_NO , S.STUDENT_NAME , D.DEPARTMENT_NAME
ORDER BY S.STUDENT_NO;



	



-- 16번
-- 환경조경학과 전공과목들의 과목 별 평점을 조회하시오.
-- (평점은 TRUNC를 이용해 소수점 아래 둘째 자리까지 표시)
SELECT C.CLASS_NO, C.CLASS_NAME, TRUNC(AVG(POINT), 2)
FROM TB_DEPARTMENT D 
JOIN TB_CLASS C ON (D.DEPARTMENT_NO = C.DEPARTMENT_NO)
JOIN TB_GRADE G ON (C.CLASS_NO = G.CLASS_NO)
WHERE C.CLASS_TYPE = '전공선택'
AND D.DEPARTMENT_NAME = '환경조경학과'
GROUP BY C.CLASS_NO, C.CLASS_NAME
ORDER BY C.CLASS_NO ;




-- 17번
-- 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 조회하시오.
SELECT STUDENT_NAME , STUDENT_ADDRESS 
FROM TB_STUDENT 
WHERE DEPARTMENT_NO = (
	SELECT DEPARTMENT_NO 
	FROM TB_STUDENT 
	WHERE STUDENT_NAME = '최경희'
);



-- 18 번
-- 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 조회하시오
SELECT *
FROM TB_STUDENT S
JOIN TB_GRADE G ON (S.STUDENT_NO = G.STUDENT_NO)
WHERE (S.STUDENT_NO, AVG(G.POINT)) IN (
	SELECT S2.STUDENT_NO, MAX(AVG(G2.POINT))
	FROM TB_STUDENT S2
	JOIN TB_DEPARTMENT D2 ON (S2.DEPARTMENT_NO = D2.DEPARTMENT_NO)
	JOIN TB_GRADE G2 ON (S2.STUDENT_NO = G2.STUDENT_NO)
	WHERE D2.DEPARTMENT_NAME = '국어국문학과'
	GROUP BY S2.STUDENT_NO
);

SELECT STUDENT_NAME, STUDENT_NO
FROM (
	SELECT RANK() OVER (ORDER BY AVG(G2.POINT) DESC) AS "평점", S2.STUDENT_NO, S2.STUDENT_NAME 
	FROM TB_STUDENT S2
	JOIN TB_DEPARTMENT D2 ON (S2.DEPARTMENT_NO = D2.DEPARTMENT_NO)
	JOIN TB_GRADE G2 ON (S2.STUDENT_NO = G2.STUDENT_NO)
	WHERE D2.DEPARTMENT_NAME = '국어국문학과'
	GROUP BY S2.STUDENT_NO, S2.STUDENT_NAME
)
WHERE 평점 = 1;

-- 19번
-- 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의
-- 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL문을 작성하시오
-- 단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고,
-- 평점은 소수점 첫째자리까지만 반올림하여 표시


SELECT D.DEPARTMENT_NAME, ROUND(AVG(G.POINT), 1) 
FROM TB_DEPARTMENT D
JOIN TB_CLASS C ON (D.DEPARTMENT_NO = C.DEPARTMENT_NO)
JOIN TB_GRADE G ON (G.CLASS_NO = C.CLASS_NO)
WHERE D.CATEGORY = (
	SELECT DISTINCT D2.CATEGORY 
	FROM TB_STUDENT S2
	JOIN TB_DEPARTMENT D2 ON (S2.DEPARTMENT_NO = D2.DEPARTMENT_NO)
	JOIN TB_GRADE G2 ON (S2.STUDENT_NO = G2.STUDENT_NO)
	JOIN TB_CLASS C2 ON (C2.CLASS_NO = G2.CLASS_NO)
	WHERE D2.DEPARTMENT_NAME = '환경조경학과'
)
GROUP BY D.DEPARTMENT_NAME
ORDER BY D.DEPARTMENT_NAME;


















