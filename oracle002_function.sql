/* =========================================================
SQL(structured query language)함수
1. 단일행함수 : 행 하나당 하나의 결과를 출력한다.
              (문자함수, 숫자함수, 날짜함수, 변환함수, 일반함수)
2. 복수행함수 : 행 여러개당 하나의 결과를 출력한다.
              (합계, 평균, 최대, 최소, 갯수)
============================================================
--SELECT문에서는 반드시 테이블명을 명시해야 한다.
--그래서 SELECT절에 식이나 특정함수를 이용해서 결과값을 가져올 때 
--사용할 수 있는 DUAL이라는 테이블을 제공하고 있다. */

SELECT 3+1
FROM dual;

SELECT sysdate
FROM dual;

/* --------------------------
문자함수
---------------------------*/
--단어의 첫글자만 대문자로 변경해주는 함수이다.
SELECT initcap('korea hello')
FROM dual;

--모든 문자를 대문자로 변경해주는 함수이다.
SELECT upper('korea') /*toUpperCase()*/
FROM dual;

SELECT first_name, upper(first_name),
    last_name, upper(last_name)
    FROM employees;
    
--모든 문자를 소문자로 변경해주는 함수이다.
SELECT lower('korea')
FROM dual;

SELECT first_name, lower(first_name), last_name, lower(last_name)
FROM employees;

--employees테이블 first_name에서 대소문자 구분없이 
--'Ja'가 포함이 된 first_name, salart을 출력하라.
SELECT first_name, salary
FROM employees
WHERE upper(first_name) LIKE upper ('%ja%');

--문자의 길이를 리턴해 주는 함수이다.
SELECT length('korea')
FROM dual;

SELECT lenght('한글')
FROM dual;

CREATE TABLE user1(
    data varchar2(5)
);

DESC user1;
SELECT * FROM user1;

INSERT INTO user1(data) 
VALUES('korea');

SELECT * FROM user1;

--ORA-12899: value too large for column "HR"."USER1"."DATA" (actual: 11, maximum: 5)
--최대 저장할 수 있는 갯수를 5라고 설정해놨으므로
INSERT INTO user1(data)
VALUES('south korea');

--ORA-12899: value too large for column "HR"."USER1"."DATA" (actual: 6, maximum: 5)
INSERT INTO user1(data)
VALUES('한글');

--특정범위의 문자를 추출해 주는 함수이다.
--substr('문자', 시작위치, 갯수)
SELECT substr('oracle test', 1, 4) /*substring(start, end)*/
FROM dual;

SELECT substr('oracle test', -3, 4)
FROM dual;

SELECT substr('오라클 테스트', 3, 4)
FROM dual;

SELECT substr('오라클 테스트', -3, 4)
FROM dual;

--특정문자의 인덱스를 추출해주는 함수이다.
SELECT instr('korea', 'or')
FROM dual;

SELECT instr('한국자바', '자바')
FROM dual;

--주어진 문자열에서 왼쪽으로 특정문자를 채우는 함수이다.
SELECT lpad('korea', 8, '*')
FROM dual;

--주어진 문자열에서 오른쪽으로 특정문자를 채우는 함수이다.
SELECT rpad('korea', 8, '*')
FROM dual;

--주어진 문자열에서 왼쪽의 특정문자를 삭제하는 함수이다.
SELECT ltrim('***korea', '*')
FROM dual;

--주어진 문자열에서 오른쪽의 특정문자를 삭제하는 함수이다.
SELECT rtrim('korea***', '*')
FROM dual;

--주어진 문자열에서 양쪽 특정문자를 삭제하는 함수이다.
SELECT trim('*' from '***korea***')
FROM dual;

--주어진 문자열에서 왼쪽의 공백제거
SELECT '   korea', length('   korea'), ltrim('   korea'), length(ltrim('   korea'))
FROM dual;

--주어진 문자열에서 오른쪽의 공백제거
SELECT 'korea   ', length('korea   '), rtrim('korea   '), length(rtrim('korea   '))
FROM dual;

--주어진 문자열에서 양쪽의 공백제거
SELECT trim(' 'from'   korea   '), length(trim(' 'from'   korea   '))
FROM dual;

--주어진 문자의 아스키 코드값을 구하는 함수이다.
SELECT ascii('A')
FROM dual;

--주어진 아스키 코드값의 문자를 구하는 함수이다.
SELECT chr(65)
FROM dual;

--주어진 문자를 연결하는 함수이다.
SELECT concat('java', 'jsp')
FROM dual;

SELECT 'java' || 'jsp'
FROM dual;

/*--------------------
숫자함수
---------------------*/
-- 3.55을 소수점 1의 자리까지 구하시오(반올림)
SELECT round(3.55, 1)
FROM dual;

--42523을 십의 자리까지 구하시오(반올림)
SELECT round(42523.55, -1)
FROM dual;

--42523을 일의 자리까지 구하시오(반올림)
SELECT round(42523.55, 0)
FROM dual;

SELECT round(42523.55)
FROM dual;

--256.78을 무조건 올림한다.(올림)
SELECT ceil(256.78)
FROM dual;

--289.78에서 소수이하는 무조건 버린다.(버림)
SELECT floor(289.78, 1)
FROM dual;

--2의 3승(거듭제곱)
SELECT power(2,3)
FROM dual;

--25의 제곱근
SELECT sqrt(25)
FROM dual;

--나머지
SELECT mod(10,3)
FROM dual

/*-----------------------------
날짜 함수
------------------------------*/
--현재 시스템에서 제공해주는 오늘의 날짜 구하는 함수
SELECT sysdate
FROM dual;

SELECT sysdate + 1
FROM dual;

SELECT sysdate - 1
FROM dual;

--오늘을 기준으로 10개월 후의 날짜
SELECT add_months(sysdate, 10)
FROM dual;

/*-----------------------------------------------
변환형 함수

숫자                  문자             날짜
to_number( ) <->    to_char( ) <->    to_date( )

-----------------------------------------------*/
-- 숫자 -> 문자

SELECT to_char(2532, '999,999.99')
FROM dual;

SELECT to_char(2532, '000,000.00')
FROM dual;

--각 나라의 통화를 표현 줄 때 L기호를 사용한다.
SELECT to_char(2532, 'L999,999.99')
FROM dual;

--날짜 -> 문자
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss day') /*12시간, day:월요일*/
FROM dual;

SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss dy') /*12시간, dy:월*/
FROM dual;

SELECT to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss day') /*24시간, dy:월*/
FROM dual;

/*
java
//HH : 24시간, hh:12시간
    String pattern = "yyyy-MM-dd HH:mm:ss a EEEE";
*/

/*-------------------------------
to_number( )
문자 -> 숫자
-------------------------------*/
SELECT '253' || '12'
FROM dual; --25312

SELECT concat('253', '12')
FROM dual; --25312

SELECT '253' + '12'
FROM dual; --265

SELECT to_number('253') + to_number('12')
FROM dual; --265

/*-------------------------------
to_date( )
문자 -> 날짜
-------------------------------*/
SELECT to_date('2022-10-14')
FROM dual;

SELECT first_name, hire_date
FROM employees;

--hire_date(입사일)을 이용해서 '홍길동님은 2003년 1월 3일에 입사했습니다.' 로 출력하는 query을 작성하시오.
SELECT first_name || '님은 ' || to_char(hire_date, 'yyyy') || '년 ' || ltrim(to_char(hire_date, 'mm'),'0')
        || '월 ' || ltrim(to_char(hire_date, 'dd'),'0') || '일에 입사했습니다.'
FROM employees;

/*-------------------------------
일반함수 (NULL)
1. nvl(컬럼, 대체값) : 첫번째 인자값이 null이면 0으로 대체해서 출력한다.
   - 대체할 값이 숫자이면 두번째 인자값에 숫자를 지정한다.
   - 대체할 값이 문자이면 두번째 인자값에 문자를 지정한다.
   - 대체할 값이 날짜이면 두번째 인자값에 날짜를 지정한다.
-------------------------------*/

SELECT commission_pct, nvl(commission_pct, 0)
FROM employees;

SELECT first_name, manager_id, nvl(to_char(manager_id), 'CEO')
FROM employees;

/*-------------------------------
일반함수 (NULL)
2. nvl2(컬럼, 대체값1, 대체값2) : 컬럼의 값이 null아니면 대체값1, null이면 대체값2로 출력한다.
-------------------------------*/

SELECT commission_pct, nvl2(commission_pct, 1, 0)
FROM employees;

SELECT count(*) AS 전체사원수, 
sum(nvl2(commission_pct, 1, 0)) AS "커미션지급 사원수", 
count(*)-sum(nvl2(commission_pct, 1, 0)) AS "커미션미지급 사원수"
FROM employees;

/*-------------------------------
일반함수 (NULL)
3. NULLIF(컬럼, 비교값 )
   컬럼값과 비교값이 같으면 NULL로 리턴하고 같지 않으면 컬럼의 값으로 리턴한다.
-------------------------------*/
SELECT commission_pct, NULLIF(commission_pct, 0.4)
FROM employees;

/*-------------------------------
일반함수 (NULL)
4. coalesce(컬럼1, 컬럼2)
   - 컬럼1, 컬럼2 모두 NULL이 아니면 컬럼1을 리턴한다
   - 컬럼1, 컬럼2 중 NULL이 아닌 컬럼을 리턴한다
   - 컬럼1, 컬럼2 모두 NULL이면 NULL을 리턴한다
-------------------------------*/

SELECT first_name, commission_pct, salary, coalesce(commission_pct, salary)
FROM employees;

SELECT first_name, commission_pct, commission_pct, coalesce(commission_pct, commission_pct)
FROM employees;

/*-------------------------------------------------
decode(컬럼, 값1, 처리1, 값2, 처리2, 그 밖의 처리)
java의 switch~case문과 비슷
--------------------------------------------------*/
-- department_id이 10이면 'ACCOUNTING', 20이면 'RESEARCH',
--                 30이면 'SALES', 40이면 'OPERATIONS', 'OTHERS'
SELECT first_name, department_id,
       decode(department_id, 10, 'ACCOUNTING',
                             20, 'RESEARCH',
                             30, 'SALES',
                             40, 'OPERATIONS', 'OTHERS') AS department_name
FROM employees;

-- 직급이 'PR_PER'인 사원은 5%, 'SA_MAN'인 사원은 10%,
-- 'AC_MGR'인 사원은 15%, 'PU_CLERK'인 사원은 20%를 인상

SELECT job_id, salary, decode(job_id, 'PR_PER', salary * 1.05,
                                     'SA_MAN', salary * 1.1,
                                     'AC_MGR', salary * 1.15,
                                     'PU_CLERK', salary * 1.2, salary) AS newsal
FROM employees;     

/*-------------------------------------------------
case when 조건식1 then 처리1
     when 조건식2 then 처리2
     when 조건식3 then 처리3
     else 처리n
end AS alias;     

java에서 다중 if~else문과 비슷
-------------------------------------------------*/
-- 입사일(hire_date) 1-3이면 '1사분기', 4-6이면 '2사분기',
--                  7-9이면 '3사분기', 10-12이면 '4사분기'                    
-- 로 처리를 하고 사원명(first_name), 입사일(hire_date), 분기로 출력하시오.

SELECT first_name, hire_date,
       case when to_char(hire_date, 'mm') <= 3 then '1사분기'
            when to_char(hire_date, 'mm') <= 6 then '2사분기'
            when to_char(hire_date, 'mm') <= 9 then '3사분기'
            when to_char(hire_date, 'mm') <= 12 then '4사분기'
       end AS "분기"
FROM employees;    

-- salary의 값이 10000미만이면 '하', 10000이상 20000미만이면 '중', 20000이상이면 '상'
-- 으로 출력하시오.
SELECT first_name, salary,
       case when salary<10000 then '하'
            when salary<20000 then '중'
            else '상'
       end AS "구분"
FROM employees;

/*--------------------------------------------------
집계함수(Aggregate Function), 그룹함수(Group Function)
max([DISTINCT] | [ALL] 컬럼) : 최대값
min([DISTINCT] | [ALL] 컬럼) : 최소값
count([DISTINCT] | [ALL] 컬럼) : 갯수
sum([DISTINCT] | [ALL] 컬럼) : 합계
avg([DISTINCT] | [ALL] 컬럼) : 평균
stddev([DISTINCT] | [ALL] 컬럼) : 표준편차
variance([DISTINCT] | [ALL] 컬럼) : 분산
--------------------------------------------------*/
SELECT max(salary), min(salary), count(salary), sum(salary), avg(salary), stddev(salary), variance(salary)
FROM employees;

-- NULL값이 아닌 레코드 수를 리턴
SELECT count(commission_pct)
FROM employees;

SELECT count(employee_id)
FROM employees;

SELECT count(*)
FROM employees;

SELECT count(DISTINCT commission_pct)
FROM employees;

SELECT count(ALL commission_pct)
FROM employees;

--집계함수와 단순컬럼은 함께 사용할 수 없다. (출력되는 레코드(row)수가 다르기 때문이다.)
--ORA-00937: not a single-group group function (단일 그룹의 그룹함수가 아닙니다.)
SELECT first_name, count(*)
FROM employees;

-- 그룹함수와 단순컬럼을 사용하기 위해서는 단순컬럼을 구룹화 해야 한다. (GROUP BY)
SELECT department_id, count(*)
FROM employees
GROUP BY department_id;
ORDER BY department_id;

-- 50이하인 부서번호에 대해서  NULL이 아닌 부서별의 직원수를 출력하시오.
SELECT department_id, count(*)
FROM employees
WHERE department_id <= 50
--AND department_id IS NOT NULL
GROUP BY department_id;

SELECT department_id, count(*)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING department_id <= 50;

-- 부서별의 직원수가 5이하인 경우만 출력하시오.
SELECT department_id, count(*)
FROM employees
GROUP BY department_id
HAVING count(*) <= 5;

-- 업무별(job_id) 급여합계를 출력하시오.
SELECT job_id, sum(salary)
FROM employees
GROUP BY job_id;

-- 부서별 최소급여, 최대급여를 최소값과 최대값이 같지 않은 경우에만 부서별 오름차순으로 출력하시오.
SELECT department_id, min(salary), max(salary)
FROM employees
GROUP BY department_id
HAVING min(salary) != max(salary)
ORDER BY department_id;

-- 10 40 70 null

-- 내림차순으로 정렬하면 NULL이 최상위에 출력된다.
SELECT department_id
FROM employees
ORDER BY department_id DESC;



                                