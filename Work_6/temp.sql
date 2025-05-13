use yggl;
#  1. 创建存储过程p1
# 创建无参存储过程p1并调用，功能为：
# 获取 employees表中的员工人数来初始化一个局部变量，
# 如果人数小于10输出人“太少”，否则“满员”
delimiter //
create procedure p1()
begin
    declare emp_count int;
    select count(*) into emp_count from employees;

    if emp_count < 10 then
        select '人太少' as 人员状态;
    else
        select  '满员' as 人员状态;
    end if ;
end //
delimiter  ;