create or replace procedure getName(id_Pet number) as
	numePet varchar2(100);
	begin
    select nume into numePet from PetitiiAprobate where idPetitie=id_Pet; 
    dbms_output.put_line(numePet);
  end getName;