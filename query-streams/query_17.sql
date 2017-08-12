query_17.sql_0^select  i_item_desc ,i_category ,i_class ,i_current_price ,sum(ws_ext_sales_price) as itemrevenue ,sum(ws_ext_sales_price)*100/sum(sum(ws_ext_sales_price)) over (partition by i_class) as revenueratio from web_sales ,item ,date_dim where ws_item_sk = i_item_sk and i_category in ('Electronics', 'Home', 'Jewelry') and ws_sold_date_sk = d_date_sk and d_date between cast('2000-01-15' as date) and (cast('2000-01-15' as date) + 30 days) group by i_item_id ,i_item_desc ,i_category ,i_class ,i_current_price order by i_category ,i_class ,i_item_id ,i_item_desc ,revenueratio limit 100
query_17.sql_1^select  ca_zip ,sum(cs_sales_price) from catalog_sales ,customer ,customer_address ,date_dim where cs_bill_customer_sk = c_customer_sk and c_current_addr_sk = ca_address_sk and ( substr(ca_zip,1,5) in ('85669', '86197','88274','83405','86475', '85392', '85460', '80348', '81792') or ca_state in ('CA','WA','GA') or cs_sales_price > 500) and cs_sold_date_sk = d_date_sk and d_qoy = 2 and d_year = 2001 group by ca_zip order by ca_zip limit 100
query_17.sql_2^select  * from(select w_warehouse_name ,i_item_id ,sum(case when (cast(d_date as date) < cast ('2001-02-18' as date)) then inv_quantity_on_hand else 0 end) as inv_before ,sum(case when (cast(d_date as date) >= cast ('2001-02-18' as date)) then inv_quantity_on_hand else 0 end) as inv_after from inventory ,warehouse ,item ,date_dim where i_current_price between 0.99 and 1.49 and i_item_sk          = inv_item_sk and inv_warehouse_sk   = w_warehouse_sk and inv_date_sk    = d_date_sk and d_date between (cast ('2001-02-18' as date) - 30 days) and (cast ('2001-02-18' as date) + 30 days) group by w_warehouse_name, i_item_id) x where (case when inv_before > 0 then inv_after / inv_before else null end) between 2.0/3.0 and 3.0/2.0 order by w_warehouse_name ,i_item_id limit 100
query_17.sql_3^select avg(ss_quantity) ,avg(ss_ext_sales_price) ,avg(ss_ext_wholesale_cost) ,sum(ss_ext_wholesale_cost) from store_sales ,store ,customer_demographics ,household_demographics ,customer_address ,date_dim where s_store_sk = ss_store_sk and  ss_sold_date_sk = d_date_sk and d_year = 2001 and((ss_hdemo_sk=hd_demo_sk and cd_demo_sk = ss_cdemo_sk and cd_marital_status = 'W' and cd_education_status = 'Secondary' and ss_sales_price between 100.00 and 150.00 and hd_dep_count = 3 )or (ss_hdemo_sk=hd_demo_sk and cd_demo_sk = ss_cdemo_sk and cd_marital_status = 'D' and cd_education_status = 'Primary' and ss_sales_price between 50.00 and 100.00 and hd_dep_count = 1 ) or (ss_hdemo_sk=hd_demo_sk and cd_demo_sk = ss_cdemo_sk and cd_marital_status = 'S' and cd_education_status = 'College' and ss_sales_price between 150.00 and 200.00 and hd_dep_count = 1 )) and((ss_addr_sk = ca_address_sk and ca_country = 'United States' and ca_state in ('SD', 'TX', 'MO') and ss_net_profit between 100 and 200 ) or (ss_addr_sk = ca_address_sk and ca_country = 'United States' and ca_state in ('TN', 'NJ', 'GA') and ss_net_profit between 150 and 300 ) or (ss_addr_sk = ca_address_sk and ca_country = 'United States' and ca_state in ('MT', 'KY', 'AR') and ss_net_profit between 50 and 250 ))
query_17.sql_4^select  i_item_id, ca_country, ca_state, ca_county, avg( cast(cs_quantity as numeric(12,2))) agg1, avg( cast(cs_list_price as numeric(12,2))) agg2, avg( cast(cs_coupon_amt as numeric(12,2))) agg3, avg( cast(cs_sales_price as numeric(12,2))) agg4, avg( cast(cs_net_profit as numeric(12,2))) agg5, avg( cast(c_birth_year as numeric(12,2))) agg6, avg( cast(cd1.cd_dep_count as numeric(12,2))) agg7 from catalog_sales, customer_demographics cd1, customer_demographics cd2, customer, customer_address, date_dim, item where cs_sold_date_sk = d_date_sk and cs_item_sk = i_item_sk and cs_bill_cdemo_sk = cd1.cd_demo_sk and cs_bill_customer_sk = c_customer_sk and cd1.cd_gender = 'F' and cd1.cd_education_status = 'Unknown' and c_current_cdemo_sk = cd2.cd_demo_sk and c_current_addr_sk = ca_address_sk and c_birth_month in (6,2,9,8,12,1) and d_year = 1999 and ca_state in ('OH','VA','NC' ,'OK','SD','LA','TX') group by rollup (i_item_id, ca_country, ca_state, ca_county) order by ca_country, ca_state, ca_county, i_item_id limit 100
query_17.sql_5^select  i_brand_id brand_id, i_brand brand, i_manufact_id, i_manufact, sum(ss_ext_sales_price) ext_price from date_dim, store_sales, item,customer,customer_address,store where d_date_sk = ss_sold_date_sk and ss_item_sk = i_item_sk and i_manager_id=23 and d_moy=12 and d_year=1998 and ss_customer_sk = c_customer_sk and c_current_addr_sk = ca_address_sk and substr(ca_zip,1,5) <> substr(s_zip,1,5) and ss_store_sk = s_store_sk group by i_brand ,i_brand_id ,i_manufact_id ,i_manufact order by ext_price desc ,i_brand ,i_brand_id ,i_manufact_id ,i_manufact limit 100
query_17.sql_6^select  i_item_desc ,i_category ,i_class ,i_current_price ,sum(cs_ext_sales_price) as itemrevenue ,sum(cs_ext_sales_price)*100/sum(sum(cs_ext_sales_price)) over (partition by i_class) as revenueratio from	catalog_sales ,item ,date_dim where cs_item_sk = i_item_sk and i_category in ('Books', 'Shoes', 'Children') and cs_sold_date_sk = d_date_sk and d_date between cast('1999-04-03' as date) and (cast('1999-04-03' as date) + 30 days) group by i_item_id ,i_item_desc ,i_category ,i_class ,i_current_price order by i_category ,i_class ,i_item_id ,i_item_desc ,revenueratio limit 100
query_17.sql_7^select i_item_id ,i_item_desc ,s_store_id ,s_store_name ,max(ss_net_profit) as store_sales_profit ,max(sr_net_loss) as store_returns_loss ,max(cs_net_profit) as catalog_sales_profit from store_sales ,store_returns ,catalog_sales ,date_dim d1 ,date_dim d2 ,date_dim d3 ,store ,item where d1.d_moy = 4 and d1.d_year = 1999 and d1.d_date_sk = ss_sold_date_sk and i_item_sk = ss_item_sk and s_store_sk = ss_store_sk and ss_customer_sk = sr_customer_sk and ss_item_sk = sr_item_sk and ss_ticket_number = sr_ticket_number and sr_returned_date_sk = d2.d_date_sk and d2.d_moy               between 4 and  10 and d2.d_year              = 1999 and sr_customer_sk = cs_bill_customer_sk and sr_item_sk = cs_item_sk and cs_sold_date_sk = d3.d_date_sk and d3.d_moy               between 4 and  10 and d3.d_year              = 1999 group by i_item_id ,i_item_desc ,s_store_id ,s_store_name order by i_item_id ,i_item_desc ,s_store_id ,s_store_name limit 100
query_17.sql_8^select  i_item_id ,i_item_desc ,s_state ,count(ss_quantity) as store_sales_quantitycount ,avg(ss_quantity) as store_sales_quantityave ,stddev_samp(ss_quantity) as store_sales_quantitystdev ,stddev_samp(ss_quantity)/avg(ss_quantity) as store_sales_quantitycov ,count(sr_return_quantity) as_store_returns_quantitycount ,avg(sr_return_quantity) as_store_returns_quantityave ,stddev_samp(sr_return_quantity) as_store_returns_quantitystdev ,stddev_samp(sr_return_quantity)/avg(sr_return_quantity) as store_returns_quantitycov ,count(cs_quantity) as catalog_sales_quantitycount ,avg(cs_quantity) as catalog_sales_quantityave ,stddev_samp(cs_quantity)/avg(cs_quantity) as catalog_sales_quantitystdev ,stddev_samp(cs_quantity)/avg(cs_quantity) as catalog_sales_quantitycov from store_sales ,store_returns ,catalog_sales ,date_dim d1 ,date_dim d2 ,date_dim d3 ,store ,item where d1.d_quarter_name = '2001Q1' and d1.d_date_sk = ss_sold_date_sk and i_item_sk = ss_item_sk and s_store_sk = ss_store_sk and ss_customer_sk = sr_customer_sk and ss_item_sk = sr_item_sk and ss_ticket_number = sr_ticket_number and sr_returned_date_sk = d2.d_date_sk and d2.d_quarter_name in ('2001Q1','2001Q2','2001Q3') and sr_customer_sk = cs_bill_customer_sk and sr_item_sk = cs_item_sk and cs_sold_date_sk = d3.d_date_sk and d3.d_quarter_name in ('2001Q1','2001Q2','2001Q3') group by i_item_id ,i_item_desc ,s_state order by i_item_id ,i_item_desc ,s_state limit 100
query_17.sql_9^select  i_item_id, avg(cs_quantity) agg1, avg(cs_list_price) agg2, avg(cs_coupon_amt) agg3, avg(cs_sales_price) agg4 from catalog_sales, customer_demographics, date_dim, item, promotion where cs_sold_date_sk = d_date_sk and cs_item_sk = i_item_sk and cs_bill_cdemo_sk = cd_demo_sk and cs_promo_sk = p_promo_sk and cd_gender = 'F' and cd_marital_status = 'U' and cd_education_status = 'Primary' and (p_channel_email = 'N' or p_channel_event = 'N') and d_year = 2002 group by i_item_id order by i_item_id limit 100
