# 第一题

## （1）

```mysql
 # 使用命令行方式创建数据库 YGGL，创建测试数据库 test，显示数据库。
-- 创建数据库YGGL和test
CREATE DATABASE IF NOT EXISTS YGGL;
CREATE DATABASE IF NOT EXISTS test;

-- 显示所有数据库
SHOW DATABASES;
```

## （2）

```mysql
# 使用命令在 YGGL 库中创建 Employees 表、Departments 表、Salary 表。
USE YGGL;  -- 切换到YGGL数据库
# 先创建Department，防止外键错误
-- 创建Departments表
CREATE TABLE IF NOT EXISTS Departments (
                                           DepartmentID CHAR(3) NOT NULL PRIMARY KEY COMMENT '部门编号',
                                           DepartmentName CHAR(20) NOT NULL COMMENT '部门名',
                                           Note TEXT COMMENT '备注'
);


-- 创建Employees表
CREATE TABLE IF NOT EXISTS Employees (
                                         EmployeeID CHAR(6) NOT NULL PRIMARY KEY COMMENT '员工编号',
                                         Name CHAR(10) NOT NULL COMMENT '姓名',
                                         Education CHAR(4) NOT NULL COMMENT '学历',
                                         Birthday DATE NOT NULL COMMENT '出生日期',
                                         Sex CHAR(1) NOT NULL COMMENT '性别',
                                         WorkYear TINYINT COMMENT '工作时间',
                                         Address VARCHAR(20) COMMENT '地址',
                                         PhoneNumber CHAR(12) COMMENT '电话号码',
                                         DepartmentID CHAR(3) NOT NULL COMMENT '部门编号',
                                         FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);




-- 创建Salary表
CREATE TABLE IF NOT EXISTS  Salary (
                        EmployeeID CHAR(6) NOT NULL PRIMARY KEY COMMENT '员工编号',
                        FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
                        Income FLOAT NOT NULL COMMENT '收入',
                        Outcome FLOAT NOT NULL COMMENT '支出'
);

```

## （3）

```mysql
# 创建一个与 Employees 表结构相同的空表 Employees0。
CREATE TABLE IF NOT EXISTS Employees0 LIKE Employees;
```

## （4）

```mysql
# 显示 YGGL 库中的表。
SHOW TABLES;
```

## （5）

```mysql
# 删除 Employees0 表，显示 YGGL 库中的表。
DROP TABLE IF EXISTS Employees0;
SHOW TABLES;
```

## （6）

```mysql
# 删除 test 库，显示数据库。
DROP DATABASE IF EXISTS test;
SHOW DATABASES;
```

# 第二题

## （1）

```mysql
# 创建网上商城数据库 netshop。
CREATE DATABASE IF NOT EXISTS netshop
    DEFAULT CHARACTER SET gbk
    DEFAULT COLLATE gbk_chinese_ci;
```

## （2）

```mysql
-- 创建商品分类表
CREATE TABLE category (
                          TCode CHAR(3) NOT NULL PRIMARY KEY COMMENT '商品分类编码（3位，第1位大类，第2-3位子类）',
                          TName VARCHAR(8) NOT NULL COMMENT '商品分类名称'
);



-- 创建商家表
SET GLOBAL innodb_file_per_table = ON;

CREATE TABLE supplier (
                          SCode CHAR(8) NOT NULL PRIMARY KEY COMMENT '商家编码',
                          SPassWord VARCHAR(12) NOT NULL DEFAULT '888' COMMENT '商家密码',
                          SName VARCHAR(16) NOT NULL COMMENT '商家名称',
                          Sweixin VARCHAR(16) CHARACTER SET utf8mb4 NOT NULL COMMENT '微信',
                          Tel CHAR(13) NULL COMMENT '电话（手机）',
                          Evaluate DECIMAL(4, 2) DEFAULT 0.00 COMMENT '商家综合评价',
                          Slicence MEDIUMBLOB NULL COMMENT '营业执照图片'
);

-- 创建商品表
CREATE TABLE commodity (
                           Pid INT(8) NOT NULL PRIMARY KEY COMMENT '商品号',
                           TCode CHAR(3) NOT NULL COMMENT '商品分类编码',
                           SCode CHAR(8) NOT NULL COMMENT '商家编码',
                           PName VARCHAR(32) NOT NULL COMMENT '商品名称',
                           PPrice DECIMAL(7, 2) NOT NULL COMMENT '商品价格',
                           Stocks INT UNSIGNED DEFAULT 0 COMMENT '商品库存量',
                           Total DECIMAL(10, 2) GENERATED ALWAYS AS (Stocks * PPrice) COMMENT '商品金额（自动计算）',
                           TextAdv VARCHAR(32) NULL COMMENT '推广文字',
                           LivePriority TINYINT NOT NULL DEFAULT 1 COMMENT '活化情况（0=下架，1=在售，>1=优先）',
                           Evaluate DECIMAL(4, 2) DEFAULT 0.00 COMMENT '商品综合评价',
                           UpdateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录修改时间',

                           CHECK (Stocks > 0 AND PPrice > 0.00 AND PPrice < 10000.00),

                           INDEX myIdxSCode (SCode),
                           INDEX myIdxName (PName),

                           FOREIGN KEY (TCode) REFERENCES category(TCode)
                               ON DELETE RESTRICT
                               ON UPDATE RESTRICT,
                           FOREIGN KEY (SCode) REFERENCES supplier(SCode)
                               ON DELETE RESTRICT
                               ON UPDATE RESTRICT
);


-- 创建商品图片表
CREATE TABLE commodityimage (
                                Pid INT(8) NOT NULL PRIMARY KEY COMMENT '商品号',
                                Image BLOB NOT NULL COMMENT '商品图片（最大64KB）',
                                FOREIGN KEY (Pid) REFERENCES commodity(Pid)
                                    ON DELETE CASCADE
                                    ON UPDATE CASCADE
);
```

