#!/bin/bash
for dbname in $(mysql -udev -pu6hhDiSYeKQXQgCK -B -N -e "show databases;"); do
  echo Backuping $dbname
  mysqldump --database $dbname -udev -pu6hhDiSYeKQXQgCK | gzip -c > ../backups/$dbname.sql.gz
done
