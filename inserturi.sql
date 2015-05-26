
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
insert into comentarii(datapostarii,idcont,idpetitie,textcomentariu ) 
  values(sysdate,100,2,'1comaodmfoadsmf asdfoasdfoasmdo faosdkf oaskdfokasdofkoas dkf')
/
insert into comentarii(datapostarii,idcont,idpetitie,textcomentariu ) 
  values(sysdate,100,2,'2comaodmfoadsmf asdfoasdfoasmdo faosdkf oaskdfokasdofkoas dkf')
/
insert into comentarii(datapostarii,idcont,idpetitie,textcomentariu ) 
  values(sysdate,100,2,'3comaodmfoadsmf asdfoasdfoasmdo faosdkf oaskdfokasdofkoas dkf')
/
insert into comentarii(datapostarii,idcont,idpetitie,textcomentariu ) 
  values(sysdate,100,2,'4comaodmfoadsmf asdfoasdfoasmdo faosdkf oaskdfokasdofkoas dkf')
/
insert into comentarii(datapostarii,idcont,idpetitie,textcomentariu ) 
  values(sysdate,100,2,'tex1')
/
begin
for i in 1..20000 loop
  insert into comentarii(datapostarii,idcont,idpetitie,textcomentariu ) 
    values(sysdate,100,2,'text'||i);
  
end loop;
end;
/
set serveroutput on;
/
select count(*) from comentarii