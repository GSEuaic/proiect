<?php 
if(isset($_REQUEST['loginUser']) and isset($_REQUEST['loginPass']) )
{
	$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}
	$sql = 'select idcont from conturi where username=:usern and pass=:passww';
	$stid = oci_parse($conn, $sql);
	oci_bind_by_name($stid, ':usern', $_REQUEST['loginUser']);
	$pass = md5($_REQUEST['loginPass']);
	oci_bind_by_name($stid, ':passww', $pass);
	oci_execute($stid);
	oci_fetch_row($stid);
	$cate = oci_result($stid, 1);
	if($cate==1)
	{
		echo 'autentificare reusita';
		setcookie('logged', 'yes', time() + (86400 * 30), "/"); // 86400 = 1 day
	}
} 

?>	
<meta http-equiv="refresh" content="5; url=localhost" />