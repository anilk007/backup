drop database IF EXISTS Permission_management;

create database Permission_management;

use Permission_management;


# master table to store accounting_packages 
drop table IF EXISTS accounting_package_provider;

create table accounting_package_provider(
   accounting_package_ID integer NOT NULL UNIQUE,
   accounting_package_name varchar(255) NOT NULL 
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
create table accounting_package (
   BCIN integer,
   accounting_package_ID integer, 
   foreign key  FK_accounting_package_ID(accounting_package_ID)
   REFERENCES accounting_package_provider(accounting_package_ID)
);


#=======================================================
# This table has mapping of business customer identification and account_id
# 1 to many mapping 
drop table IF EXISTS accounting_enabled;


create table accounting_enabled (
   BCIN integer,
   account_ID varchar(22) NOT NULL 
);


insert into accounting_enabled 
(BCIN , 
 account_ID)
values
  (123,"4352451246"),
  (234,"5657565675"),
  (123,"6565756576"),
  (123,"3434334344"),
  (234,"3253255424");
  

#=======================================================
# This is audit table capturing time stamp and userid for change of BCIN

create table audit (
   BCIN integer,
   date_time datetime,
   userID varchar(10),
   free_text varchar(50) 
);

#======================================================
# Trigger table
drop table IF EXISTS triggeraction;

create table triggeraction (
   BCIN integer,
   action varchar(1),
   accounting_package_ID integer, 
   account_ID varchar(22) NOT NULL,
   foreign key FK_trigger_accounting_package_ID(accounting_package_ID)
   references accounting_package_provider(accounting_package_ID)
);

#======================================================
UPDATE `permission_management`.`accounting_enabled`
SET
`account_ID` = "acc010"
WHERE 
`BCIN` = 001;
#======================================================
