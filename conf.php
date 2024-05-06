<?php
$kasutaja='oleksandr';
$serverinimi='localhost';
$parool='123';
$andmebaas='bohatyrov';
$yhendus=new mysqli($serverinimi,$kasutaja,$parool,$andmebaas);
$yhendus->set_charset('UTF8');

