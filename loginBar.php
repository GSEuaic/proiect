<!--
<div class="camp login" id="LOGIN">
	<nav class="Meniu">
		<!-- 
		<form action="login.php">
			
			<input id="campLogin" type="text" class="campMic" value="User" name="loginUser">
			<input id="campLogin" type="password" class="campMic"  name="loginPass">
			<input type="submit" value="Log In"/>
			<a href="/adaugaPetitie.php">Adauga Petitie</a>
			<a href="/signup.html"> Sign Up</a>
		-->
		<!--form action="cautaPetitie.php">
			<input id="campLogin" type="text" class="campMic"  name="cauta">
			<input type="submit" value="Cauta petitie"/>
			<a class="buton" href="/adaugaPetitie.php">Adauga Petitie</a>
			<!--a href="/generareRaport.php"> Generare raport</a-->
		<!--/form>
	</nav>
</div>
-->


<div class="camp login" id="LOGIN">
	<nav class="Meniu">
		<!-- 
		<form action="login.php">
			
			<input id="campLogin" type="text" class="campMic" value="User" name="loginUser">
			<input id="campLogin" type="password" class="campMic"  name="loginPass">
			<input type="submit" value="Log In"/>
			<a href="/adaugaPetitie.php">Adauga Petitie</a>
			<a href="/signup.html"> Sign Up</a>
		-->
		<form action="cautaPetitie.php">
			<input id="campLogin" type="text" class="campMic"  name="cauta">
			<input type="submit" value="Cauta petitie"/>
			<!--a href="/generareRaport.php"> Generare raport</a-->
			<?php 
			if(isset($_COOKIE['logged']))
			{
				echo '<a class="buton" href="/petitiileMele.php">Petitiile mele</a>';
				echo '<a class="buton" href="/logout.php">Log out</a>';
			}
			else 
			{
				echo '<a class="buton" href="/login.php">Log in </a>';
				echo '<a class="buton" href="/petitiileMele.php">Sign up </a>';
			}
			?>
		</form>
	</nav>
</div>