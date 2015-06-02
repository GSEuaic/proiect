<div class="camp login" id="LOGIN">
	<nav class="Meniu">
		<form action="cautaPetitie.php">
			<input id="campLogin" type="text" class="campMic"  name="cauta">
			<input type="submit" value="Cauta petitie"/>
			<!--a href="/generareRaport.php"> Generare raport</a-->
			<?php 
							include 'functions.php';
			if(isset($_COOKIE['logged']))
			{
				echo '<a class="buton" href="/petitiileMele.php?petitiileMele='.$_COOKIE['logged'].'">Petitiile mele</a>';
				echo '<a class="buton" href="/logout.php">Log out</a>';

				if(isAdmin($_COOKIE['logged'])==0)
					echo '<a class="buton" href="/raport.php">Raport</a>';
			}
			else 
			{
				echo '<a class="buton" href="/login.php">Log in </a>';
				echo '<a class="buton" href="/signUp.php">Sign up </a>';
			}
			?>
		</form>
	</nav>
</div>