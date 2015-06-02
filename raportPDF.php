<?php
include 'mpdf60/mpdf.php';
$mpdf=new mPDF();
$cont = file_get_contents('http://localhost/raportHTML.php' );

$mpdf->WriteHTML($cont);
$mpdf->Output();
ob_clean();
exit;

?>