
/*
Nume proiect:Pet4Web

Descriere
Proiectul consta intr-o aplicatie Web care permite crearea si gestionarea de diverse petitii online, putand fi exploatata si via dispozitive mobile eterogene. 
Administratorul sitului va putea avea acces la rapoarte -- disponibile in formatele HTML, CSV si PDF -- privind starea petitiilor, numarul de solicitanti, 
destinatarii petitiilor etc. O persoana nu va putea semna de mai multe ori o petitie. 
De asemenea, se va oferi suport pentru partajarea datelor referitoare la petitii in cadrul diverselor retele sociale.

•       Restrictionarea persoanelor de a vota o singura data o petitie;
•       Partajarea datelor referitoare la petitii pe diverse retele sociale;

*/

drop table petitiiAprobate;
create table petitiiAprobate(
    idPetitie number(10) primary key,
    voturi number(10),
    idInitiator number(10) references Conturi(idCont),
    nume varchar2(22),
    destinatar number(10),
    descriere varchar2(500),
    categorie varchar2(100)
    )
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
/
insert into petitiiAprobate values(10,0,100,'nume',3,'descriere')
/
--insert into petitiiAprobate(idPetitie,voturi,idInitiator,nume,destinatar,descriere) values ($nume,$email,$descriere,$destinatar);
/
select * from petitiiaprobate;

create table Conturi(
    idCont number(10) primary key,
    username  varchar2(100),
    password varchar2(100)
    )
    
/
insert into conturi values(100,'userSpam','haha')

/

drop table comentarii;
create table Comentarii(
    idComentariu number(10) primary key,
    dataPostarii date,
    idCont number(10) references Conturi(IdCont),
    idPetitie number(10) references petitiiAprobate(idPetitie),
    text varchar2(300)
    )
/
create table voturi(
    idCont  number(10) ,
    petitieVotata number(10) references PetitiiAprobate(idPetitie),
    ip varchar(50)
    );
    /
    
    create or replace procedure createSpam is
    idcom number;
    begin
    idcom := 0;
    for i in 1 .. 500000 loop
        insert into Comentarii  values(idcom,SYSDATE,100,10,dbms_random.string('L', 20));
        idcom := idcom +1;
        
        
    end loop;
    end;
    /
    begin
    createSpam;
    end;
    /
    select * from comentarii;