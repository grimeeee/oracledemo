/*==============================================================================
그룹내 순위관련함수
RANK( ) OVER( ) : 특정 컬럼에 대한 순위를 구하는 함수로 동일한 값에 대해서는 동일한 순위를 준다.
DENSE_RANK( ) OVER( ) : 동일한 순위를 하나의 건수로 취급한다.
ROW_NUMBER( ) OVER( ) : 동일한 값이라도 고유한 순위를 부여한다.
==============================================================================*/

SELECT job_id, first_name, salary, rank() over(ORDER BY salary DESC)
FROM employees; -- 1 2 2 4

-- 그룹별로 순위를 부여할 때 사용 : PARTITION BY
SELECT job_id, first_name, salary, rank() over(PARTITION BY job_id ORDER BY salary DESC) 
FROM employees; -- 1 1 1 ... 1 2 3 4 5...

SELECT job_id, first_name, salary, dense_rank() over(ORDER BY salary DESC)
FROM employees; -- 1 2 2 3

SELECT job_id, first_name, salary, row_number() over(ORDER BY salary DESC)
FROM employees; -- 1 2 3 4
                -- 동일한 순위가 나오면 앞에 있는 컬럼에 먼저 숫자를 매김, 잘 사용하지 않음

/*==============================================================================
계층형 질의
 1. START WITH 절은 계층구조 전개이 시작 위치를 지정하는 구문이다. 
 2. CONNECT BY 절은 다음에 전개될 자식 데이터를 지정하는 구문이다. 
 3. 루트 데이터는 LEVEL 1이다. (0이 아님) (의사컬럼)
    (1)CONNECT_BY_ROOT(의사컬럼)  
       - 현재 조회된 최상위 정보 
    (2)CONNECT_BY_ISLEAF(의사컬럼) 
       - 현재 행이 마지막 계층의 데이터인지 확인 
       - LEAF을 만나면 1을 반환하고 0을 반환
    (3) SYS_CONNECT_BY_PATH( 컬럼, 구분자)(의사컬럼)
        - 루트 노드부터 해당 행까지의 경로를 입력한 컬럼기준으로 구분자를 사용해서 보여줌  
    (4)CONNECT_BY_ISCYCLE(의사컬럼)  
       - 현재 행의 조상이기도 한 자식을 갖는 경우 1을 반환 
       - 이 의사컬럼을 사용하기 위해서 CONNECT BY다음에 NOCYCLE을 사용해야한다.
 4. PRIOR 자식 = 부모 (부모->자식 방향으로 전개. 순방향 전개)
    PRIOR 부모 = 자식 (자식->부모 방향으로 전개. 역방향 전개)

==============================================================================*/

SELECT first_name, lpad(first_name, 10)
FROM employees;

SELECT first_name, lpad(first_name, 10, '*')
FROM employees;

-- 매니저 -> 사원
SELECT employee_id, manager_id, LEVEL, lpad(' ',3*(LEVEL-1)) || first_name
FROM employees
START WITH manager_id IS NULL -- 최상위가 오너
CONNECT BY PRIOR employee_id = manager_id;

SELECT employee_id, first_name, manager_id
FROM employees;

-- 사원 -> 매니저
SELECT employee_id, manager_id, LEVEL, lpad(' ',3*(LEVEL-1)) || first_name
FROM employees
START WITH manager_id IS NOT NULL -- 최상위가 사원
CONNECT BY PRIOR manager_id = employee_id;

-- CONNECT_BY_ROOT : 최상위 루트
SELECT employee_id, manager_id, LEVEL, lpad(' ',3*(LEVEL-1)) || first_name, CONNECT_BY_ROOT employee_id
FROM employees
START WITH manager_id IS NULL 
CONNECT BY PRIOR employee_id = manager_id;

-- CONNECT_BY_ISLEAF : 제일 하위이면 1, 아니면 0으로 리턴한다.
-- sql에서 is가 앞에 붙으면 1 또는 2 리턴
-- ORDER SIBLINGS BY : 레벨 단위로 정렬해줌
SELECT employee_id, manager_id, LEVEL, lpad(' ',3*(LEVEL-1)) || first_name, CONNECT_BY_ISLEAF employee_id, 
        CONNECT_BY_ISLEAF, SYS_CONNECT_BY_PATH(first_name, '/')
FROM employees
START WITH manager_id IS NULL 
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY first_name; 
