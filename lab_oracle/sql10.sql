-- join, group by 연습: Oracle, ANSI 문법

-- 1. emp, dept 테이블에서 
-- 부서번호, 부서이름, 부서별 사원수, 부서별 급여 최솟값, 부서별 급여 최댓값, 
-- 부서별 급여 평균을 검색
-- 소숫점이 있는 경우에는 소숫점 한자리까지 반올림해서 출력.
-- 부서번호 오름차순 순서로 출력.
select e.deptno, d.dname, count(*) as count_emp, 
    min(e.sal) as min_sal, max(e.sal) as max_sal, 
    round(avg(e.sal), 1)  as avg_sal
from emp e join dept d on e.deptno = d.deptno
group by e.deptno, d.dname
order by e.deptno;

select e.deptno, d.dname, count(*) as count_emp, 
    min(e.sal) as min_sal, max(e.sal) as max_sal, 
    round(avg(e.sal), 1)  as avg_sal
from emp e, dept d 
where e.deptno = d.deptno
group by e.deptno, d.dname
order by e.deptno;

-- inner와 outer join 결과 비교
select e.deptno, d.dname, count(*) as count_emp, 
    min(e.sal) as min_sal, max(e.sal) as max_sal, 
    round(avg(e.sal), 1)  as avg_sal
from emp e left join dept d on e.deptno = d.deptno
group by e.deptno, d.dname
order by e.deptno;

select d.deptno, d.dname, count(e.empno) as count_emp, 
    min(e.sal) as min_sal, max(e.sal) as max_sal, 
    round(avg(e.sal), 1)  as avg_sal
from emp e right join dept d on e.deptno = d.deptno
group by d.deptno, d.dname
order by d.deptno;

select d.deptno, d.dname, count(e.empno) as count_emp, 
    min(e.sal) as min_sal, max(e.sal) as max_sal, 
    round(avg(e.sal), 1)  as avg_sal
from emp e full join dept d on e.deptno = d.deptno
group by d.deptno, d.dname
order by d.deptno;

-- 2. emp, dept 테이블에서
-- 부서번호, 부서이름, 사번, 이름, 직책, 급여를 검색.
-- 부서 테이블의 모든 부서번호/이름은 출력되야 됨.
-- 부서번호 오름차순 순서로 출력.
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d left join emp e
    on d.deptno = e.deptno
order by d.deptno;

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d, emp e
where d.deptno = e.deptno(+)
order by d.deptno;

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e, dept d
where d.deptno = e.deptno(+)
order by d.deptno;

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d, emp e
where e.deptno(+) = d.deptno
order by d.deptno;

-- 3. emp, dept, salgrade에서
-- 부서번호, 부서이름, 사번, 이름, 매니저사번, 매니저이름, 급여, 급여 등급을 검색
-- dept 테이블의 모든 부서 번호가 출력 되어야 함.(10, 20, 30, 40)
-- 매니저가 없는 사원의 정보도 출력되어야 함.(KING)
-- 출력 순서: 부서번호 오름차순 -> 사번 오름차순
select d.deptno, d.dname, e1.empno, 
    e1.ename as 사원이름, e1.mgr, 
    e2.ename as 매니저이름, e1.sal, s.grade
from dept d 
    left join emp e1 on d.deptno = e1.deptno
    left join emp e2 on e1.mgr = e2.empno
    left join salgrade s on e1.sal between s.losal and s.hisal
order by d.deptno, e1.empno;

select d.deptno, d.dname, e1.empno,
    e1.ename as 직원이름, e1.mgr, 
    e2.ename as 매니저이름, e1.sal, s.grade
from dept d, emp e1, emp e2, salgrade s
where d.deptno = e1.deptno(+)
    and e1.mgr = e2.empno(+)
    and e1.sal(+) between s.losal(+) and s.hisal(+)
order by d.deptno, e1.empno;

-- 4. emp, dept 테이블에서
-- 부서 위치, 부서에서 근무하는 사원 수 검색(inner join)
select d.loc, count(e.empno)
from dept d join emp e on d.deptno = e.deptno
group by d.loc;

select d.loc, count(e.empno)
from dept d, emp e 
where d.deptno = e.deptno
group by d.loc;

-- 부서 위치, 부서에서 근무하는 사원 수 검색(outer join)


-- 5. emp, dept, salgrade 테이블에서
-- 직원 이름, 부서 위치, 급여, 급여 등급을 검색.
-- 급여는 3000 이상인 직원들만 선택.
-- 직원 이름 오름차순 정렬.

