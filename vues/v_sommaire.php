    <!-- Division pour le sommaire -->
    <div id="menuGauche">
     <div id="infosUtil">
    
        <h2>
    
</h2>
    
      </div>  
        <ul id="menuList">

            <li>
				 <b> Visiteur : </b><br>
				<?php echo $_SESSION['prenom']."  ".$_SESSION['nom']  ?>
		</li>
                        <br>

            <li>
                        <b>Télephone : </b> <br>
                        <?php echo $_SESSION['telephone']?>

            </li>

                        <br>

            <li>
                        <b> Numéro de la voiture : </b> : <br>
                        <?php echo $_SESSION['numero']?>
            </li>

            <li>  

                        <b>Type de carburant :</b>  <br>
                        <?php echo $_SESSION['type']?>

            </li>

                        <br>
                        <br>

           <li class="smenu">
              <a href="index.php?uc=gererFrais&action=saisirFrais" title="Saisie fiche de frais ">Saisie fiche de frais</a>
           </li>
           
           <li class="smenu">
              <a href="index.php?uc=etatFrais&action=selectionnerMois" title="Consultation de mes fiches de frais">Mes fiches de frais</a>
           </li>
                        
 	   <li class="smenu">
              <a href="index.php?uc=connexion&action=deconnexion" title="Se déconnecter">Déconnexion</a>
           </li>
         </ul>
        
    </div>
    