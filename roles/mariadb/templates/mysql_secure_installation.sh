#!/bin/bash

mysql -sfu root -p {{ root_pass }}<<EOS
-- set root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '{{ mysql_root_pass }}';
-- delete anonymous users
DELETE FROM mysql.user WHERE User='';
-- delete remote root capabilities
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0>
-- drop database 'test'
DROP DATABASE IF EXISTS test;
-- also make sure there are lingering permissions to it
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
-- make changes immediately
FLUSH PRIVILEGES;
EOS