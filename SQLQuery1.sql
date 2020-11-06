create database db_testlist
use db_testlist

create table blood_group
(
bg_id int primary key identity,
bg_name varchar(10)
)

insert into blood_group (bg_name) values ('A+'),('A-'),('B+'),('B-'),('AB+'),('AB-'),('O-'),('O+')
create proc sp_select_blood_group
as
begin
select * from blood_group
end

create table department
(
dp_id int primary key identity,
dp_name varchar(50)
)

insert into department (dp_name) values('HR'),('Accounts'),('Marketing'),('Oeration'),('Admin'),('IT'),('Maintenance')

create proc sp_select_department
as
begin
select * from department
end
create table tbl_location
(
l_id int primary key identity,
l_name varchar(50)
)

create proc sp_select_location
as
begin
select * from tbl_location
end

insert into tbl_location(l_name) values ('Delhi'),('Uttar Pradesh'),('West Bengal'),('Sikkim'),('Assam'),('Panjab'),('Bihar');

create table tbl_emp_rec
(
emp_id int primary key identity,
emp_name varchar(50),
emp_gender int,
emp_blood int,
emp_department int,
emp_location int
)

create procedure sp_insert_emp_rec
@emp_name varchar(50),
@emp_gender int,
@emp_blood int,
@emp_department int,
@emp_location int
as
begin
insert into tbl_emp_rec(emp_name,emp_gender,emp_blood,emp_department,emp_location) values(@emp_name,@emp_gender,@emp_blood,@emp_department,@emp_location)
end

alter procedure sp_select_emp_rec
as
begin
select emp_id,emp_name,emp_gender,bg_name,dp_name,l_name from tbl_emp_rec join blood_group on tbl_emp_rec.emp_blood=blood_group.bg_id join department on tbl_emp_rec.emp_department=department.dp_id join tbl_location on tbl_emp_rec.emp_location=tbl_location.l_id
end

create procedure sp_edit_emp_rec
@emp_id int
as
begin
select * from tbl_emp_rec where emp_id=@emp_id
end

create procedure sp_delete_emp_rec
@emp_id int
as
begin
delete from tbl_emp_rec where emp_id=@emp_id
end

create procedure sp_update_emp_rec
@emp_id int,
@emp_name varchar(50),
@emp_gender int,
@emp_blood int,
@emp_department int,
@emp_location int
as
begin
update tbl_emp_rec set emp_name=@emp_name,emp_gender=@emp_gender,emp_blood=@emp_blood,emp_department=@emp_department,emp_location=@emp_location where emp_id=@emp_id
end