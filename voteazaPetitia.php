<?php 
if($_REQUEST['cont']=='XPSe7450')echo "Nu sunteti autentificat";//redirect la login
else{
	$cont = $_COOKIE['logged'];
	$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}

	$xml=file_get_contents('http://www.telize.com/geoip');
	$infos = json_decode($xml);
	$ip = $infos->{'ip'};

	$sql = 'select count(*) from voturi where petitievotata=:idpet and ip=:ippppp';
	$stmt = oci_parse($conn,$sql);
	oci_bind_by_name($stmt,':ippppp',$ip);
	oci_bind_by_name($stmt,':idpet',$_REQUEST['idPet'],-1);
	oci_execute($stmt);
	oci_fetch_row($stmt);
	$numarVoturi = oci_result($stmt, 1);
	$sql = 'select count(*) from voturi where petitievotata=:idpet and idcont=:iddd';
	$stmt = oci_parse($conn,$sql);
	oci_bind_by_name($stmt,':iddd',$cont);

	oci_bind_by_name($stmt,':idpet',$_REQUEST['idPet'],-1);

	oci_execute($stmt);
	oci_fetch_row($stmt);
	$numarVoturi = oci_result($stmt, 1);
	if($numarVoturi > 0)
		echo "Ati votat de prea multe ori aceeasi petitie din aceeasi retea"; 
	else
	{
		$sql = 'insert into voturi values (:cont,:idPet,:ippppp)';
		$stmt = oci_parse($conn,$sql);
		oci_bind_by_name($stmt,':ippppp',$ip);
		oci_bind_by_name($stmt,':cont',$_REQUEST['cont']);
		oci_bind_by_name($stmt,':idpet',$_REQUEST['idPet']);

		oci_execute($stmt);
		echo 'votul a fost inregistrat';
	}

	oci_close($conn);

}
?>

<meta http-equiv="refresh" content="3; url=/" />