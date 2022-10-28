/////////////////////////////////////
////--문제--
////////////////////////////////////// 
1) employees테이블에서 급여가 17000이하인 사원의 사원번호, 사원명(first_name), 급여를 출력하시오.
 SELECT employee_id, first_name, salary
 FROM employees
 WHERE salary <= 17000;

2) employees테이블에서 2005년 1월 1일 이후에 입사한 사원을 출력하시오.
 SELECT first_name 
 FROM employees
 WHERE hire_date >= '2005-01-01';

3) employees테이블에서 급여가 5000이상이고 업무(job_id)이 'IT_PROG'이 사원의 사원명(first_name), 급여, 
   업무을 출력하시오.
 SELECT first_name, salary, job_id
 FROM employees
 WHERE salary >= 5000 and job_id = 'IT_PROG';
 

4) employees테이블에서 부서번호가 10, 40, 50 인 사원의 사원명(first_name), 부서번호, 이메일(email)을 출력하시오.
 SELECT first_name, department_id, email
 FROM employees 
 WHERE department_id IN(10,40,50);

5) employees테이블에서 사원명(first_name)이 even이 포함된 사원명,급여,입사일을 출력하시오.
 SELECT first_name, salary, hire_date
 FROM employees
 WHERE first_name LIKE '%even%';

6) employees테이블에서 사원명(first_name)이 teve앞뒤에 문자가 하나씩 있는 사원명,급여,입사일을 출력하시오.
 SELECT first_name, salary, hire_date
 FROM employees
 WHERE first_name LIKE '_teve_';

7) employees테이블에서 급여가 17000이하이고 커미션이 null이 아닐때의 사원명(first_name), 급여, 
  커미션을 출력하시오.
  SELECT first_name, salary, commission_pct
  FROM employees
  WHERE salary <= 17000 AND commission_pct IS NOT NULL;
 
  
8) 2005년도에 입사한 사원의 사원명(first_name),입사일을 출력하시오.
 SELECT first_name, hire_date
 FROM employees
 WHERE to_char(hire_date, 'yyyy') = '2005';
 

9) 커미션 지급 대상인 사원의 사원명(first_name), 커미션을 출력하시오.
 SELECT first_name, commission_pct
 FROM employees
 WHERE commission_pct IS NOT NULL;
 

10) 사번이 206인 사원의 이름(first_name)과 급여를 출력하시오.
 SELECT first_name, salary
 FROM employees
 WHERE employee_id = 206;


11) 급여가 3000이 넘는 업무(job_id),급여(salary)를 출력하시오.
 SELECT job_id, salary
 FROM employees
 WHERE salary > 3000;


12)'ST_MAN'업무을 제외한 사원들의 사원명(first_name)과 업무(job_id)을 출력하시오.
 SELECT first_name, job_id
 FROM employees
 WHERE job_id <> 'ST_MAN';


13) 업무이 'PU_CLERK' 인 사원 중에서 급여가 10000 이상인 사원명(first_name),업무(job_id),급여(salary)을 출력하시오.
 SELECT first_name, job_id, salary
 FROM employees
 WHERE job_id = 'PU_CLERK'
 AND salary >= 1000;


14) commission을 받는 사원명(first_name)을 출력하시오.
 SELECT first_name
 FROM employees
 WHERE commission_pct IS NOT NULL;

15) 20번 부서와 30번 부서에 속한 사원의 사원명(fist_name), 부서를 출력하시오.
 SELECT first_name, department_id
 FROM employees
 WHERE department_id IN(20,30);
   

16) 급여가 많은 사원부터 출력하되 급여가 같은 경우 사원명(first_name) 순서대로 출력하시오.
 SELECT *
 FROM employees
 ORDER BY salary DESC, first_name ASC;

17) 업무이 'MAN' 끝나는 사원의 사원명(first_name), 급여(salary), 업무(job_id)을 출력하시오.
 SELECT first_name, salary, job_id
 FROM employees
 WHERE job_id LIKE '%MAN';
