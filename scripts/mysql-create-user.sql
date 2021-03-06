CREATE USER '{username}'@'localhost' IDENTIFIED BY '{userpassword}';

GRANT USAGE ON * . * TO '{username}'@'localhost' IDENTIFIED BY '{userpassword}' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;

GRANT ALL PRIVILEGES ON `{username}\_%` . * TO '{username}'@'localhost';
