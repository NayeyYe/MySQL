use yggl;

-- 连接B
## 3)在另一个连接B中，取消自动提交set @@autocommit=0，在employees表插入一条记录
set @@autocommit = 0;
insert into employees values ('999999','测试','博士',
                              '1990-01-01',1,5,
                              '测试地址','12345678','1');

-- 连接B
## 5)在连接B中回滚事务
ROLLBACK;


# ------------------------
# 2.观察 @@transaction_isolation 设置为 read-commited时，不可重复读的情况

-- 连接B
## 3)在另一个连接B中，自动提交set @@autocommit=0，在employees表插入一条记录
SET @@autocommit = 0;
INSERT INTO employees VALUES ('999999','测试','博士','1990-01-01',1,5,'测试地址','12345678','1');

-- 连接B
## 5)在连接B中回滚事务
ROLLBACK;

-- 连接B
## 7)在另一个连接B中，在employees表再插入记录，并提交
INSERT INTO employees VALUES ('999999','测试','博士','1990-01-01',1,5,'测试地址','12345678','1');
COMMIT;

# ------------------------
# 3.观察 transaction_isolation 设置为 repeatable read时，幻读的情况

-- 连接B
## 3)在另一个连接B中，自动提交set @@autocommit=1，在employees表插入一条记录
SET @@autocommit = 1;
INSERT INTO employees VALUES ('888888','测试2','硕士','1995-05-05',0,2,'新地址','87654321','2');


# ------------------------
# 4.观察 transaction isolation 设置为 serializable时的情况
-- 连接B尝试插入会被阻塞
## 3)在另一个连接B中，在employees表插入一条记录，并提交事务，观察执行情况
# INSERT INTO employees VALUES ('777777','测试3','本科','2000-01-01',1,1,'地址3','11223344','3');


