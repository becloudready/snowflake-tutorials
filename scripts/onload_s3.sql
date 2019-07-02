create or replace file format my_csv_format
  type = csv field_delimiter = ',' skip_header = 1 null_if = ('NULL', 'null') empty_field_as_null = true compression = gzip;


create or replace stage my_s3_unload_stage url='s3://becloudready/data-analytics/write'
  credentials=(aws_key_id='<your key>' aws_secret_key='<your secred>')
  file_format = (type = csv field_optionally_enclosed_by='"');


copy into @my_s3_unload_stage/ from emp_basic;




COPY INTO 's3://<bucket>/test_data/TEST1.csv.gz'

FROM TESTDB..TEST1

FILE_FORMAT = 'CSVFORMAT'

 CREDENTIALS = (AWS_KEY_ID = '<>'

        AWS_SECRET_KEY = '<>')

encryption = (type = '<>'

       kms_key_id = '<>')

OVERWRITE=TRUE

SINGLE=TRUE;

Linux/MacOS
snowsql -c my_example_connection -d sales_db -s public -q 'select * from mytable limit 10' -o output_format=csv -o header=false -o timing=false -o friendly=false  > output_file.csv

Windows
snowsql -c my_example_connection -d sales_db -s public -q "select * from mytable limit 10" -o output_format=csv -o header=false -o timing=false -o friendly=false  > output_file.csv


https://sqlkover.com/cool-stuff-in-snowflake-part-7-creating-tables/