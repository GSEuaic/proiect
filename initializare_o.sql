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
/

create or replace directory mycsv as 'c:\proiect'
/
grant read,write on directory mycsv to sys
/
CREATE OR REPLACE PACKAGE CSV_UTIL AS
PROCEDURE MAKECSV;
PROCEDURE READCSV;
END CSV_UTIL;
/
CREATE OR REPLACE PACKAGE BODY CSV_UTIL AS PROCEDURE MAKECSV IS
CURSOR CURSORCONTURI IS SELECT * FROM CONTURI;
CURSOR CURSORPETITII IS SELECT * FROM PETITIIAPROBATE;
CURSOR CURSORCOMENTARII IS SELECT * FROM COMENTARII;
CURSOR CURSORCATEGORII IS SELECT * FROM CATEGORII;
CATE NUMBER;
V_FILE UTL_FILE.FILE_TYPE;
BEGIN
  V_FILE:= UTL_FILE.FOPEN ('MYCSV', 'BACKUP.CSV', 'W');
  SELECT COUNT(*) INTO CATE FROM CONTURI;
  UTL_FILE.PUT_LINE(V_FILE,CATE);                      
      --UTL_FILE.NEW_LINE (V_FILE);  
  FOR I IN CURSORCONTURI LOOP
      UTL_FILE.PUT_LINE(V_FILE,I.IDCONT||','||I.USERNAME||','||I.PASSWORD);                      
      --UTL_FILE.NEW_LINE (V_FILE);
  END LOOP;
  SELECT COUNT(*) INTO CATE FROM PETITIIAPROBATE;
  UTL_FILE.PUT_LINE(V_FILE,CATE);                      
  --UTL_FILE.NEW_LINE (V_FILE);  
  FOR I IN CURSORPETITII LOOP
      UTL_FILE.PUT_LINE(V_FILE,I.IDPETITIE||','||I.VOTURI||','||I.IDINITIATOR||','
                        ||I.NUME||','||I.DESTINATAR||','||I.DESCRIERE||','||
                        I.CATEGORIE||','||I.DATAPOSTARE);                      
      --UTL_FILE.NEW_LINE (V_FILE);  
  END LOOP;
  SELECT COUNT(*) INTO CATE FROM COMENTARII;
  UTL_FILE.PUT_LINE(V_FILE,CATE);                      
  --UTL_FILE.NEW_LINE (V_FILE);  
  FOR I IN CURSORCOMENTARII LOOP
      UTL_FILE.PUT_LINE(V_FILE,I.IDCOMENTARIU||','||I.DATAPOSTARII||','||I.IDCONT||','
                        ||I.IDPETITIE||','||I.TEXTCOMENTARIU);                      
      --UTL_FILE.NEW_LINE (V_FILE);  
  END LOOP;
  SELECT COUNT(*) INTO CATE FROM CATEGORII;
  UTL_FILE.PUT_LINE(V_FILE,CATE);                      
  --UTL_FILE.NEW_LINE (V_FILE);  
  FOR I IN CURSORCATEGORII LOOP
      UTL_FILE.PUT_LINE(V_FILE,I.IDCATEGORIE||','||I.NUME);                      
      --UTL_FILE.NEW_LINE (V_FILE);  
  END LOOP;
  UTL_FILE.FCLOSE (V_FILE);
EXCEPTION
WHEN UTL_FILE.INVALID_FILEHANDLE THEN 
RAISE_APPLICATION_ERROR(-20001,'INVALID FILE.');
WHEN UTL_FILE.WRITE_ERROR THEN --8
RAISE_APPLICATION_ERROR (-20002, 'UNABLE TO WRITE TO FILE');
END;
PROCEDURE READCSV IS
    FI UTL_FILE.FILE_TYPE;
    V_LINE VARCHAR2(2000);
    TEXT1 VARCHAR2(1000);
    TEXT2 VARCHAR2(1000);
    TEXT3 VARCHAR2(1000);
    TEXT4 VARCHAR2(1000);
    NUMBER1 NUMBER;
    NUMBER2 NUMBER;
    NUMBER3 NUMBER;
    DATA1 DATE;
    CATE NUMBER :=0;
    LINIE NUMBER :=0;
  BEGIN
    FI := UTL_FILE.FOPEN ('MYCSV', 'BACKUP.CSV', 'R');
    IF UTL_FILE.IS_OPEN(FI) THEN
    --INCEPE CITIREA
    UTL_FILE.GET_LINE(FI, V_LINE, 2000);
    LINIE:=LINIE+1;
    DBMS_OUTPUT.PUT_LINE(V_LINE);
    CATE:=TO_NUMBER(V_LINE);
      FOR I IN 1..CATE LOOP
        BEGIN
          UTL_FILE.GET_LINE(FI, V_LINE, 2000);
          IF V_LINE IS NULL THEN
            EXIT;
          END IF;
          NUMBER1 := TO_NUMBER(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1));
          TEXT1:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2);
          TEXT2:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3);
          DBMS_OUTPUT.PUT_LINE('INSERT INTO CONTURI VALUES('||NUMBER1||','||TEXT1||','||TEXT2||')');
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
        END;
      END LOOP;
      ---GATA CONTURI
      UTL_FILE.GET_LINE(FI, V_LINE, 2000);
      CATE:=TO_NUMBER(V_LINE);
      FOR I IN 1..CATE LOOP
        BEGIN
          UTL_FILE.GET_LINE(FI, V_LINE, 2000);
          IF V_LINE IS NULL THEN
            EXIT;
          END IF;
          NUMBER1 := TO_NUMBER(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1));
          NUMBER2 := TO_NUMBER(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2));
          NUMBER3 := TO_NUMBER(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3));
          TEXT1:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 4);
          TEXT2:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 5);
          TEXT3:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 6);
          TEXT4:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 7);
          DATA1 :=TO_DATE(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 8));
          DBMS_OUTPUT.PUT_LINE('INSERT INTO PETTII VALUES('||NUMBER1||','||NUMBER2||','||NUMBER3||')'||DATA1);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
        END;
      END LOOP;
      ----GATA PETITIILE
        UTL_FILE.GET_LINE(FI, V_LINE, 2000);
      CATE:=TO_NUMBER(V_LINE);
      FOR I IN 1..CATE LOOP
        BEGIN
          UTL_FILE.GET_LINE(FI, V_LINE, 2000);
          IF V_LINE IS NULL THEN
            EXIT;
          END IF;
          NUMBER1 := TO_NUMBER(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1));
          DATA1 := TO_DATE(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2));
          NUMBER2 := TO_NUMBER(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3));
          NUMBER3:=TO_NUMBER(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 4));
          TEXT1:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 5);
          DBMS_OUTPUT.PUT_LINE('INSERT INTO PETTII COMENTARII('||NUMBER1||','||DATA1||','||NUMBER2||','||NUMBER3);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
        END;
      END LOOP;
      --GATA COMENTARIILE
      UTL_FILE.GET_LINE(FI, V_LINE, 2000);
      CATE:=TO_NUMBER(V_LINE);
      FOR I IN 1..CATE LOOP
        BEGIN
          UTL_FILE.GET_LINE(FI, V_LINE, 2000);
          IF V_LINE IS NULL THEN
            EXIT;
          END IF;
          NUMBER1 := TO_NUMBER(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1));
          TEXT1 := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2);
          DBMS_OUTPUT.PUT_LINE('INSERT INTO PETTII COMENTARII('||NUMBER1||','||TEXT1||')');
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
        END;
      END LOOP;
      --GATA CATEGORIILE
      --GATA CITIREA
    END IF;
    UTL_FILE.FCLOSE(FI);
  END;
END CSV_UTIL;
/
begin
--csv_util.makecsv;
csv_util.readcsv;
end;
/