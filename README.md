# nginx-online-router

## Decription

This setup of services, including nginx, onlineconf, and a bit of Lua, allows routing requests to either serviceA or serviceB depending on the configuration in onlineconf.

## How to test

- make run
- http://localhost/#/nginx/serviceB/endpoints/\_api_v1_users update this value (on - serviceB, 0 - serviceA)
- curl http://localhost:8100/api/v1/users
- wait (about 10s)
- profit

## Links

http://localhost Onlineconf (admin:admin)
http://localhost:8100 nginx

## Bench

```bash
(base) ➜  nginx-online-router git:(main) ✗ wrk -t3 -c30 -d10s  --script ./tests/test.lua http://localhost:8100
Running 10s test @ http://localhost:8100
  3 threads and 30 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    14.17ms   38.04ms 205.06ms   91.19%
    Req/Sec     3.69k   615.23     7.36k    70.76%
  110663 requests in 10.10s, 19.21MB read
Requests/sec:  10953.79
Transfer/sec:      1.90MB
```

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
