# nginx-online-router

## Decription
This setup of services, including nginx, onlineconf, and a bit of Lua, allows routing requests to either serviceA or serviceB depending on the configuration in onlineconf.

## How to test
- make run
- http://localhost/#/nginx/serviceB/endpoints/_api_v1_users update this value (on - serviceB, 0 - serviceA)
- curl http://localhost:8100/api/v1/users
- wait (about 10s)
- profit 

## Links
http://localhost Onlineconf (admin:admin)
http://localhost:8100 nginx

## Commands
### Start
```
make run
```
### clean && run
```
make clean && make run
```
### Dump Database
```
docker exec nginx-online-router-onlineconf-database-1 mysqldump --skip-lock-tables --routines --add-drop-table --disable-keys --extended-insert -u root --password={root_password}  onlineconf > oc/admin_nginx_data.sql
```
root_password see in STDOUT DB