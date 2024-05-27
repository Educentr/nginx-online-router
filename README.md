# nginx-online-router

## Commands
### Start
```
make run
```
### Delete database data and run
```
make rm && make rm-data-admin && make run
```
### Dump Database
```
docker exec nginx-online-router-onlineconf-database-1 mysqldump --skip-lock-tables --routines --add-drop-table --disable-keys --extended-insert -u root --password={root_password}  onlineconf > oc/admin_nginx_data.sql
```
root_password see in STDOUT DB