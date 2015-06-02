		<form action="adauga.php" method="post">
            <div class="campGeneral camp">
                <p class="titlu"> Adauga o petitie noua</p>
                <p >Numele petitiei*<br />
                  <input class="campMic" type="text" name="nume" value="" size="40"  required/></p>
                  <p>Descrierea petitiei<br />
                    <textarea class="campMare" type="text" name="descriere" value="" cols="40" rows="5" required/></textarea></p>
                    <p>Categorie:
                        <select class="select" name="categorie" id="categoriePetitie" required>
                          <?php getOptions(); ?>
                      </select>
                  </p>
                  <p>Cui adresezi petitia?<br />
                    <textarea class="campMare" type="text" name="destinatar" size="40"cols="40" rows="10"></textarea>
                </p>
                <p><input type="submit" value="Adauga"/></p>
                <p class="specificatiiExtra">  * Datele personale sunt anonime.</p>


            </div>
        </form>