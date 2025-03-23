
select * from emp

-------------------------------------------1. UPDATE --------------------------------------------

------------ this is how emp salary is get set from other table dept_name
update emp 
set salary = salary*1.1 --increse salary to the 10%
where  dept_id in (select dept_id from dept where dept_name = 'HR')

----OR 
update emp 
set salary = salary*1.2
from emp e
inner join dept d on e.dept_id = d.dept_id
where d.dept_name = 'HR'

-----DELETE EXTRA ROW NOW

--------------------------------------
-- add the dept_name col in emp which is now contain the null value

alter table emp
add dept_N varchar (20)

select * from emp


------------------------update the table from another table--------------------------------------

--------unable to upadte by where clause so we did join 

update emp
set dept_N = d.dept_name
from emp e
inner join dept d on e.dept_id = d.dept_id

select * from emp



-------------------------------------------------------------------------------------------------------------------

Select * into dept_backup from dept --1. make a backup table of dept

Select * from dept_backup              --2. SAME value as in dept

insert into dept_backup(dept_id,dept_name)   --3. add the duplicate value at the 100 dept_id
values(100, 'DA')

------------------now upadte dept_N by dept dept_name

update emp 
set dept_N = dept_name    --still output comming the 'HR' ,may be random or what is comming first in dept table is taking taking that for emp
join dept d on  e.dept_id = d.dept_id

select * from emp

--------------------------------------2.DELETE-------------------------------------------------------------------------------

--1. UPDATE:- we use inner join to take the value from another table
--2, DELETE:- we generally not use the inner join bcz we don't need the  value from other table

select * into d from emp -- store val of emp in resulant able so that deletion n all not affect the orginal emp table
--drop table d
Delete d -- delete all the rows accept the attribute
from d

--------OR -----------
truncate table d

---------
select * from d

----------------------------------------------------
delete from d
where dept_id = (select dept_id from dept where dept_name = 'HR')


---------------------------------------------3. EXISTS----------------------------------------------------------
select * from dept
select distinct dept_id from  emp

--------------------------------exist check how many rows return of 1 or more is return it take it as true and perform
  
Select * from emp e              --exist only show that value that is present in both like 400 is not in  dept
where exists( select * from dept d  where e.dept_id =  d.dept_id )  

--for row database(which store data in row)  exist is faster  than (in operate) like sql server n oracle is row  but again their is not much difference


-----------------------------------------------4. NOT EXISTS----------------------------------------------------------------------------------

select * from emp e
where not exists( select * from dept d where e.dept_id =  d.dept_id) --outpput will be 400
----OR
select * from emp e
where not exists( select 1 from dept d where e.dept_id =  d.dept_id) --outpput will be 400

-----------------------------------------------	CHECKING TABLE IS PRESENT OR NOT ----------------------------------------------------------------

Create table if not exists  emp

---------------------------------------------------------------------------------------------------------------------------------
/*
DDL :- data defination lang      --> create, drop , alter
DML :- data manipulation lang    --> insert, update delete 
DQL :- data query lang  
DCL :- data control lang         -->  grant, revoke          (give the access to user)
TCL :- Transaction control lang  --> commit , rollback
*/

-------------------------------------------DCL(data control lang )-----------------------------------------------------------------

--------------------------------------------------------- GRANT-----------------------------------------------------------------------
--Assigning to individual 

--Gives permission to SELECT (read) and INSERT (add new records) into the emp table.
grant select, insert on emp to guest 

----give sel, and insert to all of them
grant select, insert on emp to public
 

 --SCHEMA::dbo → Targets all objects (tables, views, etc.) in the dbo schema.

 /*
 Advantages of Using SCHEMA Instead of Individual Tables
✅ Applies to all tables in dbo schema (current and future).
✅ No need to update permissions when new tables are created.
✅ Less maintenance compared to granting access to individual tables.
*/

 grant select on schema :: dbo to guest  --give permission to guest to read all the table 

------------------------------------------------------- REVOKE-----------------------------------------------------------------

Revoke select, insert, delete on emp from guest  --Assigning to individual 



---------------------------------------------------ROLE------------------------------------------------------------------------------
/*
A role in SQL Server is a way to manage permissions for multiple users efficiently. 
Instead of granting permissions to individual users, you can create a role, assign permissions to the role,
and then add users to that role. This makes permission management easier and more scalable. */

create role sales_man  --create ROLE

GRANT SELECT, INSERT, UPDATE, DELETE ON shop TO sales_man; -- grant the permission to the sale_man role

alter role sales_man  --already a user 
add member guest


--1. Before adding a user to the role, ensure that 'Amit' is already a user in the database. 
SELECT name FROM sys.database_principals WHERE type IN ('S', 'U');

--2. If ‘Amit’ is missing, create the login:
CREATE LOGIN Amit WITH PASSWORD = 'nishu';

--3. Then, create the database user:
create user amit  for login Amit

--4. Finally, add Amit to the role:
alter role sales_man   --show error as amit doesn't exist in db
add member Amit

---------------------------------------------------------------------------------------------------------------

--guest can also grant SELECT permission on emp to other users.guest get power to give same access to other
grant select on emp to guest with grant option




-----------------------------------------------TCL--------------------------------------------------------

/*
tcl is applicable to dml , ddl is auto commit
we can rollback in ddl commands like create , alter

tcl come in when dml like insert update, delete 
*/

--------------------------------------------------------- ROLLBACK-----------------------------------------------------------------------
select * from emp


SELECT e_id, salary FROM emp WHERE e_id = 11;

begin tran a  -- 1.Any changes made after this statement will be part of this transaction and won’t be committed immediately.
Update emp  set salary = 0 where e_id = 11 --2. The salary of employee with e_id = 11 is temporarily updated to 0.However, since the transaction is still active, the change is not yet permanently saved in the database.
SELECT e_id, salary FROM emp WHERE e_id = 11; --##### Before ROLLBACK TRAN a;, it will show salary = 0.


rollback tran a --3.Rolls back (undoes) all changes made since the BEGIN TRAN a.
SELECT e_id, salary FROM emp WHERE e_id = 11; --#####After ROLLBACK TRAN a;, it will show salary = 50000 again.


--------------------------------------------------COMMIT-----------------------------------------------------

begin tran a 
Update emp  set salary = 90000 where e_id = 23 
commit  tran a --once it commit then no reback to previous.The change is now permanent in the database.
 
rollback tran a  --Once a transaction is committed, it cannot be rolled back.

SELECT e_id, salary FROM emp WHERE e_id = 23; 

--✅ You can only roll back uncommitted transactions.
--✅ Once committed, changes are permanent and cannot be undone using ROLLBACK.


----------------------------------------------SAVE----------------------------------------------------
--SAVEPOINT is not supported in sql serve , instead it use save

BEGIN Tran a

UPDATE emp SET salary = 50000 WHERE e_id = 1
SAVE s1  
rollback 



----------------

BEGIN TRANSACTION;  -- Start a transaction

UPDATE emp SET salary = 0 WHERE e_id = 1;  
SAVE TRANSACTION sp1;  -- Savepoint created

UPDATE emp SET salary = 0 WHERE e_id = 2;  
SAVE TRANSACTION sp2;  -- Another savepoint

UPDATE emp SET salary = 0 WHERE e_id = 3;  
SAVE TRANSACTION sp3;  -- Third savepoint

-- Suppose we made a mistake in the last update
ROLLBACK TRANSACTION sp2;  -- Undo changes after sp2 (e_id = 3 update is undone)
ROLLBACK TRANSACTION sp1;  -- Undo changes after sp1 (e_id = 2 update is undone)

COMMIT TRANSACTION;  -- Finalize the remaining changes

SELECT * FROM emp where e_id in (1,2,3)
