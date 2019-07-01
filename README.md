# snowflake-tutorials
Snowflake Database tutorial

# Snowflake hands-on
## Pre-requisites
- Snowflake account
- user with AccountAdmin or SecurityAdmin role
- snowsql installation
- Sample data files

# Install Snow SQL ( goto help and download ) below instructions

~/.snowsql/config file
```
accountname = <account_name>
username = <account_name>
password = <password> 
```
On MacOS run

```
/Applications/SnowSQL.app/Contents/MacOS/snowsql -a <username> -u <username>
```

## Hands-on
### Step-1:  
login to SnowSQL
```
snowsql -a <account_name> -u <user_name>
```

If this is the first time yyou are doing this, it'll take some time to istall some dependencies before it prompts for the password.

### Step-2:  
Create Snowflake objects
- create database
```
create or replace database sf_tuts;
```
- check the schema
```
select current_database(), current_schema();
```

- create table
```

create or replace table emp_basic (
  first_name string ,
  last_name string ,
  email string ,
  streetaddress string ,
  city string ,
  start_date date
  );
```
- create virtual warehouse
```
create or replace warehouse sf_tuts_wh with
  warehouse_size='X-SMALL'
  auto_suspend = 180
  auto_resume = true
  initially_suspended=true;
```

### Step-3:  
Stage data files  
Linux
```
put file:///tmp/employees0*.csv @sf_tuts.public.%emp_basic;
```
Windows
```
put file:///tmp/employees0*.csv @sf_tuts.public.%emp_basic;
```

list files
```
list @sf_tuts.public.%emp_basic;
```

### Step-4:  
Copy data to target tables
```
copy into emp_basic
  from @%emp_basic
  file_format = (type = csv field_optionally_enclosed_by='"')
  pattern = '.*employees0[1-5].csv.gz'
  on_error = 'skip_file';
```

### Step-5:  
Query loaded data
```
select * from emp_basic;

insert into emp_basic values
  ('Clementine','Adamou','cadamou@sf_tuts.com','10510 Sachs Road','Klenak','2017-9-22') ,
  ('Marlowe','De Anesy','madamouc@sf_tuts.co.uk','36768 Northfield Plaza','Fangshan','2017-1-26');

  select email from emp_basic where email like '%.uk';

  select first_name, last_name, dateadd('day',90,start_date) from emp_basic where start_date <= '2017-01-01';
```

### Step-6:  
Clean-up

```
drop database if exists sf_tuts;

drop warehouse if exists sf_tuts_wh;
```


Credits: https://docs.snowflake.net/manuals/user-guide-getting-started.html
