# Задание 1
PS C:\docker\nettology1508> docker pull postgres:13
PS C:\docker\nettology1508>docker volume create vol_postgres
PS C:\docker\nettology1508> docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v vol_postgres:/var/lib/postgresql/data postgres:13
PS C:\Users\admin> docker exec -it pg-docker bash
root@76e087be13bf:/# psql -h localhost -p 5432 -U postgres -W
```
\l - список БД
\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo} connect to new database (currently "postgres") - подключение к БД
\dt[S+] [PATTERN] - список таблиц
\d[S+]  NAME - описание содержимого таблиц
\q - выход из psql
```
# Задание 2
postgres=# CREATE DATABASE test_database;
psql -U postgres -f ./pg_backup.sql test_database

Статистика по таблице
```
test_database=# analyze verbose orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
```
```
test_database=# select avg_width from pg_stats where tablename='orders';
 avg_width
-----------
         4
        16
         4
(3 rows)
```
# Задание 3
При проектировании нужно было сделать таблицу секционированной, если бы это было сделано, не пришлось бы переименовывать исходную таблицу и переносить данные в новую
```
test_database=# alter table orders rename to orders_old;
ALTER TABLE
test_database=# create table orders (id integer, title varchar(80), price integer) partition by range(price);
CREATE TABLE
test_database=# create table orders_before499 partition of orders for values from (0) to (499);
CREATE TABLE
test_database=# create table orders_after499 partition of orders for values from (499) to (999999999);
CREATE TABLE
test_database=# insert into orders (id, title, price) select * from orders_old;
INSERT 0 8
test_database=# 
```
# Задание 4
```
root@76e087be13bf:/tmp# pg_dump -U postgres -d test_database > /tmp/dump.sql
```
Чтобы добавить уникальность значения столбца title для таблиц test_database я бы добавил индекс
