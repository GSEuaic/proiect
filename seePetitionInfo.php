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
<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '570841466390341',
      xfbml      : true,
      version    : 'v2.3'
    });
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
</script>
	<?php include 'bodyPetitie.php' ?>
</body>
</html>