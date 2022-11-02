/*----------------------------------------------
 문제
 ----------------------------------------------   */
1)EMPLOYEES 테이블에서 입사한 달(hire_date) 별로 인원수를 조회하시오 . 
  <출력: 월        직원수   >
 SELECT to_char(hire_date, 'mm') AS 월, count(*)  AS 직원수
 FROM employees
 GROUP BY to_char(hire_date, 'mm') 
 ORDER BY to_char(hire_date, 'mm');
-- ORDER BY 월;
-- 버전이 낮을 경우 한글로 alias를 넣는 경우  "" 칠것
 
2)각 부서에서 근무하는 직원수를 조회하는 SQL 명령어를 작성하시오. 
단, 직원수가 5명 이하인 부서 정보만 출력되어야 하며 부서정보가 없는 직원이 있다면 부서명에 “<미배치인원>” 이라는 문자가 출력되도록 하시오. 
그리고 출력결과는 직원수가 많은 부서먼저 출력되어야 합니다.
SELECT nvl(to_char(d.department_id),'<미배치인원>'), nvl(d.department_name,'<미배치인원>'), count(*) AS "인원수"
FROM employees e, departments d
WHERE e.department_id = d.department_id(+) /*left outer join*/
GROUP BY d.department_id, d.department_name
HAVING count(*) <= 5
ORDER BY count(*) DESC; 
--ORDER BY 인원수 DESC;


3)각 부서 이름 별로 2005년 이전에 입사한 직원들의 인원수를 조회하시오.
 <출력 :    부서명		입사년도	인원수  >
SELECT d.department_name AS 부서명, to_char(e.hire_date, 'yyyy') AS 입사년도, count(*) AS 인원수
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_name, to_char(e.hire_date, 'yyyy') 
HAVING to_char(e.hire_date, 'yyyy') <= '2005'
-- ORDER BY 입사년도 DESC;
 ORDER BY 2 DESC; -- 컬럼 인덱스로도 사용가능( 2번 : 입사년도) 좋은방법은 아닙니당
 
4)직책(job_title)에서 'Manager'가 포함이된 사원의 이름(first_name), 직책(job_title), 부서명(department_name)을 조회하시오.
SELECT e.first_name, j.job_title, d.department_name 
FROM employees e, jobs j, departments d
WHERE e.job_id = j.job_id
AND e.department_id = d.department_id
AND job_title LIKE '%Manager%';
  
5)'Executive' 부서에 속에 있는 직원들의 관리자 이름을 조회하시오. 
단, 관리자가 없는 직원이 있다면 그 직원 정보도 출력결과에 포함시켜야 합니다.
 <출력 : 부서번호 직원명  관리자명  >
 SELECT d.department_id AS 부서번호, w.first_name AS 직원명, m.first_name AS 관리자명 
 FROM employees w, employees m, departments d
 WHERE w.manager_id = m.employee_id(+)
 AND w.department_id = d.department_id
 AND d.department_name = 'Executive';