# Snowflake Tasks

## Warm-up SQL tasks

```
-- query to get full name of all married women in the company
select C_first_name, c_last_name from customer where c_salutation = 'Mrs.';

-- query to get the most recent promotions where both the start and end date are known
select p_start_date_sk, p_end_date_sk from promotion 
where p_start_date_sk is not null and p_end_date_sk is not null
order by p_start_date_sk desc;

use schema tpch_sf1;

-- query to get the full part name and then the full part supplier comment about it
select part.p_name, partsupp.ps_comment from partsupp
inner join part ON partsupp.ps_partkey=part.p_partkey;

--task1 - use a select statement to retrieve data from multiple columns accross different tables
-- this command combines comments about nations and regions into one table & renames it
select n_comment as nr_comment from nation union
select r_comment from region;

--task2 - create a query that lists all orders sorted by the order date in descending order of a particular customer
-- chosen customer has custkey of 21445
select * from orders where o_custkey = 21445 order by o_orderdate desc;

--task3 - create a query using join to display customer names alongside their respective IDs
--the customer ids and names are already available in the customer table, so i'll do the join alongside the orders table to list all customers that have made an order at least once
--distinct is used to not reprint names of customers that have multiple orders
select distinct customer.c_name, orders.o_custkey from orders
inner join customer ON orders.o_custkey=customer.c_custkey;
```

## EOD 01-31 Snowflake Task 
```
-- task: create a table, view & procedure
-- creating a db as the snowflake sample data can't be modified
create database juste_db;
use database juste_db;

--in order to have some sample data to accomplish the task, i'll be copying over some sample data, specifically from tpch_sf1 nation and region tables
create schema task_schema;

CREATE TABLE nation AS
SELECT * from snowflake_sample_data.tpch_sf1.nation;

CREATE TABLE region AS
SELECT * from snowflake_sample_data.tpch_sf1.region;

--as the nation schema has a region key, a useful view would be to combine the nation and region into one & sort by region alphabetical order
create view nation_region as
select nation.n_name, region.r_name from nation
inner join region ON nation.n_regionkey=region.r_regionkey order by r_name;

--the list of the nations is quite small, only 25 entries! a good procedure would be for adding new nations
create or replace procedure insert_nation(
    N_NATIONKEY NUMBER(38,0),
    N_NAME VARCHAR(25),
    N_REGIONKEY NUMBER(38,0),
    N_COMMENT VARCHAR(152)
)
returns boolean language sql as
$$
insert into nation (N_NATIONKEY, N_NAME, N_REGIONKEY, N_COMMENT) 
values (:N_NATIONKEY, :N_NAME, :N_REGIONKEY, :N_COMMENT);
$$;

call insert_nation(25, 'Lithuania', 3, 'the biggest baltic country by size & population');

select * from nation where n_name='Lithuania';
```