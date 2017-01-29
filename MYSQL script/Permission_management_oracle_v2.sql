drop database IF EXISTS Permission_management;

create database Permission_management;

use Permission_management;


# master table to store accounting_packages 
drop table IF EXISTS accounting_package_provider;

create table accounting_package_provider(
   accounting_package_ID number(4) NOT NULL UNIQUE,
   accounting_package_name varchar2(255) NOT NULL 
);

insert into accounting_package_provider 
(accounting_package_ID , 
 accounting_package_name)
values
  (01,"XERO"),
  (02,"Sage"),
  (03,"Intuit"),
  (04,"Free Agent");

#=====================================================
# This table has mapping of business customer identification and accounting_package
# 1 to many mapping 

create table customer_accounting_package (
   BCIN varchar2(100),
   accounting_package_ID number(4), 
   foreign key  FK_accounting_package_ID(accounting_package_ID)
   REFERENCES accounting_package_provider(accounting_package_ID)
);


insert into customer_accounting_package 
(BCIN, 
 accounting_package_ID)
values
  ("GB-HBEU-1004174304",02),
  ("GB-HBEU-2330948983",01);

#=======================================================
# This table has mapping of business customer identification and account_id
# 1 to many mapping 
drop table IF EXISTS accounting_enabled;


create table accounting_enabled (
   BCIN varchar2(100),
   account_ID varchar2(150) NOT NULL 
);


insert into accounting_enabled 
(BCIN , 
 account_ID)
values
  ("GB-HBEU-1004174304"  ,"4751300091548945"),
  ("GB-HBEU-2330948983"  ,"60125430854789");

#=======================================================
# This is audit table capturing time stamp and userid for change of BCIN

create table audit (
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
  ("GB-HBEU-1004174304"  ,"4751300091548945"),
  ("GB-HBEU-2330948983"  ,"60125430854789");



#======================================================
# Trigger table
drop table IF EXISTS triggeraction;

create table triggeraction (
   BCIN varchar2(100),
   action varchar2(1),
   accounting_package_ID number(4), 
   account_ID varchar2(150) NOT NULL,
   foreign key FK_trigger_accounting_package_ID(accounting_package_ID)
   references accounting_package_provider(accounting_package_ID)
);
