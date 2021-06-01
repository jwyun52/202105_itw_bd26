-- JOIN: 두 개 이상의 테이블에서 검색을 해서 결과를 만드는 것. 
/* 
1. Oracle 문법
select 컬럼, ...
from 테이블1, 테이블2, ...
where join조건;

2. ANSI 표준 문법
select 컬럼, ...
from 테이블1 join종류 테이블2 
    on join조건;
*/

-- 사번, 이름, 부서번호, 부서이름 검색
-- inner join
select emp.empno, emp.ename, emp.deptno, dept.dname
from emp, dept
where emp.deptno = dept.deptno;

-- 위의 Oracle 문법과 동일한 ANSI 표준 문법
select emp.empno, emp.ename, emp.deptno, dept.dname
from emp inner join dept
    on emp.deptno = dept.deptno;

-- join을 할 때 from의 테이블 이름에 별명을 줄 수 있음.
-- from에서 지정한 별명을 select절에서 사용할 수 있음.
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno;

select e.empno, e.ename, e.deptno, d.dname
from emp e inner join dept d
    on e.deptno = d.deptno;




