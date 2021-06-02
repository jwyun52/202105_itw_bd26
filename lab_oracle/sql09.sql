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

insert into emp (empno, ename, deptno)
values (1004,  '오쌤', 50);
commit;

select * from emp;

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

-- emp 테이블에서 부서번호 50번인 오쌤은 inner join 결과에 없음.
-- 부서번호 50은 dept 테이블에 없기 때문에.
-- dept 테이블에 있는 부서번호 40번 Operation도 inner join 결과에 없음.
-- emp 테이블의 deptno 컬럼에는 40이 없기 때문에.


-- left outer join
-- 1) Oracle 문법
select e.empno, e.ename, e.deptno, d.dname
from  emp e, dept d
where e.deptno = d.deptno(+);

select e.empno, e.ename, d.deptno, d.dname
from  emp e, dept d
where e.deptno = d.deptno(+);

-- 2) ANSI 표준 문법
select e.empno, e.ename, e.deptno, d.dname
from emp e left outer join dept d
    on e.deptno = d.deptno;

-- left outer join에서는
-- 왼쪽 테이블 emp에만 등장하는 부서번호 50번에 대한 레코드(오쌤)도 함께 검색됨.
-- 하지만, 오른쪽 테이블 dept에만 등장하는 부서번호 40번에 대한 
-- 레코드(Operation)은 검색되지 않음.

-- right outer join
-- 1) Oracle 문법
select e.empno, e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno;

-- 2) ANSI 표준 문법
select e.empno, e.ename, d.deptno, d.dname
from emp e right outer join dept d
    on e.deptno = d.deptno;

-- right outer join에서는
-- 오른쪽 테이블인 dept에만 있는 40번 Operation이 검색됨.
-- 왼쪽 테이블인 emp에만 있는 50번 부서는 검색되지 않음.

-- full outer join
-- Oracle 문법은 없고, ANSI 표준 문법만 있음.
select e.empno, e.ename, e.deptno, d.deptno, d.dname
from emp e full outer join dept d
    on e.deptno = d.deptno;

select e.empno, e.ename, e.deptno, d.dname
    from emp e, dept d
    where e.deptno = d.deptno(+)  -- left outer join
union  -- 합집합
select e.empno, e.ename, d.deptno, d.dname
    from emp e, dept d
    where e.deptno(+) = d.deptno;  -- right outer join

-- join 이름을 쓸 때 inner와 outer는 생략가능!
-- inner join = join 
-- left outer join = left join
-- right outer join = right join
-- full outer join = full join

-- cross join(cartesian product) - 거의 사용하는 경우가 없음.
select e.empno, e.ename, e.deptno, d.deptno, d.dname
from emp e, dept d;

select e.empno, e.ename, e.deptno, d.deptno, d.dname
from emp e cross join dept d;

-- emp, dept 테이블에서 사번, 이름, 부서이름, 급여를 출력. (inner join)
-- 급여가 2000 이상인 직원들만 선택.
-- 급여의 내림차순 정렬.







