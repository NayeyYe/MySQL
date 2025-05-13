use yggl;
show tables ;
desc employees;
# 存储函数
# （1）创建一个存储函数，返回员工的总人数。
DELIMITER $$

DROP FUNCTION IF EXISTS get_employee_count;
CREATE FUNCTION get_employee_count()
    RETURNS INT
    READS SQL DATA
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Employees;
    RETURN total;
END $$

DELIMITER ;

select get_employee_count();


# （2）创建一个存储函数，删除在 Salary 表中有但在 Employees 表中
# 不存在的员工号。若在 Employees 表中存在则返回 FALSE，若不存在
# 则删除该员工号并返回 TRUE。
desc employees;
desc salary;

delimiter //

DROP FUNCTION if exists delete_orphan_employee;
set global log_bin_trust_function_creators=TRUE;
create function delete_orphan_employee(id char(6))
    returns boolean
    modifies sql data
begin
    declare emp_exists boolean default false;
    declare emp_num int;

    select count(*) into emp_num from employees where id = EmployeeID;
    if emp_num = 0 then
        delete from salary where id = EmployeeID;
        set emp_exists = TRUE;
    end if;
    return emp_exists;
end //
delimiter ;
select * from employees;
select delete_orphan_employee(102208);

show tables ;
desc employees;
delimiter //

drop function if exists delete_orphan_employees;

set global log_bin_trust_function_creators = TRUE;

create function delete_orphan_employees()
    returns boolean
    modifies sql data
begin
    declare orphan_employee int;
    select count(EmployeeID) into orphan_employee from salary where EmployeeID not in (
        select EmployeeID from employees
    );

    if orphan_employee != 0 then return FALSE;
    else
        delete from salary where EmployeeID not in (
            select EmployeeID from employees);
        return TRUE;
    end if;

end //
delimiter ;
select delete_orphan_employees();
# （3）创建存储函数，判断员工是否在研发部工作，若是则返回其学历，若不是则返回字符串“NO”。
show tables ;
desc employees;
desc departments;
select * from departments;
select * from employees;
delimiter //
drop function if exists CheckResearchDept;
set global log_bin_trust_function_creators = TRUE;
create function if not exists CheckResearchDept(emp_id char(6))
    returns VARCHAR(255)
    reads sql data
begin
    declare edu char(4);
    declare dept_name char(20);

    select e.Education, d.DepartmentName into edu, dept_name
    from employees e
        join departments d on e.DepartmentID = d.DepartmentID
    where e.EmployeeID = emp_id;

    IF dept_name = '研发部' THEN
        RETURN edu;
    ELSE
        RETURN 'NO';
    END IF;
end //

delimiter ;

select CheckResearchDept('302566');
select EmployeeID, Name from employees where DepartmentID = 4;
# （4）创建一个存储函数，将工作时间满 4 年的员工收入增加 500 元。

drop procedure if exists IncreaseSalaryForFourYears;
delimiter //
create procedure if not exists IncreaseSalaryForFourYears()
begin
    update salary s
        join employees e on s.EmployeeID = e.EmployeeID
    set s.InCome = s.InCome + 500
    where e.WorkYear >= 4;
end //
delimiter ;

select * from salary;
call IncreaseSalaryForFourYears();


# 2. 触发器
## 创建触发器，在 Employees 表中删除员工信息的同时将 Salary表中该员工的信息删除，以确保数据完整性。
## 创建完后删除 Employees 表中的一行数据，然后查看 Salary 表中的变化情况。
drop trigger if exists AfterEmployeeDelete;
delimiter //
create trigger if not exists AfterEmployeeDelete
    after delete on employees
    for each row
begin
    delete from salary where salary.EmployeeID = OLD.EmployeeID;
end //
delimiter ;

delete from employees where EmployeeID = 000001;
select * from salary;
select * from employees;

## 假设 Departments2 表和 Department 表的结构和内容都相同，
# 在 Departments 上创建一个触发器，
# 如果添加一个新的部门，该部门也会添加到 Departments2 表中。
create table departments2 like departments;
show tables ;
desc departments;
drop trigger if exists AfterDepartmentInsert;
delimiter //
CREATE trigger if not exists AfterDepartmentInsert
    AFTER INSERT ON Departments
    FOR EACH ROW
begin
    INSERT into departments2(DepartmentID, DepartmentName, Note)
        VALUES (NEW.DepartmentID, NEW.DepartmentName, NEW.Note);
end //
delimiter ;

insert into departments values (6, '学习部', null);
select * from departments;
delete from departments where DepartmentID=6;

## 创建触发器，当修改 Employees 表时，
# 若将 Employees 表中员工的工作时间增加 1 年，则将收入增加 500 元，
# 若工作时间增加 2 年则收入增加 1000 元，
# 依次增加。若工作时间减少则无变化。
drop trigger if exists UpdateSalaryOnWorkYearIncrease;
delimiter //
create trigger if not exists UpdateSalaryOnWorkYearIncrease
    after update on employees
    for each row
begin
    declare diff int;
    set diff = NEW.WorkYear - OLD.WorkYear;

    if diff > 0 then
        update salary s
        set s.InCome = s.InCome + (diff * 500)
        where EmployeeID = NEW.EmployeeID;
    end if;
end //

delimiter ;

## 创建触发器，
# 当 Departments 表中部门发生变化时，
# Employees表中对应部门员工所属的部门也将改变。
delimiter //
create trigger AfterDepartmentUpdate
    after update on departments
    for each row
BEGIN
    UPDATE employees
    set DepartmentID = NEW.DepartmentID
    where DepartmentID = OLD.DepartmentID;
end //
delimiter ;

# 3. 事件
## 创建表eventlog,含3个字段:
## log_id int 自增长 主键;
## event_type int;
## log_time datetime。
create table eventlog(
    log_id int auto_increment primary key ,
    event_type int,
    log_time datetime);

# (1)创建一个立即执行的事件。
create event EventImmediate
    on schedule
    at current_timestamp
do
    insert into eventlog(event_type, log_time) values (1, NOW());

# (2)创建一个事件，每2分钟执行一次，它从现在开始直到 2025 年 12 月31日结束。
create event EventEveryTwoMinutes
    on schedule
        every 2 minute
        ends '2025-12-31 23:59:59'
do
    insert into eventlog(event_type, log_time) VALUES (2, now());

# (3)创建一个 2025 年 4 月 3 日下午 5 点执行的事件。
create event EventSpecificTime
    on schedule
        at '2025-05-10 21:05:00'
do
    insert into eventlog(event_type, log_time) values (3, now());

show events ;