create or replace function add5 (n number)
  returns number
  as 'n + 5';

create or replace function add5 (s string)
  returns string
  as 's || ''5''';


create function area_of_circle(radius float)
  returns float
  as
  $$
    pi() * radius * radius
  $$
  ;
select area_of_circle(1.0);

-- The expression can be a query expression (a SELECT expression). For example:

-- When using a query expression in a SQL UDF, do not include a semicolon within the UDF body to terminate the query expression.

-- You can include only one query expression. The expression can include UNION [ALL].

-- Although the body of a UDF can contain a complete SELECT statement, it cannot contain DDL statements or any DML statement other than SELECT.


create table purchases (number_sold integer, wholesale_price number(7,2), retail_price number(7,2));
insert into purchases (number_sold, wholesale_price, retail_price) values 
   (3,  10.00,  20.00),
   (5, 100.00, 200.00)
   ;

create function profit()
  returns numeric(11, 2)
  as
  $$
    select sum((retail_price - wholesale_price) * number_sold) from purchases
  $$
  ;

create function t()
  returns table(msg varchar)
  as
  $$
  select 'Hello'
  union
  select 'World'
  $$;

select * from table(t());

create or replace function orders_for_product(prod_id varchar)
  returns table (product_id varchar, quantitysold numeric(11, 2))
  as
  $$
    select product_id, quantity from orders where product_id = prod_id
  $$
  ;
select * from table(orders_for_product('GreenStar Helmet'));


create or replace function get_countries_for_user ( id number )
  returns table (country_code char, country_name varchar)
  as 'select distinct c.country_code, c.country_name
      from user_addresses a, countries c
      where a.user_id = id
      and c.country_code = a.country_code';