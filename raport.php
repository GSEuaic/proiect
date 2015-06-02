<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ro" xml:lang="ro">
<head>
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
		<form class="raport" action="raport.php">
			<select class="select" name="mod"  required>  
				<option value='html' >HTML</option>
				<option value='csv' >CSV</option>
				<option value='pdf' >PDF</option>
			</select>
			<p><input type="submit" value="Generare"/></p>
		</form>

		<?php 
		if(isset($_REQUEST['mod']))
			if($_REQUEST['mod']=='html')
				include "raportHTML.php"; 
			elseif($_REQUEST['mod']=='csv')
				include "raportCSV.php";
			elseif($_REQUEST['mod']=='pdf')
				echo '	<a href="http://localhost/raportPDF.php">Raport PDF</a>';	 
			?>
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
