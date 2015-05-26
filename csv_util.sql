CREATE 
OR 
replace directory mycsv AS 'c:\proiect' 
/ 
GRANT READ,WRITE ON directory mycsv TO sys 
/ 
CREATE OR replace PACKAGE csv_util 
AS 
PROCEDURE makecsv;PROCEDURE readcsv; 
  FUNCTION formatline(line VARCHAR2) 
    RETURN VARCHAR2; 
  FUNCTION getNext(linie IN OUT VARCHAR2) 
    RETURN VARCHAR2; 
  procedure dropAllTheTables;
  END csv_util; 
/ 
CREATE OR replace PACKAGE BODY 
  csv_util 
AS 
PROCEDURE makecsv 
IS 
  CURSOR cursorconturi IS 
    SELECT * 
    FROM   conturi; 

CURSOR cursorpetitii IS 
  SELECT * 
  FROM   petitii; 

CURSOR cursorcomentarii IS 
  SELECT * 
  FROM   comentarii; 

CURSOR cursorcategorii IS 
  SELECT * 
  FROM   categorii; 

v_file utl_file.file_type; 
BEGIN 
  v_file:= utl_file.fopen ('MYCSV', 'A_CONTURI.CSV', 'W'); 
  utl_file.put_line(v_file,'idcont,username,password,'); 
  FOR i IN cursorconturi 
  LOOP 
    utl_file.put_line(v_file,i.idcont 
    ||',' 
    ||csv_util.formatline(i.username) 
    ||',' 
    ||csv_util.formatline(i.password)); 
  END LOOP; 
  utl_file.fclose (v_file); 
  v_file:= utl_file.fopen ('MYCSV', 'A_PETITII.CSV', 'W'); 
  utl_file.put_line(v_file,'idpetitie,voturi,idinitiator,nume,destinatar,descriere,categorie, datapostare,');
  FOR i IN cursorpetitii 
  LOOP 
    utl_file.put_line(v_file,i.idpetitie 
    ||',' 
    ||i.voturi 
    ||',' 
    ||i.idinitiator 
    ||',' 
    ||csv_util.formatline(i.nume) 
    ||',' 
    ||csv_util.formatline(i.destinatar) 
    ||',' 
    ||csv_util.formatline(i.descriere) 
    ||',' 
    || i.categorie 
    ||',' 
    ||i.datapostare); 
  END LOOP; 
  utl_file.fclose (v_file); 
  v_file:= utl_file.fopen ('MYCSV', 'A_COMENTARII.CSV', 'W'); 
  utl_file.put_line(v_file,'idcomentariu,datapostarii,idcont,idpetitie,textcomentariu'); 
  FOR i IN cursorcomentarii 
  LOOP 
    utl_file.put_line(v_file,i.idcomentariu 
    ||',' 
    ||i.datapostarii 
    ||',' 
    ||i.idcont 
    ||',' 
    ||i.idpetitie 
    ||',' 
    ||csv_util.formatline(i.textcomentariu)); 
  END LOOP; 
  utl_file.fclose (v_file); 
  v_file:= utl_file.fopen ('MYCSV', 'A_CATEGORII.CSV', 'W'); 
  utl_file.put_line(v_file,'idcategorie,nume'); 
  FOR i IN cursorcategorii 
  LOOP 
    utl_file.put_line(v_file,i.idcategorie 
    ||',' 
    ||csv_util.formatline(i.nume)); 
  END LOOP; 
  utl_file.fclose (v_file); 
EXCEPTION 
WHEN utl_file.invalid_filehandle THEN 
  raise_application_error(-20001,'INVALID FILE.'); 
WHEN utl_file.write_error THEN --8 
  raise_application_error (-20002, 'UNABLE TO WRITE TO FILE'); 
END; 
PROCEDURE readcsv 
IS 
  fisier varchar2(100);
  fi utl_file.file_type; 
  v_line  VARCHAR2(2000); 
  text1   VARCHAR2(1000); 
  text2   VARCHAR2(1000); 
  text3   VARCHAR2(1000); 
  text4   VARCHAR2(1000); 
  number1 NUMBER; 
  number2 NUMBER; 
  number3 NUMBER; 
  data1   DATE; 
  cate    NUMBER :=0; 
  linie   NUMBER :=0; 
BEGIN 
  fisier:='A_CONTURI.CSV';
  fi := utl_file.fopen ('MYCSV', 'A_CONTURI.CSV', 'R'); 
  IF utl_file.is_open(fi) THEN 
    utl_file.get_line(fi, v_line, 2000); 
    linie:=linie+1;------------------------------------------------------------------------------------- 
    LOOP 
      BEGIN 
        utl_file.get_line(fi, v_line, 2000); 
        linie:=linie+1;
        IF v_line IS NULL THEN 
          EXIT; 
        END IF; 
        number1 := to_number(csv_util.getNext(v_line)); 
        text1:=csv_util.getNext(v_line); 
        text2:=csv_util.getNext(v_line); 
        dbms_output.put_line('INSERT INTO CONTURI VALUES(' ||number1 ||',"' ||text1 ||'","' ||text2 ||'")'); 
        insert into Conturi values(number1,text1,text2);
      EXCEPTION 
      WHEN no_data_found THEN 
        EXIT; 
      END; 
    END LOOP; 
    ---GATA CONTURI 
    fisier:='A_PETITII.CSV';
    fi := utl_file.fopen ('MYCSV', 'A_PETITII.CSV', 'R'); 
    utl_file.get_line(fi, v_line, 2000); 
    linie:=linie+1;
    LOOP 
      BEGIN 
        utl_file.get_line(fi, v_line, 2000); 
        linie:=linie+1;
        IF v_line IS NULL THEN 
          EXIT; 
        END IF; 
        number1 := to_number(csv_util.getNext(v_line)); 
        number2 := to_number(csv_util.getNext(v_line)); 
        number3 := to_number(csv_util.getNext(v_line)); 
        text1:=csv_util.getNext(v_line); 
        text2:=csv_util.getNext(v_line);  
        text3:=csv_util.getNext(v_line);  
        text4:=csv_util.getNext(v_line);  
        data1:=csv_util.getNext(v_line);  
        dbms_output.put_line('INSERT INTO PETTII VALUES(' ||number1 ||'","' ||number2 ||'","' ||number3 ||'","'||text1 ||'","' ||data1||');'); 
        insert into petitii values(number1,number2,number3,text1,text2,text3,text4,data1);
      EXCEPTION 
      WHEN no_data_found THEN 
        EXIT; 
      END; 
    END LOOP; 
    ----GATA PETITIILE 
    fisier:='A_COMENTARII.CSV';
    fi := utl_file.fopen ('MYCSV', 'A_COMENTARII.CSV', 'R'); 
    utl_file.get_line(fi, v_line, 2000); 
    linie:=linie+1;
    LOOP 
      BEGIN 
        utl_file.get_line(fi, v_line, 2000); 
        linie:=linie+1;
        IF v_line IS NULL THEN 
          EXIT; 
        END IF;
        number1 := to_number(csv_util.getNext(v_line)); 
        data1 := to_date(csv_util.getNext(v_line)); 
        number2 := to_number(csv_util.getNext(v_line)); 
        number3:=to_number(csv_util.getNext(v_line)); 
        text1:=csv_util.getNext(v_line); 
        dbms_output.put_line('INSERT INTO COMENTARII(' ||number1 ||',' ||data1 ||',' ||number2 ||',' ||number3); 
        insert into comentarii values(number1,data1,number2,number3,text1);
      EXCEPTION 
      WHEN no_data_found THEN 
        EXIT; 
      END; 
    END LOOP; 
    --GATA COMENTARIILE 
    fisier:='A_CATEGORII.CSV';
    fi := utl_file.fopen ('MYCSV', 'A_CATEGORII.CSV', 'R'); 
    utl_file.get_line(fi, v_line, 2000);  
    linie:=linie+1;
    LOOP 
      BEGIN 
        utl_file.get_line(fi, v_line, 2000); 
        linie:=linie+1;
        IF v_line IS NULL THEN 
          EXIT; 
        END IF; 
        number1 := to_number(csv_util.getNext(v_line)); 
        text1 := csv_util.getNext(v_line); 
        dbms_output.put_line('INSERT INTO CATEGORII(' ||number1 ||',' ||text1 ||')'); 
        insert into categorii values(number1,text1);
      EXCEPTION 
      WHEN no_data_found THEN 
        EXIT; 
      END; 
    END LOOP; 
    
    --GATA CATEGORIILE 
    --GATA CITIREA 
  END IF; 
  utl_file.fclose(fi); 
  exception when others then
     raise_application_error (-20001,'eroare cauzata de linia :'||linie||'in fisierul '||fisier);
END; 
FUNCTION formatline(line VARCHAR2) 
  RETURN VARCHAR2 
IS 
  rez VARCHAR2(10000); 
BEGIN 
  rez:=replace(line,'"','""'); 
  IF(instr(rez,',')>0) THEN 
    rez:='"' 
    ||rez 
    ||'"'; 
  END IF; 
  dbms_output.put_line(line); 
  RETURN rez; 
END; 
FUNCTION getNext(linie IN OUT VARCHAR2) 
  RETURN VARCHAR2 AS pana NUMBER:=0;
  aux varchar2(1000);
  BEGIN 
    IF(instr(linie,'"')=1) THEN 
      pana:=instr(linie,'",');
      aux:=linie;
      linie:=substr(linie,pana+2); 
      RETURN substr(aux,2,pana-2); 
    ELSE 
      pana:=instr(linie,','); 
      IF(pana=0) THEN 
        RETURN linie; 
      ELSE 
      aux:=linie;
        linie:=substr(linie,pana+1); 
        RETURN substr(aux,0,pana-1); 
      END IF; 
    END IF; 
  END; 
  procedure dropAllTheTables is
  v_CursorID NUMBER;
  v_String VARCHAR2(500);
  v_NUMRows INTEGER; 
  begin
  v_CursorID:= DBMS_SQL.OPEN_CURSOR;
  v_String :='drop table petitii cascade constraints';
  DBMS_SQL.PARSE(v_CursorID,v_String,DBMS_SQL.V7);
  v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
  v_String :='drop table Comentarii cascade constraints';
  DBMS_SQL.PARSE(v_CursorID,v_String,DBMS_SQL.V7);
  v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
  v_String :='drop table Categorii cascade constraints';
  DBMS_SQL.PARSE(v_CursorID,v_String,DBMS_SQL.V7);
  v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
  v_String :='drop table Conturi cascade constraints';
  DBMS_SQL.PARSE(v_CursorID,v_String,DBMS_SQL.V7);
  v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
  end;
  
  
  END csv_util; 
  /

  begin
  csv_util.readcsv;end;
  /
  truncate table categorii;
  truncate table comentarii;
  truncate table conturi;
