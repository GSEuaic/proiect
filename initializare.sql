drop table conturi cascade constraints
/
create table conturi(
    idcont number(10) primary key,
    username  varchar2(100),
    password varchar2(100)
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
create or replace trigger incrementPetitii
before insert on petitii
for each row
declare
cate number(10);
begin
:new.dataPostare:=sysdate;
:new.voturi:=0;
select count(*) into cate from petitii;
:new.idPetitie:=cate+1;
end;
/
select * from petitii 
/
select * from comentarii
;
/
select * from conturi
/
insert into Comentarii(idcont,idpetitie,textcomentariu) values(101,3,'ssss')