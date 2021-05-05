# Test Postgres Features on Rails

* #### Command used to create this App: API Mode, Postgres Database, Skip Tests Files
```
rails new pg_features --api -d postgresql -T
```

* #### Source of the CSV Data:
[Data.world...](https://data.world/wfp/dd6f3c15-69c0-44c0-8f62-6c5395dcc572/workspace/file?filename=colombia-food-prices-1.csv)


* #### Sample of CSV File

```
date,cmname,unit,category,price,currency,country,admname,adm1id,mktname,mktid,cmid,ptid,umid,catid,sn,default
#date,#item+name,#item+unit,#item+type,#value,#currency,#country+name,#adm1+name,#adm1+code,#name+market,,#item+code,,,#item+type+code,#meta+id,
2005-01-15,Wheat flour - Wholesale,KG,cereals and tubers,1347.33,COP,Colombia,Antioquia,935,Medellin,842,58,14,5,1,842_58_14_5,
...
```

* #### Generate Model/Migration

```
rails g model FoodPrice date:date cmname:string unit:string category:string price:float currency:string country:string admname:string adm1id:integer mktname:string mktid:integer cmid:integer ptid:integer umid:integer catid:integer sn:string default:string

rails db:create
rails db:migrate
```

* #### Import CSV Data into Database using SQL COPY
```
  rails c
  PgUtils.import_csv
```

Postgres provides two ways to encapsulate large queries: Views and Materialized Views

View
A view allows us to query against the result of another query, providing a powerful way of abstracting away a complex query full of joins, conditions, groupings, and any other clause that can be added to an SQL query. 

