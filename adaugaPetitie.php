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
		<form action="adauga.php" method="post">
            <div class="campGeneral camp">
                <p class="titlu"> Adauga o petitie noua</p>
                <p >Numele petitiei<br />
                  <input class="campMic" type="text" name="nume" value="" size="40"  required/></p>
              <p>Nume autor*<br />
                <input class="campMic" type="text" name="email" value=""  /> </p>
                <p>Descrierea petitiei<br />
                    <textarea class="campMare" type="text" name="descriere" value="" cols="40" rows="5" required/></textarea></p>
                    <p>Categorie:
                        <select class="select" name="categorie" id="categoriePetitie" required>  ////insert php to get categories
                        <option value='1' >Mediu inconjurator</option>
                        <option value='2' >TV</option>
                        <option value='3' >etc</option>
                    </select>
                </p>
                <p>Cui adresezi petitia?<br />
                    <textarea class="campMare" type="text" name="destinatar" size="40"cols="40" rows="10"></textarea>
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
<div class="campGeneral ultimeleComentarii">';
<?php include 'ultimeleComentarii.php'; ?>
</div>
</div>
</body>
</html>