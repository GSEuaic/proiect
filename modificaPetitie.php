<html>
<head>
	<meta http-equiv="refresh" content="2300" >
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title> Pet4Web Main Page</title>
	<link rel="stylesheet" type="text/css" href="style.css">
	<meta name="viewport" content="width=device-width, initial-scale=1" /> 
    <?php include "functions.php"; ?>
</head>
	<?php  include 'loginBar.php'; ?>
<HEADER id="cuPadding">
	<?php include 'header.php'; ?>
</HEADER>
<body>
	<div class="content campGeneral camp">
		<form action="modifica.php" method="post" id="FormId">
            <div class="campGeneral camp">
                <p class="titlu"> Modifica petitia <?php echo getNume($_REQUEST['idPet']); ?></p>
                <p >Numele petitiei : <br />
                <input style="visibility:hidden;"  type="text" name="idulPet"
                  <?php $s=$_REQUEST['idPet']; echo "value= \"".$s."\""; ?> 
                  >
                  <input class="campMic" type="text" name="nume" 
                  <?php $s=getNume($_REQUEST['idPet']); echo "value= \"".$s."\""; ?>
                   size="40"  required/></p>
                <p>Descrierea problemei<br />
                    <textarea class="campMare" type="text" name="descriere"  
                    size="40"  > <?php $s=getDescriere($_REQUEST['idPet']); echo $s; ?></textarea> </p>
                    <p>Categorie:
                        <select class="select" name="categorie" id="categoriePetitie" required>
                        <option value='1' >Mediu inconjurator</option>
                        <option value='2' >TV</option>
                        <option value='3' >etc</option>
                    </select>
                </p>
                <p>Cui adresezi petitia?<br />
                    <textarea class="campMare" type="text" name="destinatar" size="40"cols="40" rows="10"><?php $s=getDestinatar($_REQUEST['idPet']); echo  $s; ?></textarea>
                </p>
                <p><input type="submit" value="Modifica"/></p>
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