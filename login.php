<html>
<head>
	<meta http-equiv="refresh" content="2300" >
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title> Pet4Web Main Page</title>
	<link rel="stylesheet" type="text/css" href="style.css">
	<meta name="viewport" content="width=device-width, initial-scale=1" /> 
</head>
	<?php  include 'loginBar.php'; ?>
<HEADER id="cuPadding">
	<?php include 'header.php'; ?>
</HEADER>
<body>
	<div class="content campGeneral camp">
		<h2>Log in</h2>
		<form class="PaginaLogin"  action="log.php">
		<input  type="text" class="campMic" placeholder="User" name="loginUser">
		<input type="password" class="campMic"  name="loginPass">
		<input type="submit" value="Log In"/>
	</form>
	</div>
<div class="sidebar">

<div class="campGeneral ultimelePetitii">
<?php include 'ultimelepetitii.php';?>
</div>
<div class="campGeneral ultimeleComentarii">
<?php include 'ultimeleComentarii.php'; ?>
</div>
</div>
</body>
</html>