create or replace file format my_csv_format
  type = csv field_delimiter = ',' skip_header = 1 null_if = ('NULL', 'null') empty_field_as_null = true compression = gzip;


create or replace stage my_s3_unload_stage url='s3://becloudready/data-analytics/write'
  credentials=(aws_key_id='<your key>' aws_secret_key='<your secred>')
  file_format = (type = csv field_optionally_enclosed_by='"');


copy into @my_s3_unload_stage/ from emp_basic;