<?php
require_once ('conf.php');
session_start();

//continue here!!!!!!!!!!!
if(isset($_REQUEST["raamatunimi"]) && !empty($_REQUEST["raamatunimi"])){
    global $yhendus;
    $kask = $yhendus->prepare("INSERT INTO raamatukogu (nimi, autor, laenu_pikkus) VALUES(?, ?, ?)");
    $kask->bind_param("sss", $_REQUEST["raamatunimi"], $_REQUEST["autorinimi"], $_REQUEST["laenupikkus"]);
    $kask->execute();
    header("Location: $_SERVER[PHP_SELF]");
    $yhendus->close();
    //exit();
}
if(isset($_REQUEST["unrentimine"])){
    global $yhendus;
    $kask=$yhendus->prepare("UPDATE raamatukogu SET laenutus_kuup='puudub', saadavus='on' WHERE id=?");
    $kask->bind_param("i", $_REQUEST["unrentimine"]);
    $kask->execute();
}

session_start();
if (isset($_SESSION['username']) && isset($_SESSION['userid']))
    header("Location: ./haldusLeht.php");  // redirect the user to the home page
if (isset($_POST['registerBtn'])){
    // get all of the form data
    $username = $_POST['username'];
    $passwd = $_POST['passwd'];
    $passwd_again = $_POST['passwd_again'];


    // query the database to see if the username is taken
    global $yhendus;
    $kask= $yhendus->prepare("SELECT * FROM kasutajad WHERE kasutaja=?");
    $kask->bind_param("s",$username);
    $kask->execute();
    //$query = mysqli_query($yhendus, "SELECT * FROM kasutajad WHERE nimi='$username'");
    if (!$kask->fetch()){

        // create and format some variables for the database
        $id = '';
        $sool='taiestisuvalinetekst';
        $krypt=crypt($passwd, $sool);
        $passwd_hashed = $krypt;
        $date_created = time();
        $last_login = 0;
        $status = 1;



        // verify all the required form data was entered
        if ($username != "" && $passwd != "" && $passwd_again != ""){
            // make sure the two passwords match
            if ($passwd === $passwd_again){
                // make sure the password meets the min strength requirements
                if ( strlen($passwd) >= 5 && strpbrk($passwd, "!#$.,:;()")){
                    // insert the user into the database
                    mysqli_query($yhendus, "INSERT INTO kasutajad (kasutaja, parool) VALUES ('$username', '$passwd_hashed')");
                    //echo "<script>alert('rrrr')</script>";
// verify the user's account was created
                    $query = mysqli_query($yhendus, "SELECT * FROM kasutajad WHERE kasutaja='{$username}'");
                    if (mysqli_num_rows($query) == 1){

                        /* IF WE ARE HERE THEN THE ACCOUNT WAS CREATED! YAY! */
                        /* WE WILL SEND EMAIL ACTIVATION CODE HERE LATER */
//echo "<script>alert('yay')</script>";
                        $success = true;
                    }
                }
                else
                    $error_msg = 'Teie parool ei ole piisavalt tugev. Palun kasutage teist.';
            }
            else
                $error_msg = 'Teie paroolid ei sobinud.';
        }
        else
            $error_msg = 'Palun täitke kõik nõutavad väljad.';
    }
    else
        $error_msg = 'Kasutajanimi <i>'.$username.'</i> on juba hõivatud. Palun kasutage teist.';
}

else
    $error_msg = '';



//kontrollime kas väljad  login vormis on täidetud
if (!empty($_POST['login']) && !empty($_POST['pass'])) {
    //eemaldame kasutaja sisestusest kahtlase pahna
    $login = htmlspecialchars(trim($_POST['login']));
    $pass = htmlspecialchars(trim($_POST['pass']));
    //SIIA UUS KONTROLL
    $sool = 'taiestisuvalinetekst';
    $kryp = crypt($pass, $sool);
    //kontrollime kas andmebaasis on selline kasutaja ja parool
    $kask=$yhendus-> prepare("SELECT kasutaja, onAdmin FROM kasutajad WHERE kasutaja=? AND parool=?");
    $kask->bind_param("ss", $login, $kryp);
    $kask->bind_result($kasutaja, $onAdmin);
    $kask->execute();
    //kui on, siis loome sessiooni ja suuname
    if ($kask->fetch()) {
        $_SESSION['tuvastamine'] = 'misiganes';
        $_SESSION['kasutaja'] = $login;
        $_SESSION['onAdmin'] = $onAdmin;
        if($onAdmin==1) {
            header('Location: adminLeht.php');

            $yhendus->close();
            exit();
        }
        else {
            header('Location: haldusLeht.php');

            $yhendus->close();
            exit();
        }
    } else {
        echo "kasutaja $login või parool $kryp on vale";
        $yhendus->close();
    }
}



function isAdmin(){
    return  isset($_SESSION['onAdmin']) && $_SESSION['onAdmin'];
}

if(isset($_REQUEST["kustuta"])) {
    global $yhendus;
    $kask = $yhendus->prepare("DELETE FROM tantsud WHERE id=?");
    $kask->bind_param("i", $_REQUEST["kustuta"]);
    $kask->execute();
}

?>
<!doctype html>
<html lang="et">
<head>
<link rel="stylesheet" type="text/css" href="style.css">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Tantsud tähtedega</title>
</head>
<body>
<header>
    <h1>Raamatukogu</h1>
    <?php
    if(isset($_SESSION['kasutaja'])){
        ?>
        <h1>Tere, <?="$_SESSION[kasutaja]"?></h1>
        <nav>
        <ul>
        <li>
        <a href="logout.php"><button id="LogOutButton" class="button-35">Logi välja</button></a>
        </li>
    

        <li>
             <a href="rentimiseLeht.php" ><button id="haldusbtn" class="button-35">Rentimise Leht</button></a>
        </li>
        <li>
             <a href="kuupLeht.php" ><button id="haldusbtn2" class="button-35">Rentimise Kuup Leht</button></a>
        </li>
        <?php if(isAdmin()){ ?>
            <li>
                <a href="haldusLeht.php"><button id="adminbtn" class="button-35">Administreerimise leht</button></a>
            </li>
            </ul>
    </nav>
        <?php } ?>
    

        <?php
    } else {
        ?>
        <nav>
        <ul>
        <li>
        <button id="myBtn" class="button-35">  Logi sisse</button>
        </li>
        <li>
        <button id="myBtn2" class="button-35">Register</button>
        </li>
        </ul>
        </nav>
        <?php
    }
    ?>
    
</header>
<div class="">
        <?php
        // check to see if the user successfully created an account
        if (isset($success) && $success){
            echo '<p color="green">Jaa!!! Teie konto '. $username.' on loodud.<p>';
        }
        else if (isset($error_msg))
            echo '<p color="red">'.$error_msg.'</p>';

        ?>
    </div>
<style>

  
  tbody tr        { height:48px; border-bottom:1px solid #E3F1D5 ;
    &:last-child  { border:0; }
  }
  
 	td,th 					{ text-align:left;
		&.l 					{ text-align:right }
		&.c 					{ text-align:center }
		&.r 					{ text-align:center }
	}
}
@-webkit-keyframes animatetop {
  from {top:-300px; opacity:0} 
  to {top:0; opacity:1}
}

@keyframes animatetop {
  from {top:-300px; opacity:0}
  to {top:0; opacity:1}
}
</style>
</head>
<body>



<!-- Trigger/Open The Modal -->


<!-- The Modal -->
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <span class="close">&times;</span>
      <h1>Login</h1>
    </div>
    <div class="modal-body">
      
<form action="" method="post">
    Login: <input type="text" name="login"><br>
    Password: <input type="password" name="pass"><br>
    <input type="submit" value="Logi sisse">
    
</form>
      
    </div>
    <div class="modal-footer">
      <h3>USERNAME: admin/kasutaja</h3>
      <h3>PASSWORD: admin/kasutaja</h3>
    </div>
  </div>

</div>

<!-- The Modal -->
<div id="myModal2" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <span class="close2">&times;</span>
      <h1>Registreeri uus kasutaja</h1>
    </div>
    <div class="modal-body">
      
<form action="./haldusLeht.php" class="form" method="POST">

    

    <div class="">
        <?php
        // check to see if the user successfully created an account
        if (isset($success) && $success){
            echo '<p color="green">Yay!! Your account has been created.<p>';
        }
        // check to see if the error message is set, if so display it
        else if (isset($error_msg))
            echo '<p color="red">'.$error_msg.'</p>';

        ?>
    </div>

    <div class="">
        <input type="text" name="username" value="" placeholder="enter a username" autocomplete="off" required />
    </div>
    <div class="">
        <input type="password" name="passwd" value="" placeholder="enter a password" autocomplete="off" required />
    </div>
    <div class="">
        <p>password peab olema vähemalt 5 tähemärki ja<br /> sisaldama erimärki, nt !#$.,:;()</font></p>
    </div>
    <!--<div class="">
        <input type="password" name="passwd_again" value="" placeholder="confirm your password" autocomplete="off" required />
    </div>-->

    <div class="">
        <input class="" type="submit" name="registerBtn" value="create account" />
    </div>

    
</form>
    
</form>
      
    </div>
    <div class="modal-footer">
      
    </div>
  </div>

</div>

<script>
// Get the modal
var modal = document.getElementById("myModal");

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

var modal2 = document.getElementById("myModal2");

// Get the button that opens the modal
var btn2 = document.getElementById("myBtn2");

// Get the <span> element that closes the modal
var span2 = document.getElementsByClassName("close2")[0];
// When the user clicks the button, open the modal 
btn.onclick = function() {
  modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}

btn2.onclick = function() {
  modal2.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span2.onclick = function() {
  modal2.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal2) {
    modal2.style.display = "none";
  }
}
</script>





<?php
if (isset($_SESSION["kasutaja"])) {
?>
<table>
    <tr>
        <th>Raamatu nimi</th>
        <th>Autori nimi</th>
        <th>Laenu pikkus</th>
    </tr>
<?php
// ! + knopka tab - näitab html koodi algus
    global $yhendus;
    $kask=$yhendus->prepare("SELECT id, nimi, autor, laenu_pikkus FROM raamatukogu WHERE saadavus='mitte'");
    $kask->bind_result($id, $nimi, $autor, $laenupikkus);
    $kask->execute();
    date_default_timezone_set('Estonia/Tallinn');
    $date = date('m/d/Y h:i:s a', time());
    $now = strtotime($date);
    
    while($kask->fetch()){
        $laenu = strtotime($laenupikkus);
    $timeleft = $laenu-$now;
    $daysleft = round((($timeleft/24)/60)/60); 
        echo "<tr>";
        $nimi=htmlspecialchars($nimi);
        if($daysleft>=7) {
            echo '<td style="color: green;">'.$nimi.'</td>';
            
        } else if($daysleft<=6 && $daysleft>=1){
            echo '<td style="color: orange;">'.$nimi.'</td>';
        } else {
            echo '<td style="color: red;">'.$nimi.'</td>';
        }
        if($daysleft>=7) {
            echo '<td style="color: green;">'.$autor.'</td>';
            
        } else if($daysleft<=6 && $daysleft>=1){
            echo '<td style="color: orange;">'.$autor.'</td>';
        } else {
            echo '<td style="color: red;">'.$autor.'</td>';
        }
        if($daysleft>=7) {
            echo '<td style="color: green;">'.$laenupikkus.'</td>';
            
        } else if($daysleft<=6 && $daysleft>=1){
            echo '<td style="color: orange;">'.$laenupikkus.'</td>';
        } else {
            echo '<td style="color: red;">'.$laenupikkus.'</td>';
            
        }
        //echo "<td>".$daysleft."</td>";
        if(isAdmin()){
                echo "<td><a href='?unrentimine=$id'><button class='button-35'>Võtke rendist</button></a></td>"; 
            }
        
        
        
            echo "</tr>";
    }

?>
</table>
    <?php
    //if(isAdmin()) { ?>

    
    <?php }  //}  ?>

</body>
</html>
