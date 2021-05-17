SELECT E.EMPNO, E.ENAME,D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL BETWEEN S.LOSAL AND S.HISAL
AND SAL > (SELECT AVG(SAL) FROM EMP) ORDER BY E.SAL DESC, E.EMPNO;

-- JOIN 두 개 이상의 테이블 연결하여 하나의 테이블처럼 출력,
-- 집합연산자 = 세로로 연결, 조인은 가로로 연결
-- 명시한 테이블의 데이터를 가로로 연결하기위해 조인사용하지만, 어떤 데이터를 가로로 정확히 연결하는지 기준은 프로그래머가 정해주어야 함
SELECT * FROM EMP, DEPT ORDER BY EMPNO; -- FROM 절에 여러 테이블 선언하기
SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO -- 열 이름 DEPTNO 비교하는 조건식으로 조인
ORDER BY EMPNO;
SELECT * FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO ORDER BY EMPNO; -- 테이블 이름 별칭으로 표현

SELECT E.EMPNO,D.DNAME FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO ORDER BY EMPNO;

SELECT EMPNO, ENAME, DEPTNO, DNAME, LOC FROM EMP E, DEPT D -- 등가조인
WHERE E.DEPTNO = D.DEPTNO; -- 각 테이블 열 이름이 같을 경우 해당 열 이름 테이블 구번없이 명시하면 오류 발생
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC -- 열 이름에 각각의 테이블 이름도 함께 명시할 때
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.EMPNO; 

SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND SAL >=3000; -- WHERE 절에 조건식 추가

SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D -- EMP E DEPT D 등가조인
WHERE E.DEPTNO = D.DEPTNO
AND SAL <= 2500
AND EMPNO <=9999
ORDER BY E.EMPNO;

SELECT * FROM EMP;
SELECT * FROM SALGRADE; -- 비등가조인
SELECT * FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL; -- 급여 범위 지정 조건식하여 비등가조인하기

SELECT E1.EMPNO, E1.ENAME, E1.MGR,
E2.EMPNO AS MGR_EMPNO,
E2.ENAME AS MER_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO; -- 같은 테이블 두번 사용하여 자체 조인

SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
E2.EMPNO AS MGR_EMPNO,
E2.ENAME AS MGR_ENAME 
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+) -- 왼쪽 외부조인
ORDER BY E1.EMPNO; -- 상급자가 존재하지않는 사원 출력

SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
E2.EMPNO AS MGR_EMPNO,
E2.ENAME AS MGR_ENAME 
FROM EMP E1, EMP E2
WHERE E1.MGR(+) = E2.EMPNO -- 오른쪽 외부조인
ORDER BY E1.EMPNO; -- 오른쪽에 MGR없는, 즉 부하직원이 없는 사원 출력

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM
, DEPTNO, D.DNAME, D.LOC
FROM EMP E NATURAL JOIN DEPT D -- NATURAL JOIN사용하여 조인하기
ORDER BY DEPTNO, E.EMPNO;

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM
, DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D USING(DEPTNO) -- JOIN~USING 사용하여 조인하기
WHERE SAL>=3000 ORDER BY DEPTNO, E.EMPNO;

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM
, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON(E.DEPTNO = D.DEPTNO) -- JOIN~ON 사용하여 등가조인하기
WHERE SAL<=3000 ORDER BY E.DEPTNO, EMPNO;

