drop database if exists yggl;
create database if not exists yggl;

use yggl;

drop table if exists departments;
CREATE TABLE Departments(
                            DepartmentID char(3) NOT NULL PRIMARY KEY COMMENT '部门编号',
                            DepartmentName char(20) NOT NULL COMMENT '部门名',
                            Note text NULL COMMENT '备注'
);

/*    创建薪水表    */
drop table if exists salary;
CREATE TABLE Salary(
                       EmployeeID char(6) NOT NULL PRIMARY KEY COMMENT '员工编号',
                       InCome float NOT NULL COMMENT '收入',
                       OutCome float NOT NULL COMMENT '支出'
);

/*    创建员工表    */
drop table if exists employees;
CREATE TABLE Employees(
                          EmployeeID char(6) NOT NULL PRIMARY KEY COMMENT '员工编号',
                          Name char(10) NOT NULL COMMENT '姓名',
                          Education char(4) NOT NULL COMMENT '学历',
                          Birthday date NOT NULL COMMENT '出生日期',
                          Sex char(2) NOT NULL COMMENT '性别',
                          WorkYear tinyint(1) COMMENT '工作时间',
                          Address char(20) NULL COMMENT '地址',
                          PhoneNumber char(12) NULL COMMENT '电话号码',
                          DepartmentID char(3) NOT NULL COMMENT '部门编号'
);

insert into Departments
values('1','财务部',null),
      ('2','人力资源部',null),
      ('3','经理办公室',null),
      ('4','研发部',null),
      ('5','市场部',null);

/*插入员工数据*/
insert into Employees values
                          ('000001','王林','大专','1966-1-23',1,8,'中山路32-1-508','83355668','2'),
                          ('010008','伍容华','本科','1976-3-28',1,3,'北京东路100-2','83321321','1'),
                          ('020010','王向蓉','硕士','1982-12-9',1,2,'四牌楼10-10-108','83792361','1'),
                          ('020018','李丽','大专','1960-7-30',0,6,'中山东路102-2','83413301','1'),
                          ('102201','刘明','本科','1972-10-18',1,3,'虎踞路100-2','83606608','5'),
                          ('102208','朱骏','硕士','1965-9-28',1,2,'牌楼巷5-3-106','84708817','5'),
                          ('108991','钟敏','硕士','1979-8-10',0,4,'中山路10-3-105','83346722','3'),
                          ('111006','张石兵','本科','1974-10-1',1,1,'解放路34-1-203','84563418','5'),
                          ('210678','林涛','大专','1977-4-2',1,2,'中山北路24-35','83467336','3'),
                          ('302566','李玉珉','本科','1968-9-20',1,3,'热河路209-3','58765991','4'),
                          ('308759','叶凡','本科','1978-11-18',1,2,'北京西路3-7-52','83308901','4'),
                          ('504209','陈林琳','大专','1969-9-3',0,5,'汉中路120-4-12','84468158','4');


/*插入薪水数据*/
insert into Salary values
                       ('000001',2100.8,123.09),
                       ('010008',1582.62,88.03),
                       ('102201',2569.88,185.65),
                       ('111006',1987.01,79.58),
                       ('504209',2066.15,108),
                       ('302566',2980.7,210.2),
                       ('108991',3259.98,281.52),
                       ('020010',2860,198),
                       ('020018',2347.68,180),
                       ('308759',2531.98,199.08),
                       ('210678',2240,121),
                       ('102208',1980,100);


# (1)
# 查询每个员工的所有数据，查询 Departments 表和 Salary 表的所有数据
select * from Departments;
select * from salary;

# (2)
# 查询每个员工的姓名、地址和电话号码
desc Employees;
select Name, Address, PhoneNumber from Employees;

# (3)
# 查询 Employees 表中的部门号和性别，要求消除重复的行
desc Employees;
select distinct Departments.DepartmentName, Employees.Sex
from Employees
    join departments on Employees.DepartmentID = Departments.DepartmentID;

# (4)
# 查询EmployeeID为000001的员工地址和电话
desc employees;
select Address, PhoneNumber from employees where EmployeeID='000001';

# (5)
# 查询月收入高于2000元的员工号、姓名和收入
select Employees.EmployeeID, Employees.Name, salary.income
from employees
    join Salary on Employees.EmployeeID = Salary.EmployeeID
where Salary.InCome > 2000;


# (6)
# 查询1970年以后出生的员工的姓名和住址
desc Employees;
select Name, Address from Employees
where Birthday > '19701231';

# (7)
# 查询财务部的所有员工的员工号和姓名
select Employees.Name, Employees.EmployeeID
from Employees
    join departments on Employees.DepartmentID = Departments.DepartmentID
where DepartmentName = '财务部';

# (8)
# 查询女员工的地址和电话（标题设为“地址”和“电话”）
select Address as 地址, PhoneNumber as 电话
from Employees
where Sex = '0';

# (9)
# 查询员工的姓名和性别（1显示“男”，0显示“女”）
SELECT Name,
       CASE
           WHEN Sex = '1' THEN '男'
           WHEN Sex = '0' THEN '女'
       END AS 性别
FROM Employees;

# (10)
# 查询员工的姓名、住址和收入水平分类
select e.Name, e.Address,
    CASE
        WHEN s.InCome < 2000 THEN '低收入'
        WHEN s.InCome >= 2000 AND s.InCome < 3000 THEN '中等收入'
        ELSE '高收入'
    END AS 收入水平
from Employees e
    join Salary S on e.EmployeeID = S.EmployeeID;

# (11)
# 计算每个员工的实际收入
SELECT e.EmployeeID, e.Name, (s.InCome - s.OutCome) AS 实际收入
FROM Employees e
         JOIN Salary s ON e.EmployeeID = s.EmployeeID;

# (12)
# 获取员工人数
SELECT count(*) AS 员工个数 from employees;

# (13)
# 计算月收入的平均值
SELECT AVG(InCome) AS 平均月收入 FROM Salary;

# (14)
# 计算所有员工的总收入
SELECT SUM(InCome) AS 总收入 FROM Salary;

# (15)
# 查询财务部员工的最高和最低实际收入
desc salary;
select max(s.InCome - s.OutCome), min(s.InCome - s.OutCome)
from salary s
    join Employees e on s.EmployeeID = e.EmployeeID
    join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName = '财务部';

# (16)
# 查询姓“王”的员工的姓名和部门号
SELECT Name, DepartmentID FROM Employees WHERE Name LIKE '王%';

# (17)
# 查询员工号倒数第二位为0的员工
SELECT EmployeeID, Name FROM Employees WHERE EmployeeID LIKE '%0_';

# (18)
# 查询地址含“中山”的员工的ID和部门号
SELECT EmployeeID, DepartmentID FROM Employees WHERE Address LIKE '%中山%';

# (19)
# 查询收入在2000~3000元的员工的ID和姓名
SELECT e.EmployeeID, e.Name
FROM Employees e
         JOIN Salary s ON e.EmployeeID = s.EmployeeID
WHERE s.InCome BETWEEN 2000 AND 3000;

# (20)
# 查询部门号为1或3的员工的ID和姓名
select e.EmployeeID as 员工ID, e.Name, d.DepartmentName, d.DepartmentID
from employees e
    join departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentID in ('1', '3');