use test;
show tables ;

# 查询成绩表中的最高分和平均分
select max(grade) as 最高分, avg(grade) as 平均分 from score;

# 查询学生的学号、姓名和出生日期，按院系编号降序
select id as 学号, name as 姓名, birthday as 出生日期
from stu order by departmentId desc;

# 查询所有学生的学号、姓名和院系名
select s.id, s.name, d.name from stu s join department d on s.departmentId = d.id;

# 查询参加高等数学课程考试的学生姓名和成绩
select stu.name, lesson.lessonName, score.grade
from stu
    join score on stu.id = score.stuId
    join lesson on score.LessonId = lesson.lessonid
where lesson.lessonName = '数学';

# 查询每个学院的学生人数
desc department;
select d.name as 院系名, count(stu.id) as 学生数
from department d
    left join stu on stu.departmentId = d.id
group by d.name;

# 查询平均分最高的前5名学生
select stu.id as 学号, stu.name as  姓名, avg(score.grade) as 平均分
from stu
    join score on stu.id = score.stuId
group by stu.id
order by 平均分 desc
limit 5;

# 查询总学分高于10分的学生
select stu.id as 学号, stu.name as 姓名, sum(lesson.score) as 总学分
from stu
    join score on score.stuId = stu.id
    join lesson on  score.LessonId = lesson.lessonid
group by stu.id
having 总学分 > 10;

# 查询数学学院学生的成绩和等级，按成绩排序
select stu.id as 学号, stu.name as 姓名, score.grade as 成绩, level.grade as 等级
from stu
    join department d on stu.departmentId = d.id
    join score on score.stuId = stu.id
    join level on score.grade between level.lowScore and level.highScore
where d.name = '数学学院'
order by score.grade desc ;

# 查询数学学院学生的总学分，按学分排序
desc lesson;
select stu.id as 学号, stu.name as 姓名, sum(lesson.score) as 总学分
from stu
    join score on stu.id = score.stuId
    join lesson on score.LessonId = lesson.lessonid
group by stu.id
order by 总学分;

# 查询英语成绩最高的学生及其所有成绩
show tables ;
desc score;
desc lesson;
select stu.id AS 学号, stu.name AS 姓名, lesson.lessonName AS 课程, score.grade AS 成绩
from stu
    join score on score.stuId = stu.id
    join lesson on lesson.lessonid = score.LessonId
where stu.id = (
    select stuId
    from score
        join lesson on score.LessonId = lesson.lessonid
    where lessonName = '英语'
    order by score.grade desc
    limit 1
    );
