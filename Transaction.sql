drop table amount;
create table amount(ID number(5,0), amount number(8,2), name varchar2(50));

insert into amount values( 1, 100 , 'Jhon');

insert into amount values( 2, 200, 'Bob' );

SET TRANSACTION READ ONLY ; 

insert into amount values(3, 100);

select * from amount;
commit;
