drop table conturi cascade constraints
/
create table conturi(
    idcont number(10) primary key,
    username  varchar2(100),
    pass varchar2(100)
    )   
/
drop table petitii cascade constraints
/
create table petitii(
    idpetitie number(10) primary key,
    voturi number(10),
    idinitiator number(10) references conturi(idcont),
    nume varchar2(200),
    destinatar varchar2(200),
    descriere varchar2(1000),
    categorie varchar2(100),
    datapostare date
    )
/
drop table petitiineaprobate cascade constraints
/
drop table comentarii cascade constraints
/
create table comentarii(
    idcomentariu number(10) primary key,
    datapostarii date,
    idcont number(10) references conturi(idcont),
    idpetitie number(10) references petitii(idpetitie),
    textcomentariu varchar2(300)
    )
/
drop table voturi cascade constraints
/
drop type voturi;
create table voturi(
    idcont  number(10) ,
    petitievotata number(10) references petitii(idpetitie),
    ip varchar(50)
    )
/
drop table categorii cascade constraints   
/
create table categorii(
    idcategorie  number(2) ,
    nume varchar2(50)
    )
/
drop  procedure getname
/
create procedure getname(id_pet number, numepet out varchar2, descpet out varchar2) as
    begin
    select descriere,nume into descpet,numepet from petitii where idpetitie=id_pet; 
end getname;
/
drop function getnoofpetitions
/
create function getnoofpetitions return number is
nr number;
begin
    select max(idpetitie)+1 into nr from petitii;
    return nr;
end getnoofpetitions;
/
drop procedure adaugapetitie
/
create procedure adaugapetitie(idinitiator_p number,nume_p varchar2,destinatar_p varchar2,descriere_p varchar2,categorie_p varchar2)
is
begin
    insert into petitii(idinitiator,nume ,destinatar,descriere,categorie) values(idinitiator_p,nume_p,destinatar_p,descriere_p,categorie_p);
end adaugapetitie;
/
drop function getnewcontid
/
create function getnewcontid return number
    as
    idc number;
    begin
    select max(idcont) into idc from conturi;
    idc:=idc+1;
    return idc;
end getnewcontid;
/
drop procedure adaugacont
/
create procedure adaugacont(user varchar2, pass varchar2) as
idcont number;
begin
    insert into conturi values(getnewcontid(),user,pass);
end adaugacont; 
/
create or replace trigger incrementComentarii 
  before insert on comentarii 
  for each row
  declare
  idC number(10);
BEGIN
  select COUNT(*) into idC FROM COMENTARII ;
  :new.idComentariu:=idC+1;
  :new.dataPostarii:=sysdate;
END;
/
insert into comentarii values(1,sysdate,3,3,'nonono')
/
desc comentarii
/
create or replace trigger incrementPetitii
before insert on petitii
for each row
declare
cate number(10);
begin
:new.dataPostare:=sysdate;
:new.voturi:=0;
select max(idpetitie) into cate from petitii;
:new.idPetitie:=cate+1;
end;
/
select * from petitii 
/
select * from comentarii
;
/
select * from voturi
/
/
insert into Comentarii(idcont,idpetitie,textcomentariu) values(101,3,'ssss')


/
select count(idcont) from conturi where username='dddddd' and password = 'ddd'
/
insert into conturi values(102,'root','f6a462380ce89410dc521de60eb0d40d')
/
select count(*) from conturi where username='root' 
/
desc voturi
/
select count(*) from voturi where petitievotata=10
delete 
/
create or replace trigger adaugaVot after insert on voturi
for each row
declare 
idpet number(10);
begin
  idpet:=:new.petitievotata;
  update petitii set voturi=voturi+1 where idPetitie=idpet;
end;
/
create or replace trigger adaugaCont before insert on conturi
for each row
declare
idnou number(10);
begin
  select max(idcont) into idnou from conturi;
  :new.idcont:=idnou+1;
  :new.rang:=1;
end;
/
drop trigger adaugacont;
select  * from petitii
/
delete from petitii where idinitiator=100
/
desc petitii
/
select * from conturi
/
select * from petitii
/
update comentarii set idcont=3 where idcont=102
/
insert into conturi values(2,'james','blue',1);
/
update petitii set idinitiator=104 where idinitiator=100
/
update conturi set idcont=3 where username='admin'
/
insert into comentarii values()