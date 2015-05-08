drop table petitiiAprobate;
create table petitiiAprobate(
    idPetitie number(10) primary key,
    voturi number(10),
    idInitiator number(10) references Conturi(idCont),
    nume varchar2(22),
    destinatar number(10),
    descriere varchar2(500),
    categorie varchar2(100)
    );
create table petitiiNeaprobate(
    idPetitie number(10) primary key,
    idInitiator number(10) references Conturi(idCont),
    nume varchar2(22),
    destinatar number(10),
    descriere varchar2(500),
    categorie varchar2(100)
    );
create or replace type Conturi as object(
    idCont number(10) primary key,
    username  varchar2(100),
    password varchar2(100)
    );
drop table comentarii;
create table Comentarii(
    idComentariu number(10) primary key,
    dataPostarii date,
    idCont number(10) references Conturi(IdCont),
    idPetitie number(10) references petitiiAprobate(idPetitie),
    text varchar2(300)
    );
create table voturi(
    idCont  number(10) ,
    petitieVotata number(10) references PetitiiAprobate(idPetitie),
    ip varchar(50)
    );