 ```sql
 use test;
 ```



1. **查询成绩表中的最高分和平均分**
```sql
SELECT MAX(score) AS 最高分, AVG(score) AS 平均分 FROM score;
```

2. **查询学生的学号、姓名和出生日期，按院系编号降序**
```sql
SELECT id AS 学号, name AS 姓名, birthday AS 出生日期 
FROM stu 
ORDER BY departmentId DESC;
```

3. **查询所有学生的学号、姓名和院系名**
```sql
SELECT stu.id AS 学号, stu.name AS 姓名, department.name AS 院系名 
FROM stu 
JOIN department ON stu.departmentId = department.id;
```

4. **查询参加高等数学课程考试的学生姓名和成绩**  
```sql
SELECT stu.name AS 姓名, score.score AS 考试成绩 
FROM score 
JOIN lesson ON score.LessonId = lesson.lessonid 
JOIN stu ON score.stuId = stu.id 
WHERE lesson.lessonName = '数学';
```

5. **查询每个学院的学生人数**
```sql
SELECT department.name AS 院系名, COUNT(stu.id) AS 学生人数 
FROM department 
LEFT JOIN stu ON department.id = stu.departmentId 
GROUP BY department.id;
```

6. **查询平均分最高的前5名学生**
```sql
SELECT stu.id AS 学号, stu.name AS 姓名, AVG(score.score) AS 平均分 
FROM stu 
JOIN score ON stu.id = score.stuId 
GROUP BY stu.id 
ORDER BY 平均分 DESC 
LIMIT 5;
```

7. **查询总学分高于10分的学生**  
（假设同一课程学分不重复累加）
```sql
SELECT stu.id AS 学号, stu.name AS 姓名, SUM(DISTINCT lesson.xf) AS 总学分 
FROM stu 
JOIN score ON stu.id = score.stuId 
JOIN lesson ON score.LessonId = lesson.lessonid 
GROUP BY stu.id 
HAVING 总学分 > 10;
```

8. **查询数学学院学生的成绩和等级，按成绩排序**  
```sql
SELECT stu.id AS 学号, stu.name AS 姓名, score.score AS 成绩, grade.grade AS 等级 
FROM stu 
JOIN score ON stu.id = score.stuId 
JOIN department ON stu.departmentId = department.id 
JOIN grade ON score.score BETWEEN grade.lowScore AND grade.highScore 
WHERE department.id = '101' 
ORDER BY score.score DESC;
```

9. **查询数学学院学生的总学分，按学分排序**
```sql
SELECT stu.id AS 学号, stu.name AS 姓名, SUM(DISTINCT lesson.xf) AS 总学分 
FROM stu 
JOIN score ON stu.id = score.stuId 
JOIN lesson ON score.LessonId = lesson.lessonid 
WHERE stu.departmentId = '101' 
GROUP BY stu.id 
ORDER BY 总学分 DESC;
```

10. **查询英语成绩最高的学生及其所有成绩**  
```sql
SELECT stu.id AS 学号, stu.name AS 姓名, lesson.lessonName AS 课程, score.score AS 成绩, department.name AS 学院 
FROM stu 
JOIN score ON stu.id = score.stuId 
JOIN lesson ON score.LessonId = lesson.lessonid 
JOIN department ON stu.departmentId = department.id 
WHERE stu.id = (
    SELECT stuId 
    FROM score 
    JOIN lesson ON score.LessonId = lesson.lessonid 
    WHERE lesson.lessonName = '英语' 
    ORDER BY score.score DESC 
    LIMIT 1
);
```