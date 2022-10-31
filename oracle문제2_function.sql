/*------------------------------
문제
------------------------------*/
--1) 모든사원에게는 상관(Manager)이 있다. 하지만 employees테이블에 유일하게 상관이
--   없는 로우가 있는데 그 사원(CEO)의 manager_id컬럼값이 NULL이다. 상관이 없는 사원을
--   출력하되 manager_id컬럼값 NULL 대신 CEO로 출력하시오.
SELECT manager_id, nvl(to_char(manager_id),'CEO') AS 상관
FROM employees
ORDER BY manager_id DESC;
    

--2) 가장최근에 입사한 사원의 입사일과 가장오래된 사원의 입사일을 구하시오.
SELECT max(hire_date) "최근 사원 입사일", min(hire_date) AS "오래된 사원 입사일" 
FROM employees;
   
 
--3) 부서별로 커미션을 받는 사원의 수를 구하시오.
SELECT department_id, count(commission_pct)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;
   
   
--4) 부서별 최대급여가 10000이상인 부서만 출력하시오.   
SELECT department_id, max(salary)
FROM employees
GROUP BY department_id
HAVING max(salary) >= 10000
ORDER BY department_id;
  

--5) employees 테이블에서 직종이 'IT_PROG'인 사원들의 급여평균을 구하는 SELECT문장을 기술하시오.
SELECT avg(salary)
FROM employees
WHERE job_id = 'IT_PROG';

SELECT job_id, avg(salary)
FROM employees
GROUP BY job_id
HAVING job_id = 'IT_PROG';

--6) employees 테이블에서 직종이 'FI_ACCOUNT' 또는 'AC_ACCOUNT' 인 사원들 중 최대급여를  구하는    SELECT문장을 기술하시오.   
SELECT max(salary)
FROM employees
WHERE job_id = 'FI_ACCOUNT'
    OR job_id = 'AC_ACCOUNT';
  
SELECT max(salary)
FROM employees
WHERE job_id IN ('FI_ACCOUNT', 'AC_ACCOUNT');
  
--7) employees 테이블에서 50부서의 최소급여를 출력하는 SELECT문장을 기술하시오.
SELECT min(salary)
FROM employees
WHERE department_id = 50;

SELECT department_id, min(salary)
FROM employees
-- WHERE department_id = 50
GROUP BY department_id
HAVING department_id = 50;
    
--8) employees 테이블에서 아래의 결과처럼 입사인원을 출력하는 SELECT문장을 기술하시오.
--   <출력:  2001		   2002		       2003
 --  	     1          7                6   >
SELECT sum(decode (to_char(hire_date, 'yyyy'), '2001', 1, 0)) AS "2001",
         sum(decode (to_char(hire_date, 'yyyy'), '2002', 1, 0)) AS "2002",
         sum(decode (to_char(hire_date, 'yyyy'), '2003', 1, 0)) AS "2003"
FROM employees;
   
    
--9) employees 테이블에서 각 부서별 인원이 10명 이상인 부서의 부서코드,
--  인원수,급여의 합을 구하는  SELECT문장을 기술하시오.
SELECT department_id, count(*), sum(salary)
FROM employees
GROUP BY department_id
HAVING count(*) >= 10; 
   
  
  
--10) employees 테이블에서 이름(first_name)의 세번째 자리가 'e'인 직원을 검색하시오.
SELECT first_name
FROM employees
WHERE first_name LIKE ('__e%');

-- instr(데이터, 찾을 문자, 시작위치, 순서)
SELECT first_name
FROM employees
WHERE instr(first_name, 'e') = 3;

SELECT first_name
FROM employees
WHERE instr(first_name, 'e', 3,1) = 3;

SELECT instr('korea', 'e', 2, 2)
FROM dual; --0

SELECT instr('koreae', 'e', 2, 2)
FROM dual; --6

SELECT first_name
FROM employees
WHERE substr(first_name, 3, 1) = 'e';


/*-------------------------------------------------
ROWNUM
1. oracle의 SELECT문 결과에 대해서 논리적인 일련번호를 부여한다.
2. ROWNUM은 조회되는 행수를 제한할 때 많이 사용한다.
3. rownum = 1, rownum <=3, rownum < 3 (가능)
   rownum = 3, rownum >=3, rownum > 3(불가능)
--------------------------------------------------*/

SELECT rownum, first_name, salary
FROM employees; --0

SELECT rownum, first_name, salary
FROM employees
WHERE rownum = 1; --0

SELECT rownum, first_name, salary
FROM employees
WHERE rownum <= 3; --0

SELECT rownum, first_name, salary
FROM employees
WHERE rownum = 3; --X

SELECT rownum, first_name, salary
FROM employees
WHERE rownum >= 3; --x

/*-------------------------------------
ROWID
1. oracle에서 데이터를 구분할 수 있는 유일한 값이다.
2. SELECT문에서 rowid를 사용할 수 있다.
3. rowid을 통해서 데이터가 어떤 데이터파일, 어느 블록에 저장되어 있는지 알 수 있다.
4. rowid 구조 (총 18자리)
   오브젝트 번호 (1~6) : 오브젝트 별로 유일한 값을 가지고 있으며, 해당 오브젝트가 속해 있는 값이다.
   파일 번호(7~9) : 테이블스페이스(tablespace)에 속해 있는 데이터 파일에 대한 상대 파일번호이다.
   블록번호(10~15) : 데이터 파일 내부에서 어느 블록에 데이터가 있는지 알려준다.
   데이터번호(16~18) : 데이터 블록에 데이터가 저장되어 있는 순서를 의미한다.
   
[block size 확인] - 8kbyte가 저장됨
SQL> conn sys/a1234 as sysdba
Connected.
SQL> show user
USER is "SYS"
SQL> show parameter db_block_size

NAME                                   TYPE                     VALUE
------------------------------------ ---------------------- ------------------------------
db_block_size                          integer                  8192

--------------------------------------*/
SELECT rowid, first_name, salary
FROM employees;





