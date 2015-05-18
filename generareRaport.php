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
		<form acrion="generareRaport.php">
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
		include "raportHTML.php" 
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