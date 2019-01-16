create table test(
test varchar2(10)
);
create table Member(
id varchar2(10) primary key,
name varchar2(10),
pass varchar2(10),
ssn varchar2(14)
);

create table Account(
account_num varchar2(9) primary key,
created_date DATE DEFAULT SYSDATE,
money number default 0,
id varchar2(10) not null,
constraint account_fk_member foreign key(id) 
 references member(id)
);

alter table member
add primary key(id);

select count(*) from tab;
select * from tab;
drop table member;
commit;

alter table test
add test2 varchar2(10);

select * from test;

alter table test
drop column test2;

create table Admin(
admin_num varchar2(10) primary key,
name varchar2(10) not null,
pass varchar2(10) not null,
auth varchar2(10) default '사원'
);

create sequence art_seq
start with 1000
increment by 1;

create table Article(
art_seq number primary key,
title varchar2(20) default '제목없음',
content varchar2(50),
regdate DATE DEFAULT SYSDATE,
id varchar2(10) not null,
constraint article_fk_member foreign key(id) 
 references member(id)
);


