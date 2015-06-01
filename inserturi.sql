
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
insert into petitii values(1,0,100,'petitie1',1111,'preturi mari',1,sysdate)
/
insert into petitii values(2,0,100,'petitie2',1111,'preturi mari',1,sysdate-2)
/
insert into petitii values(3,0,100,'petitie3',1111,'preturi mari',1,sysdate-3)
/
insert into petitii values(4,0,100,'petitie4',1111,'preturi mari',1,sysdate-4)
/
insert into petitii values(5,0,100,'petitie5',1111,'preturi mari',1,sysdate-5)
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
for i in 1..500000 loop
  insert into comentarii(datapostarii,idcont,idpetitie,textcomentariu ) 
    values(sysdate,100,2,'text'||i);
end loop;
end;
/
set serveroutput on;
/
select * from petitii
/
select * from comentarii where idpetitie=6;
delete from comentarii where idpetitie=6
;
begin
  for i in 1..13 loop
    insert into comentarii(idcont,idpetitie,textcomentariu) values(100,6,'comm'||i); 
    end loop;
end;

/


select * from(
						SELECT c.IDCOMENTARIU,c.datapostarii,c.idcont,c.idpetitie,c.textComentariu,p.nume,j.username 
						FROM Comentarii c join petitii p on c.idPetitie=p.idPetitie 
						join Conturi j on j.idCont=c.idCont 
						where c.idPetitie=6 and 
						rownum<6 order by c.IDCOMENTARIU   ) 
			where rownum <=5 
      order by idcomentariu desc
      /
      
      SELECT c.IDCOMENTARIU,c.datapostarii,c.idcont,c.idpetitie,c.textComentariu,p.nume,j.username 
						FROM Comentarii c join petitii p on c.idPetitie=p.idPetitie 
						join Conturi j on j.idCont=c.idCont 
						where c.idPetitie=6 and 
						rownum<6 order by idcomentariu
            
            
///

select * from(
		SELECT c.IDCOMENTARIU,c.datapostarii,c.idcont,c.idpetitie,c.textComentariu,p.nume,j.username 
		FROM Comentarii c join petitii p on c.idPetitie=p.idPetitie 
		join Conturi j on j.idCont=c.idCont 
		where c.idPetitie=6 and rownum<9 order by c.idComentariu desc) 
	where rownum <4;
  /
  select * from (select * from (select * from comentarii where rownum <6 ) order by idcomentariu desc) where rownum<4
  
	
            