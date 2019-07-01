/* Create a target relational table for the JSON data. The table is temporary, meaning it persists only for the duration
of the user session and is not visible to other users. */

create or replace temporary table home_sales (
  city string,
  zip string,
  state string,
  type string default 'Residential',
  sale_date timestamp_ntz,
  price string
  );

/* Create a named file format with the file delimiter set as none and the record delimiter set as the new line character.

When loading semi-structured data, e.g. JSON, you should set CSV as the file format type (default value). You could use the
JSON file format, but any error in the transformation would stop the COPY operation, even if you set the ON_ERROR option to
continue or skip the file. */

create or replace file format sf_tut_csv_format
  field_delimiter = none
  record_delimiter = '\\n';

/* Create a temporary internal stage that references the file format object.

  Similar to temporary tables, temporary stages are automatically dropped at the end of the session. */

create or replace temporary stage sf_tut_stage
  file_format = sf_tut_csv_format;

/* Stage the data file.

Note that the example PUT statement references the macOS or Linux location of the data file.
If you are using Windows, execute the following statement instead:
PUT %TEMP%/sales.json @sf_tut_stage; */

put file:///tmp/sales.json @sf_tut_stage;

/* Load the JSON data into the relational table.

A SELECT query in the COPY statement identifies a numbered set of columns in the data files you are loading from. Note that all JSON data is stored in a single column ($1). */

copy into home_sales(city, state, zip, sale_date, price)
   from (select substr(parse_json($1):location.state_city,4), substr(parse_json($1):location.state_city,1,2), parse_json($1):location.zip, to_timestamp_ntz(parse_json($1):sale_date), parse_json($1):price
   from @sf_tut_stage/sales.json.gz t)
   on_error = 'continue';

-- Query the relational table
select * from home_sales;