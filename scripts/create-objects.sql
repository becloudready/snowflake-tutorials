-- Create Snowflake objects
-- - create database

create or replace database sf_tuts;
-- - check the schema
select current_database(), current_schema();

-- - create table
create or replace table emp_basic (
  first_name string ,
  last_name string ,
  email string ,
  streetaddress string ,
  city string ,
  start_date date
  );

-- - create virtual warehouse
create or replace warehouse sf_tuts_wh with
  warehouse_size='X-SMALL'
  auto_suspend = 180
  auto_resume = true
  initially_suspended=true;

