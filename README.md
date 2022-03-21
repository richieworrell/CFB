Personal Data Pipeline Project

Pipeline (ELT):
- Data extracted from CFBD API via Python scripts
- Data dumped as raw JSON into personal Postgres db running on homelab docker image 
- Raw JSON rows parsed and transformed in dbt, and then materialized as tables in Postgres DB


Sources:
CFBD API 
https://blog.collegefootballdata.com/
