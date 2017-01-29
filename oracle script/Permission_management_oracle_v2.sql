
drop database IF EXISTS Permission_management;

create database Permission_management;

use Permission_management;


# master table to store accounting_packages 
drop table IF EXISTS accounting_package_provider;

create table accounting_package_provider(
   accounting_package_ID number(4) NOT NULL UNIQUE,
   accounting_package_name varchar2(255) NOT NULL 
);


INSERT  INTO accounting_package_provider (accounting_package_ID, accounting_package_name) VALUES (01,'XERO');
INSERT  INTO accounting_package_provider (accounting_package_ID, accounting_package_name) VALUES (02,'Sage');
INSERT  INTO accounting_package_provider (accounting_package_ID, accounting_package_name) VALUES (03,'Intuit');
INSERT  INTO accounting_package_provider (accounting_package_ID, accounting_package_name) VALUES (04,'Free Agent');

#=====================================================
# This table has mapping of business customer identification and accounting_package
# 1 to many mapping 

drop table customer_accounting_package;

create table customer_accounting_package (
   BCIN varchar2(100),
   accounting_package_ID number(4), 
   CONSTRAINT pk_BCIN_acc_package_id
   PRIMARY KEY (BCIN, accounting_package_ID),
   CONSTRAINT fk_accounting_package_provider
   FOREIGN KEY (accounting_package_ID)
   REFERENCES accounting_package_provider(accounting_package_ID)
);


insert into customer_accounting_package 
(BCIN, 
 accounting_package_ID)
values
  ('GB-HBEU-1004174304',02);


insert into customer_accounting_package 
(BCIN, 
 accounting_package_ID)
values
  ('GB-HBEU-2330948983',01);


#=======================================================
# This table has mapping of business customer identification and account_id
# 1 to many mapping 
drop table customer_accounting_enabled;


create table customer_accounting_enabled (
   BCIN varchar2(100),
   account_ID varchar2(150) NOT NULL 
);


insert into customer_accounting_enabled 
(BCIN , 
 account_ID)
values
  ('GB-HBEU-1004174304'  ,'4751300091548945');



insert into customer_accounting_enabled 
(BCIN , 
 account_ID)
values
  ('GB-HBEU-2330948983'  ,'60125430854789');



insert into customer_accounting_enabled 
(BCIN , 
 account_ID)
values
  ('test_bcin'  ,'123456');

update accounting_enabled 
set account_ID='8888'
where BCIN='test_bcin';



#=======================================================
# This is audit table capturing time stamp and userid for change of BCIN

create table permission_audit (
   BCIN varchar2(100),
   date_time date,
   userID varchar2(150),
   free_text varchar2(500) 
);


insert into audit 
(BCIN, 
 date_time,
 userID,
 free_text)
values
  ('GB-HBEU-1004174304','4751300091548945');



insert into audit 
(BCIN, 
 date_time,
 userID,
 free_text)
values
  ('GB-HBEU-2330948983'  ,'60125430854789');



#======================================================
# Trigger table
drop table IF EXISTS triggeraction;

create table triggeraction (
   BCIN varchar2(100),
   action varchar2(1),
   accounting_package_ID number(4), 
   account_ID varchar2(150) NOT NULL,
   CONSTRAINT fk_triggeraction_provider
   FOREIGN KEY (accounting_package_ID)
   REFERENCES accounting_package_provider(accounting_package_ID)
);

===============================================================
select * from accounting_packages;

