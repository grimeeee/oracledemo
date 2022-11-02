/*==============================================================================
join(조인)
1. 여러개의 테이블에서 원하는 데이터를 추출해주는 쿼리문이다.
2. join은 oracle제품에서 사용되는 oracle용 join이 있고
   모든 제품에서 공통적으로 사용되는 표준(ANSI)join이 있다.
==============================================================================*/

/*==============================================================================
1. equi join : 가장 많이 사용되는 조인방법 (innerjoin = equi join)
- 조인 대상이 되는 두 테이블에서 공통적으로 존재하는 컬럼의 값이 일치되는 행을 연결하여
  결과를 생성하는 방법이다.
==============================================================================*/

-- (1) oracle용 equi join
SELECT dept.department_id, first_name, job_id, department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id;

-- (2) ansi용 inner join
SELECT dept.department_id, first_name, job_id, department_name
FROM employees emp inner join departments dept
  ON emp.department_id = dept.department_id;

-- employees와 department테이블에서 사원번호(employee_id), 부서번호(department_id), 부서명(department_name)을 검색하세요.
SELECT emp.employee_id, dept.department_id, dept.department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id
ORDER BY emp.employee_id;

SELECT emp.employee_id, dept.department_id, dept.department_name
FROM employees emp inner join departments dept
  ON emp.department_id = dept.department_id
ORDER BY emp.employee_id;

-- employee와 jobs 테이블에서 사원번호(employee_id), 업무번호(job_id), 업무명(job_title)을 검색하세요
SELECT e.employee_id, j.job_id, j.job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id
ORDER BY e.employee_id;

SELECT e.employee_id, j.job_id, j.job_title
FROM employees e inner join jobs j
ON e.job_id = j.job_id
ORDER BY e.employee_id;

-- job_id가 'FI_MGR'인 사원이 속한 급여(salary)의 최솟값(min_salary), 최대값(max_salary)을 출력하시오
SELECT e.first_name, e.job_id, j.min_salary, j.max_salary
FROM employees e, jobs j
WHERE e.job_id = j.job_id 
AND e.job_id = 'FI_MGR';
/*
 선행테이블(Driving table) - 후행테이블(Driven table) 
 1. 왼쪽 -> 오른쪽
 2. 자식 -> 부모
*/
SELECT e.first_name, e.job_id, j.min_salary, j.max_salary
FROM employees e inner join jobs j
ON e.job_id = j.job_id
WHERE e.job_id = 'FI_MGR';

-- 부서가 'Seattle'에 있는 부서에서 근무하는 직원들의 first_name, hire_date, department_name, city 출력하는 SELECT을 작성하시오
SELECT e.first_name, e.hire_date, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND l.city='Seattle';

SELECT e.first_name, e.hire_date, d.department_name, l.city
FROM employees e INNER JOIN departments d 
ON e.department_id = d.department_id
    INNER JOIN locations l
ON d.location_id = l.location_id
WHERE l.city='Seattle';

-- 20번 부서의 이름과 그 부서에 근무하는 사원의 이름(first_name)을 출력하시오
SELECT d.department_id, d.department_name, e.first_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND d.department_id=20;

SELECT d.department_id, d.department_name, e.first_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id=20;

-- 1400번, 1500번 위치의 도시이름과 그 곳에 있는 부서의 이름을 출력하시오
SELECT l.location_id, l.city, d.department_name
FROM locations l INNER JOIN departments d
ON l.location_id=d.location_id 
WHERE l.location_id IN (1400,1500);

/*==============================================================================
2. carteian product (카티션 곱) 조인 : 테이블행의 갯수만큼 출력해주는 조인이다.
==============================================================================*/

-- 1) oracle용 carteian product
SELECT e.department_id, e.first_name, e.job_id, j.job_title
FROM employees e, jobs j; --2033

SELECT count(*) FROM employees; --107
SELECT count(*) FROM jobs; --19

-- 2) ANSI용 cross join
SELECT e.department_id, e.first_name, e.job_id, j.job_title
FROM employees e CROSS JOIN jobs j; --2033

/*==============================================================================
3. NATURAL JOIN (표준에서만 제공)
    - 두 테이블간의 동일한 이름을 갖는 모든 컬럼들에 대해 EQUI(=) JOIN을 수행한다.
    - SQL SERVER에서는 지원하지 않는 기능이다.
    - 자주 사용하는 방법은 아님 / 컬럼명, 데이터타입이 정확히 같아야하기 때문
==============================================================================*/

SELECT first_name, salary, department_id, department_name
FROM employees NATURAL JOIN departments; --32

SELECT first_name, salary, d.department_id, department_name
FROM employees e INNER JOIN departments d
ON e.department_id=d.department_id; --106

/*==============================================================================
4. non_equl JOIN 
    - (=)동등비교연산자 제외한 >=, <=, >, < 등의 연산자를 이용해서 조건을 지정하는 방법
==============================================================================*/

-- 1) oracle용 NON-EQUI JOIN
SELECT e.first_name, e.salary, j.min_salary, j.max_salary, j.job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id
AND e.salary >= j.min_salary
AND e.salary <= j.max_salary;

-- 2) ANSI용 NON-EQUI JOIN
SELECT e.first_name, e.salary, j.min_salary, j.max_salary, j.job_title
FROM employees e JOIN jobs j
ON e.job_id = j.job_id
WHERE e.salary >= j.min_salary
AND e.salary <= j.max_salary;

/*==============================================================================
5. OUTER JOIN
    - 한 테이블은 데이터가 있고 다른 반대쪽에는 데이터가 없는 경우에 데이터가 있는 
      테이블의 내용을 모두 가져오는 조건이다.
    - 데이터가 없는 것은 null로 채워짐
==============================================================================*/

-- 1) oracle OUTER JOIN
SELECT e.first_name, e.employee_id, e.department_id, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+); /*LEFT OUTER JOIN*/

SELECT e.first_name, e.employee_id, e.department_id, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id; /*RIGHT OUTER JOIN*/

-- 2) ansi OUTER JOIN
SELECT e.first_name, e.employee_id, e.department_id, d.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id; /*LEFT OUTER JOIN*/

SELECT e.first_name, e.employee_id, e.department_id, d.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id; /*RIGHT OUTER JOIN*/

/*==============================================================================
6. SELF JOIN
    - 하나의 테이블을 두 개의 테이블로 설정해서 사용하는 조인방법이다.
    - 하나의 테이블에 같은 데이터가 두개의 컬럼에 다른 목적으로 저장되어 있는 경우
    employees, employee_id, manager_id
==============================================================================*/

-- 1) oracle SELF JOIN
SELECT w.employee_id AS 사원번호,
       w.first_name AS 사원이름,
       w.manager_id AS 매니저번호,
       m.first_name AS 매니저이름
FROM employees w, employees m
WHERE w.manager_id = m.employee_id -- 순서 반대로 하면 안됨 / 연결할 것이 없으면 작성이 되지 않아도 됨
ORDER BY w.employee_id; 

-- 2) ansi SELF JOIN
SELECT w.employee_id AS 사원번호,
       w.first_name AS 사원이름,
       w.manager_id AS 매니저번호,
       m.first_name AS 매니저이름
FROM employees w JOIN employees m
ON w.manager_id = m.employee_id
ORDER BY w.employee_id; 

/*==============================================================================
USING (ansi에서 사용)
==============================================================================*/

SELECT department_id, first_name, job_id, department_name
FROM employees INNER JOIN departments USING(department_id)
--ON emp.department_id = dept.department_id
WHERE department_id = 30; --natural join처럼 사용가능

-- oracle에서는 SELECT와 FROM 필수, MSSQL에서는 SELECT만 사용해도 가능
SELECT sysdate
FROM dual;

-- mssql에서는 select에서 사용한 alias를 group by와 order by에서 참조가능
/*
SELECT sum(salary) as 합계
FROM employees
GROUP BY 합계
ORDER BY 합계
*/

