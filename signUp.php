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
		<form action="adaugaUser.php" method="post">
            <div class="campGeneral camp">
                <p class="titlu"> Inregistrare utilizator</p>
              <p>Username*<br />
                <input class="campMic" type="text" name="usern" value=""  /> </p>
                <p>Parola<br />
                    <input class="campMic" type="password" name="pass" value=""  />
                </p>
                <p><input type="submit" value="Adauga"/></p>
                <p class="specificatiiExtra">  * Numele si prenumele sunt anonime.</p>
            
            </div>
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