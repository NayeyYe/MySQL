# -------------------数据库及表结构------------------
# 创建数据库 whu2024，默认字符集为 gbk，默认排序规则为 gbk_bin。
create database whu2024
    default character set gbk
    default collate gbk_bin;

# 在数据库 whu2024 中按以下结构创建表 Departments。
create table Departments(
    DepartmentID int primary key auto_increment comment'部门编号',
    DepartmentName varchar(50) not null unique comment '部门名称',
    Note text null comment '部门介绍'
);

# 在数据库 whu2024 中按以下结构创建表 Employees
create table Employees(
    EmployeeID int primary key auto_increment comment '雇员编号',
    DepartmentID int not null comment '部门编号',
    Name varchar(20) not null comment '姓名',
    Salary float not null default 0 comment '收入',
    Edate date null comment '入职日期'
);

# ------------------表记录操作--------------------------
# 用一条语句向 department 表中插入以下两条记录：101, 新数学学院；108, 文学院
insert into Departments (DepartmentID, DepartmentName)values
    (101, '新数学学院'),
    (108, '文学院');

# 将 stu 表中 stuid 为‘20191001’学生的 favorite 字段值改为“音乐，舞蹈”
update stu s set s.favorite = '音乐,舞蹈' where s.stuid = 20191001;

# 从 department 表中删除 id 为’101’的数据。
desc department;
delete from department where departmentId = 101;

# ------------------数据查询--------------------------
# 查询成绩表的学号、课程代码、等级，其中等级根据成绩判断，大于
# 等于 80 显示“优秀”、[60,80）显示“及格”，其他显示“不及格”，且标题分别为学号、课程代码、等级。

show databases ;
use exam2024;
desc score;
select stuid as 学号, courseid as 课程代码,
    case
        when score >= 80 then '优秀'
        when score between 60 and 80 then '及格'
        else '不及格'
    end as 等级
from score;

# 按学号降序从学生表中查询第二条到第四条记录的学号和姓名。
select * from stu order by stuid desc limit 1, 3;

# 计算每个学生的平均成绩，显示平均成绩大于等于 85 的学生姓名、
# 所在学院名称和平均成绩，并按平均成绩从高到低排序
select stu.name as 姓名, d.name as 学院名称, AVG(score.score) as 平均成绩
from stu
    join department d on stu.departmentId = d.departmentId
    join score on score.stuid = stu.stuid
group by stu.stuid
having 平均成绩 >= 85
order by 平均成绩 desc;

# 查询同时选修了“数学”和“政治”课的学生学号和姓名
desc stu;
show tables ;
desc course;
desc score;

select stuid, name
from stu
where stuid in (
    select score.stuid
    from score
        join course on score.courseid = course.courseid
    where course.name = '数学')
and stuid in (
    select score.stuid
    from score
        join course on score.courseid = course.courseid
    where course.name = '政治'
);
desc score;
select stu.stuid, stu.name
from stu
where stu.stuid in (
    select stuid from score group by stuid having count(*)>=3
    );

# 创建存储过程 stuidToAvg，根据输入的学号，计算该生所有课程的平均成绩，
# 并以输出参数的形式返回计算结果。若学号不存在，输出-1。
# 调用存储过程，计算 20201001 号学生的平均成绩。
DELIMITER //
CREATE PROCEDURE stuidToAvg(
    IN p_stuid CHAR(8),
    OUT p_avg DECIMAL(5,2)
)
BEGIN
    SELECT AVG(score) INTO p_avg
    FROM score
    WHERE stuid = p_stuid;

    IF p_avg IS NULL THEN
        SET p_avg = -1;
    END IF;
END //
DELIMITER ;

-- 调用存储过程
CALL stuidToAvg('20201001', @avg);
SELECT @avg;  -- 输出结果：77.25

# 创建存储函数 queryScore，根据输入的学生姓名和课程名称，查询该名学生
# 该课程的成绩。若有同名的学生，只返回成绩最高的一个学生的成绩，找不到返
# 回-1。
# 调用存储函数，查询“许和雅”的“数学”课的成绩，写出计算结果。
DELIMITER //
CREATE FUNCTION queryScore(
    p_name VARCHAR(20),
    p_course VARCHAR(20)
)
    RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE v_score INT;

    SELECT MAX(sc.score) INTO v_score
    FROM score sc
             JOIN stu s ON sc.stuid = s.stuid
             JOIN course c ON sc.courseid = c.courseid
    WHERE s.name = p_name AND c.name = p_course;

    RETURN IFNULL(v_score, -1);
END //
DELIMITER ;

-- 调用函数
SELECT queryScore('许和雅', '数学');  -- 输出结果：85