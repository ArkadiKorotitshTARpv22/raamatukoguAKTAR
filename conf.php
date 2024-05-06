<?php
$kasutaja='root';
$serverinimi='localhost';
$parool='';
$andmebaas='d123178_akbaas';
$yhendus=new mysqli($serverinimi,$kasutaja,$parool,$andmebaas);
$yhendus->set_charset('UTF8');

