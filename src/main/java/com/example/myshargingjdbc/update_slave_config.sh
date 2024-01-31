#!/bin/bash

# Restart MySQL containers using Docker
docker restart atguigu-mysql-master
docker restart atguigu-mysql-slave1
docker restart atguigu-mysql-slave2

# Sleep for a moment to allow containers to restart
sleep 10

# MySQL 主库信息
MASTER_HOST="192.168.184.134"
MASTER_PORT="3306"
MASTER_USER="root"
MASTER_PASSWORD="123456"

# MySQL 从库信息
SLAVE_HOST1="192.168.184.134"
SLAVE_PORT1="3307"
SLAVE_USER="root"
SLAVE_PASSWORD="123456"

SLAVE_HOST2="192.168.184.134"
SLAVE_PORT2="3308"

# 连接到主库获取当前二进制日志信息
master_conn=$(mysql -h $MASTER_HOST -P $MASTER_PORT -u $MASTER_USER -p$MASTER_PASSWORD -e "SHOW MASTER STATUS\G")
log_file=$(echo "$master_conn" | grep "File" | awk '{print $2}')
log_pos=$(echo "$master_conn" | grep -E "Position|Exec_Master_Log_Pos" | awk '{print $2}')

echo $log_file

# 连接到第一个从库更新配置
slave_conn=$(mysql -h $SLAVE_HOST1 -P $SLAVE_PORT1 -u $SLAVE_USER -p$SLAVE_PASSWORD -e "STOP SLAVE; CHANGE MASTER TO MASTER_LOG_FILE='$log_file', MASTER_LOG_POS=$log_pos; START SLAVE;")
# 检查第一个从库同步状态
slave_status=$(mysql -h $SLAVE_HOST1 -P $SLAVE_PORT1 -u $SLAVE_USER -p$SLAVE_PASSWORD -e "SHOW SLAVE STATUS\G")
slave_io_running=$(echo "$slave_status" | grep "Slave_IO_Running" | awk '{print $2}')
slave_sql_running=$(echo "$slave_status" | grep "Slave_SQL_Running" | awk '{print $2}')
# 输出第一个从库同步状态
echo "Slave 1 IO Running: $slave_io_running"
echo "Slave 1 SQL Running: $slave_sql_running"

# 连接到第二个从库更新配置
slave_conn=$(mysql -h $SLAVE_HOST2 -P $SLAVE_PORT2 -u $SLAVE_USER -p$SLAVE_PASSWORD -e "STOP SLAVE; CHANGE MASTER TO MASTER_LOG_FILE='$log_file', MASTER_LOG_POS=$log_pos; START SLAVE;")
# 检查第二个从库同步状态
slave_status=$(mysql -h $SLAVE_HOST2 -P $SLAVE_PORT2 -u $SLAVE_USER -p$SLAVE_PASSWORD -e "SHOW SLAVE STATUS\G")
slave_io_running=$(echo "$slave_status" | grep "Slave_IO_Running" | awk '{print $2}')
slave_sql_running=$(echo "$slave_status" | grep "Slave_SQL_Running" | awk '{print $2}')
# 输出第二个从库同步状态
echo "Slave 2 IO Running: $slave_io_running"
echo "Slave 2 SQL Running: $slave_sql_running"

# 等待用户输入
read -p "Press Enter to exit"
#!/bin/bash

# MySQL 主库信息
MASTER_HOST="192.168.184.134"
MASTER_PORT="3306"
MASTER_USER="root"
MASTER_PASSWORD="123456"

# MySQL 从库信息
SLAVE_HOST1="192.168.184.134"
SLAVE_PORT1="3307"
SLAVE_USER="root"
SLAVE_PASSWORD="123456"

SLAVE_HOST2="192.168.184.134"
SLAVE_PORT2="3308"

# 连接到主库获取当前二进制日志信息
master_conn=$(mysql -h $MASTER_HOST -P $MASTER_PORT -u $MASTER_USER -p$MASTER_PASSWORD -e "SHOW MASTER STATUS\G")
log_file=$(echo "$master_conn" | grep "File" | awk '{print $2}')
log_pos=$(echo "$master_conn" | grep -E "Position|Exec_Master_Log_Pos" | awk '{print $2}')

# 连接到第一个从库更新配置
slave_conn=$(mysql -h $SLAVE_HOST1 -P $SLAVE_PORT1 -u $SLAVE_USER -p$SLAVE_PASSWORD -e "STOP SLAVE; CHANGE MASTER TO MASTER_LOG_FILE='$log_file', MASTER_LOG_POS=$log_pos; START SLAVE;")
# 检查第一个从库同步状态
slave_status=$(mysql -h $SLAVE_HOST1 -P $SLAVE_PORT1 -u $SLAVE_USER -p$SLAVE_PASSWORD -e "SHOW SLAVE STATUS\G")
slave_io_running=$(echo "$slave_status" | grep "Slave_IO_Running" | awk '{print $2}')
slave_sql_running=$(echo "$slave_status" | grep "Slave_SQL_Running" | awk '{print $2}')
# 输出第一个从库同步状态
echo "Slave 1 IO Running: $slave_io_running"
echo "Slave 1 SQL Running: $slave_sql_running"

# 连接到第二个从库更新配置
slave_conn=$(mysql -h $SLAVE_HOST2 -P $SLAVE_PORT2 -u $SLAVE_USER -p$SLAVE_PASSWORD -e "STOP SLAVE; CHANGE MASTER TO MASTER_LOG_FILE='$log_file', MASTER_LOG_POS=$log_pos; START SLAVE;")
# 检查第二个从库同步状态
slave_status=$(mysql -h $SLAVE_HOST2 -P $SLAVE_PORT2 -u $SLAVE_USER -p$SLAVE_PASSWORD -e "SHOW SLAVE STATUS\G")
slave_io_running=$(echo "$slave_status" | grep "Slave_IO_Running" | awk '{print $2}')
slave_sql_running=$(echo "$slave_status" | grep "Slave_SQL_Running" | awk '{print $2}')
# 输出第二个从库同步状态
echo "Slave 2 IO Running: $slave_io_running"
echo "Slave 2 SQL Running: $slave_sql_running"

# 等待用户输入
read -p "Press Enter to exit"
