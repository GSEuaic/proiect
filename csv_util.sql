create or replace directory mycsv as 'c:\proiect'
/
grant read,write on directory mycsv to sys
/
CREATE OR REPLACE PACKAGE CSV_UTIL AS
PROCEDURE MAKECSV;
PROCEDURE READCSV;
function formatLine(line varchar2) return varchar2;
function getNextVarchar(linie varchar2) return varchar2;
END CSV_UTIL;
/
CREATE OR REPLACE PACKAGE BODY CSV_UTIL AS 
PROCEDURE MAKECSV IS
CURSOR CURSORCONTURI IS SELECT * FROM CONTURI;
CURSOR CURSORPETITII IS SELECT * FROM PETITIIAPROBATE;
CURSOR CURSORCOMENTARII IS SELECT * FROM COMENTARII;
CURSOR CURSORCATEGORII IS SELECT * FROM CATEGORII;
V_FILE UTL_FILE.FILE_TYPE;
BEGIN
  V_FILE:= UTL_FILE.FOPEN ('MYCSV', 'A_CONTURI.CSV', 'W');
  UTL_FILE.PUT_LINE(V_FILE,'idcont,username,password,');
  FOR I IN CURSORCONTURI LOOP
      UTL_FILE.PUT_LINE(V_FILE,I.IDCONT||','||csv_util.formatline(I.USERNAME)||','||csv_util.formatline(I.PASSWORD));
  END LOOP;
  UTL_FILE.FCLOSE (V_FILE);
  
  V_FILE:= UTL_FILE.FOPEN ('MYCSV', 'A_PETITII.CSV', 'W');
  UTL_FILE.PUT_LINE(V_FILE,'idpetitie,voturi,idinitiator,nume,destinatar,descriere,categorie, datapostare,');
  FOR I IN CURSORPETITII LOOP
      UTL_FILE.PUT_LINE(V_FILE,I.IDPETITIE||','||I.VOTURI||','||I.IDINITIATOR||','
                        ||csv_util.formatline(I.NUME)||','||csv_util.formatline(I.DESTINATAR)||','||csv_util.formatline(I.DESCRIERE)||','||
                        I.CATEGORIE||','||I.DATAPOSTARE);                      
  END LOOP;
  UTL_FILE.FCLOSE (V_FILE);
  
  V_FILE:= UTL_FILE.FOPEN ('MYCSV', 'A_COMENTARII.CSV', 'W');
  UTL_FILE.PUT_LINE(V_FILE,'idcomentariu,datapostarii,idcont,idpetitie,textcomentariu');
  FOR I IN CURSORCOMENTARII LOOP
      UTL_FILE.PUT_LINE(V_FILE,I.IDCOMENTARIU||','||I.DATAPOSTARII||','||I.IDCONT||','
                        ||I.IDPETITIE||','||csv_util.formatline(I.TEXTCOMENTARIU));                      
  END LOOP;
  UTL_FILE.FCLOSE (V_FILE);
  
  V_FILE:= UTL_FILE.FOPEN ('MYCSV', 'A_CATEGORII.CSV', 'W');
  UTL_FILE.PUT_LINE(V_FILE,'idcategorie,nume');
  FOR I IN CURSORCATEGORII LOOP
      UTL_FILE.PUT_LINE(V_FILE,I.IDCATEGORIE||','||csv_util.formatline(I.NUME));                        
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
  function formatLine(line varchar2)
return varchar2 is
rez varchar2(10000);
begin
rez:=replace(line,'"','""');
if(instr(rez,',')>0) then
rez:='"'||rez||'"';
end if;
dbms_output.put_line(line);
return rez;
end;
function getNextVArchar(linie varchar2) return varchar2
  as
  pana number:=0;
  begin
  if(instr(linie,'"')>0)
    then
    pana:=instr(linie,'",');
    return substr(linie,2,pana-2);
    ELSE pana:=instr(linie,',');
    if(pana=0) then return linie;
    else
    return substr(linie,0,pana-1);
    end if;
  end if;
  end;
END CSV_UTIL;
/
begin
--csv_util.makecsv;
csv_util.readcsv;
end;
/
begin csv_util.makecsv;
end;
/
  begin readcsv;end;
/
create or replace PROCEDURE READCSV aS
    FI UTL_FILE.FILE_TYPE;
    V_LINE VARCHAR2(2000);
    LINE_AUX varchar2(2000);
    TEXT1 VARCHAR2(1000);
    TEXT2 VARCHAR2(1000);
    NUMBER1 NUMBER;
    LINIE NUMBER :=0;
    procesat number:=0;
  BEGIN
    FI := UTL_FILE.FOPEN ('MYCSV', 'A_CONTURI.CSV', 'R');
    IF UTL_FILE.IS_OPEN(FI) THEN
    --INCEPE CITIREA
    UTL_FILE.GET_LINE(FI, V_LINE, 2000);
    LINIE:=LINIE+1;
    DBMS_OUTPUT.PUT_LINE(V_LINE);
    
      LOOP
        BEGIN
          UTL_FILE.GET_LINE(FI, V_LINE, 2000);
          dbms_output.put_line('BEFORE:'||V_LINE);         
          IF V_LINE IS NULL THEN
            EXIT;
          END IF;
          NUMBER1 := TO_NUMBER(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1));
          v_line:=substr(v_line,length(number1)+2);
          text1:=csv_util.getNextVarchar(V_LINE);
          dbms_output.put_line('1.'||v_line);
          procesat:=length(text1)+2;
          if(instr(V_LINE,'"')=1) then procesat:=procesat+2;
          end if;
          v_line:=substr(v_line,procesat);
          
          dbms_output.put_line('1.'||v_line);
          text2:=csv_util.getnextvarchar(V_line);
          --TEXT2:=REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3);
          DBMS_OUTPUT.PUT_LINE('INSERT INTO CONTURI VALUES('||NUMBER1||','||TEXT1||','||TEXT2||')');
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
        END;
      END LOOP;
      --GATA CITIREA
    END IF;
    UTL_FILE.FCLOSE(FI);
  END;
  /
   begin readcsv;end;
   
   