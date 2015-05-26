drop table conturi cascade constraints
/
create table conturi(
    idcont number(10) primary key,
    username  varchar2(100),
    password varchar2(100)
    )   
/
drop table petitiiaprobate cascade constraints
/
create table petitiiaprobate(
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
    idpetitie number(10) references petitiiaprobate(idpetitie),
    textcomentariu varchar2(300)
    )
/
drop table voturi cascade constraints
/
create table voturi(
    idcont  number(10) ,
    petitievotata number(10) references petitiiaprobate(idpetitie),
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
    select descriere,nume into descpet,numepet from petitiiaprobate where idpetitie=id_pet; 
end getname;
/
drop function getnoofpetitions
/
create function getnoofpetitions return number is
nr number;
begin
    select max(idpetitie)+1 into nr from petitiiaprobate;
    return nr;
end getnoofpetitions;
/
drop procedure adaugapetitie
/
create procedure adaugapetitie(idinitiator number,nume varchar2,destinatar varchar2,descriere varchar2,categorie varchar2)
is
begin
    insert into petitiiaprobate(idinitiator,nume ,destinatar,descriere,categorie) values(idinitiator,nume,destinatar,descriere,categorie);
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
END;
/
create or replace trigger incrementPetitii
before insert on petitiiAprobate
for each row
declare
cate number(10);
begin
:new.dataPostare:=sysdate;
:new.voturi:=0;
select count(*) into cate from petitiiAprobate;
:new.idPetitie:=cate+1;
end;
/