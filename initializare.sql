drop table Conturi cascade constraints
/
create table Conturi(
    idCont number(10) primary key,
    username  varchar2(100),
    password varchar2(100)
    )   
/
drop table petitiiAprobate cascade constraints
/
create table petitiiAprobate(
    idPetitie number(10) primary key,
    voturi number(10),
    idInitiator number(10) references Conturi(idCont),
    nume varchar2(22),
    destinatar number(10),
    descriere varchar2(500),
    categorie varchar2(100),
    dataPostare date
    )
/
drop table petitiiNeaprobate cascade constraints
/
create table petitiiNeaprobate(
    idPetitie number(10) primary key,
    idInitiator number(10) references Conturi(idCont),
    nume varchar2(22),
    destinatar number(10),
    descriere varchar2(500),
    categorie varchar2(100)
    )
/
drop table comentarii cascade constraints
/
create table Comentarii(
    idComentariu number(10) primary key,
    dataPostarii date,
    idCont number(10) references Conturi(IdCont),
    idPetitie number(10) references petitiiAprobate(idPetitie),
    textComentariu varchar2(300)
    )
/
drop table voturi cascade constraints
/
create table voturi(
    idCont  number(10) ,
    petitieVotata number(10) references PetitiiAprobate(idPetitie),
    ip varchar(50)
    )
/
drop table Categorii cascade constraints   
/
create table Categorii(
    idCategorie  number(2) ,
    nume varchar2(50)
    )
/
insert into Categorii values(1,'Mediu inconjurator')
/
insert into Categorii values(2,'Drepturile omului')
/
insert into Categorii values(3,'Educatie')
/
insert into Categorii values(4,'Sanatate')
/
insert into Categorii values(6,'Tehnologie')
/
insert into Categorii values(5,'Nedreptati generale')
/
insert into Conturi values(100,'userTest','PASS')
/
insert into petitiiAprobate values(1,0,100,'petitie1',1111,'preturi mari',1,sysdate)
/
insert into petitiiAprobate values(2,0,100,'petitie2',1111,'preturi mari',1,sysdate-2)
/
insert into petitiiAprobate values(3,0,100,'petitie3',1111,'preturi mari',1,sysdate-3)
/
insert into petitiiAprobate values(4,0,100,'petitie4',1111,'preturi mari',1,sysdate-4)
/
insert into petitiiAprobate values(5,0,100,'petitie5',1111,'preturi mari',1,sysdate-5)
/
insert into comentarii values(1,sysdate,100,1,'comaodmfoadsmf asdfoasdfoasmdo faosdkf oaskdfokasdofkoas dkf')
/
insert into comentarii values(2,sysdate,100,1,'comaodmfofaosdkf oaskdfokasdofkoas dkf')
/
insert into comentarii values(5,sysdate,100,1,'kasdofkoas dkf')