-- Create the UDF.
CREATE OR REPLACE FUNCTION array_sort(a array)
  RETURNS array
  LANGUAGE JAVASCRIPT
AS
$$
  return A.sort();
$$
;

-- Call the UDF with a small array.
SELECT ARRAY_SORT(PARSE_JSON('[2,4,5,3,1]'));


https://docs.snowflake.net/manuals/sql-reference/udf-js.html