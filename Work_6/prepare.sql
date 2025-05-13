/*source D:/prepare.sql; */

/*�Թ���Ա�����������̨*/

/* cd "c:\Program Files\MySQL\MySQL Server 8.0\bin" */

/* net start mysql80 */	/*����mysql80����*/

/* net stop mysql80 */	/*ֹͣmysq80����*/

/* mysql -u root -p */	/*��¼mysql*/

/*    ����    */

drop database if exists yggl;

create database if not exists yggl;

USE yggl;


/*    ����    */

/*    �������ű�    */
drop table if exists departments;
CREATE TABLE Departments(
	DepartmentID char(3) NOT NULL PRIMARY KEY COMMENT '���ű��',
	DepartmentName char(20) NOT NULL COMMENT '������',
	Note text NULL COMMENT '��ע'
);

/*    ����нˮ��    */
drop table if exists salary;
CREATE TABLE Salary(
	EmployeeID char(6) NOT NULL PRIMARY KEY COMMENT 'Ա�����',
	InCome float NOT NULL COMMENT '����',
	OutCome float NOT NULL COMMENT '֧��'
);

/*    ����Ա����    */
drop table if exists employees;
CREATE TABLE Employees(
	EmployeeID char(6) NOT NULL PRIMARY KEY COMMENT 'Ա�����',
	Name char(10) NOT NULL COMMENT '����',
	Education char(4) NOT NULL COMMENT 'ѧ��',
	Birthday date NOT NULL COMMENT '��������',
	Sex char(2) NOT NULL COMMENT '�Ա�',
	WorkYear tinyint(1) COMMENT '����ʱ��',
	Address char(20) NULL COMMENT '��ַ',
	PhoneNumber char(12) NULL COMMENT '�绰����',
	DepartmentID char(3) NOT NULL COMMENT '���ű��'
);



/*����¼��*/

/*���벿������*/
insert into Departments 
	values('1','����',null),
	('2','������Դ��',null),
	('3','����칫��',null),
	('4','�з���',null),
	('5','�г���',null)
;

/*����Ա������*/
insert into Employees values
	('000001','����','��ר','1966-1-23',1,8,'��ɽ·32-1-508','83355668','2'),
	('010008','���ݻ�','����','1976-3-28',1,3,'������·100-2','83321321','1'),
	('020010','������','˶ʿ','1982-12-9',1,2,'����¥10-10-108','83792361','1'),
	('020018','����','��ר','1960-7-30',0,6,'��ɽ��·102-2','83413301','1'),
	('102201','����','����','1972-10-18',1,3,'����·100-2','83606608','5'),
	('102208','�쿥','˶ʿ','1965-9-28',1,2,'��¥��5-3-106','84708817','5'),
	('108991','����','˶ʿ','1979-8-10',0,4,'��ɽ·10-3-105','83346722','3'),
	('111006','��ʯ��','����','1974-10-1',1,1,'���·34-1-203','84563418','5'),
	('210678','����','��ר','1977-4-2',1,2,'��ɽ��·24-35','83467336','3'),
	('302566','������','����','1968-9-20',1,3,'�Ⱥ�·209-3','58765991','4'),
	('308759','Ҷ��','����','1978-11-18',1,2,'������·3-7-52','83308901','4'),
	('504209','������','��ר','1969-9-3',0,5,'����·120-4-12','84468158','4')
;

/*����нˮ����*/
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