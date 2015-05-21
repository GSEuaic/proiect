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
    nume varchar2(200),
    destinatar varchar2(200),
    descriere varchar2(1000),
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
insert into comentarii values(7,sysdate,100,2,'comaodmfoadsmf asdfoasdfoasmdo faosdkf oaskdfokasdofkoas dkf')
/
insert into comentarii values(2,sysdate,100,2,'comaodmfofaosdkf oaskdfokasdofkoas dkf')
/
insert into comentarii values(5,sysdate,100,1,'kasdofkoas dkf')
/
drop  procedure getName
/
create procedure getName(id_Pet number, numePet out varchar2, descPet out varchar2) as
    begin
    select descriere,nume into descPet,numePet from PetitiiAprobate where idPetitie=id_Pet; 
end getName;
/
drop function getNoOfPetitions
/
create function getNoOfPetitions return number is
nr number;
begin
    select max(idPetitie)+1 into nr from petitiiAprobate;
    return nr;
end getNoOfPetitions;
/
drop procedure adaugaPetitie
/
create procedure adaugaPetitie(idInitiator number,nume varchar2,destinatar varchar2,descriere varchar2,categorie varchar2)
is
begin
    insert into petitiiAprobate values(getNoOfPetitions()+1,0,idInitiator,nume,destinatar,descriere,categorie,sysdate);
end adaugaPetitie;
/
drop function getNewContid
/
create function getNewContid return number
    as
    idc number;
    begin
    select max(idCont) into idC from conturi;
    idc:=idc+1;
    return idc;
end getNewContid;
/
drop procedure adaugaCont
/
create procedure adaugaCont(user varchar2, pass varchar2) as
idcont number;
begin
    insert into conturi values(getNewContId(),user,pass);
end adaugaCont;
/

create or replace directory myCSV as 'c:\proiect'
/
grant read,write on directory myCSV to sys
/
drop procedure makecsv
/
create procedure makeCSV as
/
declare
cursor cursorConturi is select * from conturi;
cursor cursorPetitii is select * from petitiiAprobate;
cursor cursorComentarii is select * from Comentarii;
cursor cursorCategorii is select * from categorii;
cate number;
v_file UTL_FILE.FILE_TYPE;
BEGIN
  v_file:= UTL_FILE.FOPEN ('MYCSV', 'backup2.csv', 'w');
  select count(*) into cate from conturi;
  UTL_FILE.PUT_LINE(v_file,cate);                      
      --UTL_FILE.NEW_LINE (v_file);  
  for i in cursorConturi loop
      UTL_FILE.PUT_LINE(v_file,i.idCont||','||i.username||','||i.password);                      
      --UTL_FILE.NEW_LINE (v_file);
  end loop;
  select count(*) into cate from petitiiAprobate;
  UTL_FILE.PUT_LINE(v_file,cate);                      
  --UTL_FILE.NEW_LINE (v_file);  
  for i in cursorPetitii loop
      UTL_FILE.PUT_LINE(v_file,i.idPetitie||','||i.voturi||','||i.idInitiator||','
                        ||i.nume||','||i.destinatar||','||i.descriere||','||
                        i.categorie||','||i.dataPostare);                      
      --UTL_FILE.NEW_LINE (v_file);  
  end loop;
  select count(*) into cate from Comentarii;
  UTL_FILE.PUT_LINE(v_file,cate);                      
  --UTL_FILE.NEW_LINE (v_file);  
  for i in cursorComentarii loop
      UTL_FILE.PUT_LINE(v_file,i.idComentariu||','||i.dataPostarii||','||i.idCont||','
                        ||i.idPetitie||','||i.textComentariu);                      
      --UTL_FILE.NEW_LINE (v_file);  
  end loop;
  select count(*) into cate from categorii;
  UTL_FILE.PUT_LINE(v_file,cate);                      
  --UTL_FILE.NEW_LINE (v_file);  
  for i in cursorCategorii loop
      UTL_FILE.PUT_LINE(v_file,i.idCategorie||','||i.nume);                      
      --UTL_FILE.NEW_LINE (v_file);  
  end loop;
  UTL_FILE.FCLOSE (v_file);
EXCEPTION
WHEN UTL_FILE.INVALID_FILEHANDLE THEN 
RAISE_APPLICATION_ERROR(-20001,'Invalid File.');
WHEN UTL_FILE.WRITE_ERROR THEN --8
RAISE_APPLICATION_ERROR (-20002, 'Unable to write to file');
END;
/
drop procedure readCSV
/
create procedure readCSV as
    Fi UTL_FILE.FILE_TYPE;
    V_Line varchar2(2000);
    text1 VARCHAR2(1000);
    text2 varchar2(1000);
    text3 VARCHAR2(1000);
    text4 VARCHAR2(1000);
    number1 number;
    number2 number;
    number3 number;
    data1 date;
    cate number :=0;
    linie number :=0;
  BEGIN
    Fi := UTL_FILE.FOPEN ('MYCSV', 'backup2.csv', 'r');
    IF UTL_FILE.IS_OPEN(Fi) THEN
    --incepe citirea
    UTL_FILE.GET_LINE(Fi, V_LINE, 2000);
    --linie:=linie+1;
    dbms_output.put_line(v_line);
    cate:=to_number(V_LINE);
      for i in 1..cate loop
        BEGIN
          UTL_FILE.GET_LINE(Fi, V_LINE, 2000);
          IF V_LINE IS NULL THEN
            EXIT;
          END IF;
          number1 := to_number(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1));
          text1:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2);
          text2:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3);
          DBMS_OUTPUT.PUT_LINE('insert into Conturi values('||number1||','||text1||','||text2||')');
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
        END;
      END LOOP;
      ---gata conturi
      UTL_FILE.GET_LINE(Fi, V_LINE, 2000);
      cate:=to_number(V_LINE);
      for i in 1..cate loop
        BEGIN
          UTL_FILE.GET_LINE(Fi, V_LINE, 2000);
          IF V_LINE IS NULL THEN
            EXIT;
          END IF;
          number1 := to_number(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1));
          number2 := to_number(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2));
          number3 := to_number(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3));
          text1:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 4);
          text2:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 5);
          text3:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 6);
          text4:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 7);
          data1 :=to_date(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 8));
          DBMS_OUTPUT.PUT_LINE('insert into pettii values('||number1||','||number2||','||number3||')'||data1);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
        END;
      END LOOP;
      ----gata petitiile
      UTL_FILE.GET_LINE(Fi, V_LINE, 2000);
      cate:=to_number(V_LINE);
      for i in 1..cate loop
        BEGIN
          UTL_FILE.GET_LINE(Fi, V_LINE, 2000);
          IF V_LINE IS NULL THEN
            EXIT;
          END IF;
          number1 := to_number(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1));
          data1 := to_date(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2));
          number2 := to_number(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3));
          number3:=to_number(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 4));
          text1:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 5);
          DBMS_OUTPUT.PUT_LINE('insert into pettii comentarii('||number1||','||data1||','||number2||','||number3);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
        END;
      END LOOP;
      --gata comentariile
      UTL_FILE.GET_LINE(Fi, V_LINE, 2000);
      cate:=to_number(V_LINE);
      for i in 1..cate loop
        BEGIN
          UTL_FILE.GET_LINE(Fi, V_LINE, 2000);
          IF V_LINE IS NULL THEN
            EXIT;
          END IF;
          number1 := to_number(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1));
          text1 := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2);
          DBMS_OUTPUT.PUT_LINE('insert into pettii comentarii('||number1||','||text1||')');
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
        END;
      END LOOP;
      --gata categoriile
      --gata citirea
    END IF;
    UTL_FILE.FCLOSE(Fi);
  END;