# College Football Data Pipeline Project

A "full-stack" data portfolio project, from API data ingestion to end-user data visualization. 

Pipeline (ELT):
- Data extracted from CFBD API via Python scripts
- Data dumped as raw JSON into personal Postgres db running on homelab docker image 
- Raw JSON rows parsed and transformed in dbt, and then materialized as tables/views in Postgres DB
- Run instance of [Metabase](https://www.metabase.com/) on local docker image to connect to DB and create data visualizations


Goals:
- Automate data extraction
- Create data models
- Analyze play data for interesting patterns - particularly the effectiveness of 4th Down conversion attempts
- Create visualizations

Data source:
[CFBD API]((https://github.com/CFBD/cfbd-python)


Dashboard Generated using [Metabase](https://www.metabase.com/) (open-source)

![image](https://user-images.githubusercontent.com/64382520/160642725-f0af9a1b-0e0e-44ee-b436-7ee1a058129a.png)
