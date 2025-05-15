# ----------------------二、数据库及表结构---------------------

# 创建数据库 whu2024，默认字符集为 gbk，默认排序规则为 gbk_bin。
create database whu2024
    default character set gbk
    default collate gbk_bin;

use whu2024;
# 在数据库 whu2024 中按以下结构创建表 Departments。
create table Departments(
    DepartmentID int auto_increment comment '部门编号',
    DepartmentName varchar(50) not null unique comment '部门名称',
    Note text null comment '部门介绍',
    primary key (DepartmentID)
);

# 在数据库 whu2024 中按以下结构创建表 Employees，其中。
create table Employees (
    EmployeeID int auto_increment comment '雇员编号',
    DepartmentID int not null comment '部门编号',
    Name varchar(20) not null comment '姓名',
    Salary float not null default 0 comment '收入',
    Edate date null comment '入职日期',
    primary key (EmployeeID),
    foreign key (DepartmentID) references Departments(DepartmentID)
);

# ----------------------------三、表记录操作------------------------

# 用命令完成以下操作，将所使用的命令写在答题纸上，若出现错误，写下错
# 误编号，并分析出现错误的原因

use exam2024;
insert into department(departmentId, name) VALUES
    (101, '新数学学院'),
    (108, '文学院');
# [2025-05-15 11:14:33] [23000][1062] Duplicate entry '101' for key 'department.PRIMARY'

# 将 stu 表中 stuid 为‘20191001’学生的 favorite 字段值改为“音乐，舞蹈”。
update stu set favorite = '音乐,舞蹈' where stuid='20191001';

# 从 department 表中删除 id 为’101’的数据。
delete from department where departmentId = '101';

# --------------------------四、数据查询---------------------------
use exam2024;
show tables ;
desc score;
# 查询成绩表的学号、课程代码、等级，其中等级根据成绩判断，大于
# 等于 80 显示“优秀”、[60,80）显示“及格”，其他显示“不及格”，且标题分别为学
# 号、课程代码、等级。
select stuid as 学号, courseid as 课程代码, (
    case
        when score >= 80 then '优秀'
        when score between 60 and 80 then '及格'
        else '不及格'
    end
    ) as 等级 from score;

# 按学号降序从学生表中查询第二条到第四条记录的学号和姓名。
select stuid, name from stu order by stuid desc limit 1, 3;

# 计算每个学生的平均成绩，显示平均成绩大于等于 85 的学生姓名、所
# 在学院名称和平均成绩，并按平均成绩从高到低排序

desc score;
desc stu;
desc course;
desc department;
select stu.name, d.name, avg(score.score) as 平均成绩
from stu
    join score on score.stuid = stu.stuid
    join department d on stu.departmentId = d.departmentId
group by stu.stuid
having avg(score.score) >= 85
order by avg(score.score) desc ;

select stuid, name from stu
where stuid in (select stuid from score where courseid = (
                select courseid from course where name = '数学')) and
    stuid in (select stuid from score where courseid = (
        select courseid from course where name = '政治'));

select stu.stuid, count(score.courseid) from stu
    join score where score.stuid = stu.stuid
group by stu.stuid
having count(score.courseid) >= 3;

desc score;
use exam2024;
drop procedure stuidToAvg;
delimiter //
create procedure stuidToAvg(in stuid char(8), out avg_score float)
begin
    select avg(score) into avg_score from score where score.stuid = stuid;
end //
delimiter ;

call stuidToAvg(20201001, @avg_score);
select @avg_score;
desc course;
drop function queryScore;
set global log_bin_trust_function_creators = TRUE;
delimiter //
create function queryScore(name varchar(8), course_name varchar(8))
    returns int
    reads sql data
begin
    declare grade int;
    select score into grade from score
        where score.stuid = (select stu.stuid from stu where stu.name=name) and
              score.courseid = (select course.courseid from course where course.name = course_name)
    order by score desc limit 1;
    return grade;
end //
delimiter ;

select queryScore('许和雅', '数学');
