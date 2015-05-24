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
create table petitiineaprobate(
    idpetitie number(10) primary key,
    idinitiator number(10) references conturi(idcont),
    nume varchar2(22),
    destinatar number(10),
    descriere varchar2(500),
    categorie varchar2(100)
    )
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
insert into categorii values(1,'mediu inconjurator')
/
insert into categorii values(2,'drepturile omului')
/
insert into categorii values(3,'educatie')
/
insert into categorii values(4,'sanatate')
/
insert into categorii values(6,'tehnologie')
/
insert into categorii values(5,'nedreptati generale')
/
insert into conturi values(100,'usertest','pass')
/
insert into petitiiaprobate values(1,0,100,'petitie1',1111,'preturi mari',1,sysdate)
/
insert into petitiiaprobate values(2,0,100,'petitie2',1111,'preturi mari',1,sysdate-2)
/
insert into petitiiaprobate values(3,0,100,'petitie3',1111,'preturi mari',1,sysdate-3)
/
insert into petitiiaprobate values(4,0,100,'petitie4',1111,'preturi mari',1,sysdate-4)
/
insert into petitiiaprobate values(5,0,100,'petitie5',1111,'preturi mari',1,sysdate-5)
/
insert into comentarii values(7,sysdate,100,2,'comaodmfoadsmf asdfoasdfoasmdo faosdkf oaskdfokasdofkoas dkf')
/
insert into comentarii values(2,sysdate,100,2,'comaodmfofaosdkf oaskdfokasdofkoas dkf')
/
insert into comentarii values(5,sysdate,100,1,'kasdofkoas dkf')
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
    insert into petitiiaprobate values(getnoofpetitions()+1,0,idinitiator,nume,destinatar,descriere,categorie,sysdate);
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