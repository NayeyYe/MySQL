use test2023;
drop table student;
create table student
(s_id int primary key comment '学号',
 s_name varchar(20) not null comment '姓名',
 sex enum('0','1') not null comment '性别'
);

drop table course;
create table course
(c_id int primary key comment '课程编号',
 c_name char(20) not null comment '课程名称'
);

drop table score;
create table score
(s_id int not null comment '学号',
 c_id int not null comment '课程编号',
 score1 int comment '成绩1',
 score2 int comment '成绩2'
);


insert into student values
(901,'张军','0'),
(902,'张超','0'),
(903,'张美美','1'),
(904,'李五一','0'),
(905,'王芳','1'),
(906,'王桂','1');


insert into course values
(1,'数据结构'),(2,'C语言程序设计'),(3,'数据库技术'),(4,'Python语言程序设计'),(5,'人工智能');


insert into score(c_id, s_id, score1, score2) values
(1,901,80,98),(1,902,78,80),(1,903,60,65),(1,904,90,88),(1,905,80,80),(1,906,90,80),
(2,901,82,91),(2,902,77,83),(2,903,67,68),(2,904,91,82),(2,905,80,85),(2,906,90,70),
(3,901,78,88),(3,902,56,66),(3,903,60,75),(3,904,93,80),(3,905,89,80),(3,906,97,81),
(4,901,90,78),(4,902,68,60),(4,903,70,65),(4,904,90,81),(4,906,95,85),
(5,901,80,68),(5,902,98,80),(5,904,90,84),(5,906,98,83)
;
