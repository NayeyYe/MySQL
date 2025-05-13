/*source D:/prepare.sql; */

/*以管理员身份启动控制台*/

/* cd "c:\Program Files\MySQL\MySQL Server 8.0\bin" */

/* net start mysql80 */	/*启动mysql80服务*/

/* net stop mysql80 */	/*停止mysq80服务*/

/* mysql -u root -p */	/*登录mysql*/

/*    建库    */

drop database if exists yggl;

create database if not exists yggl;

USE yggl;


/*    建表    */

/*    创建部门表    */
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



/*数据录入*/

/*插入部门数据*/
insert into Departments 
	values('1','财务部',null),
	('2','人力资源部',null),
	('3','经理办公室',null),
	('4','研发部',null),
	('5','市场部',null)
;

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
	('504209','陈林琳','大专','1969-9-3',0,5,'汉中路120-4-12','84468158','4')
;

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
	('102208',1980,100)
;