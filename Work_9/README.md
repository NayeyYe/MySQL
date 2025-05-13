### **用户管理**

1. **创建用户 user_1 和 user_2**
   ```sql
   CREATE USER 'user_1'@'localhost' IDENTIFIED BY '1234';
   CREATE USER 'user_2'@'localhost' IDENTIFIED BY '1234';
   ```

2. **将 user_2 重命名为 user_3**
   ```sql
   RENAME USER 'user_2'@'localhost' TO 'user_3'@'localhost';
   ```

3. **修改 user_3 的密码为 123456**
   
   ```sql
   ALTER USER 'user_3'@'localhost' IDENTIFIED BY '123456';
   ```
   
4. **删除 user_3**
   ```sql
   DROP USER 'user_3'@'localhost';
   ```

5. **以 user_1 登录并切换到 mydb 数据库**  
   
   ```bash
   # 退出 MySQL，以 user_1 重新登录
   mysql -u user_1 -p
   ```
   ```sql
   CREATE DATABASE mydb;
   USE mydb; -- 若 mydb 不存在会报错，建议替换为 USE yggl;
   ```

---

### **权限管理**
1. **授予 user_1 对 Employees 表的查询权限**
   ```sql
   GRANT SELECT ON yggl.Employees TO 'user_1'@'localhost';
   ```

2. **以 user_1 测试权限**  
   - 查询数据（成功）：
     ```sql
     SELECT * FROM yggl.Employees;
     ```
   - 插入数据（失败，无 INSERT 权限）：
     ```sql
     INSERT INTO yggl.Employees VALUES ('999999', '测试', '本科', '2000-01-01', '男', 1, '地址', '123456', '1');
     ```

3. **授予 user_1 更多权限并查看权限**
   ```sql
   GRANT INSERT, UPDATE, DELETE ON yggl.Employees TO 'user_1'@'localhost';
   SHOW GRANTS FOR 'user_1'@'localhost';
   ```

4. **以 user_1 再次测试插入数据**  
   （此时应成功）：
   ```sql
   INSERT INTO yggl.Employees VALUES ('999999', '测试', '本科', '2000-01-01', '男', 1, '地址', '123456', '1');
   ```

5. **撤销 user_1 的 SELECT 权限**
   ```sql
   REVOKE SELECT ON yggl.Employees FROM 'user_1'@'localhost';
   ```

6. **以 user_1 测试查询（失败）**
   ```sql
   SELECT * FROM yggl.Employees; -- 无权限
   ```

7. **撤销 user_1 所有权限**
   ```sql
   REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'user_1'@'localhost';
   ```

---

### **角色管理**
1. **创建用户 user_3 和 user_4**
   ```sql
   CREATE USER 'user_3'@'localhost' IDENTIFIED BY '1234';
   CREATE USER 'user_4'@'localhost' IDENTIFIED BY '1234';
   ```

2. **创建角色并授予权限**
   ```sql
   CREATE ROLE db_read, db_write;
   GRANT SELECT ON yggl.* TO db_read;
   GRANT INSERT, UPDATE, DELETE, SELECT ON yggl.* TO db_write;
   ```

3. **分配角色并激活**
   ```sql
   GRANT db_read TO 'user_3'@'localhost';
   GRANT db_write TO 'user_4'@'localhost';
   -- 激活角色（MySQL 8.0+）
   SET DEFAULT ROLE ALL TO 'user_3'@'localhost', 'user_4'@'localhost';
   ```

4. **验证权限**
   - **user_3**（仅 SELECT）：
     ```sql
     SELECT * FROM yggl.Employees; -- 成功
     INSERT INTO yggl.Employees VALUES (...); -- 失败
     ```
   - **user_4**（可增删改查）：
     ```sql
     INSERT INTO yggl.Employees VALUES (...); -- 成功
     ```



