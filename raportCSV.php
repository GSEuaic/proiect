<?php 
$conn = oci_connect("george", "george", "localhost/XE");
if (!$conn) {
   $m = oci_error();
   trigger_error(htmlentities($m['message']), E_USER_ERROR);
}


$stid = oci_parse($conn, 'begin csv_util.makecsv; end;');
oci_execute($stid);

$zip = new ZipArchive();
$filename = "./raport.zip";

if ($zip->open($filename, ZipArchive::CREATE)!==TRUE) {
    exit("cannot open <$filename>\n");
}
else{
$zip->deleteName('A_CATEGORII.CSV');
$zip->deleteName('A_COMENTARII.CSV');
$zip->deleteName('A_CONTURI.CSV');
$zip->deleteName('A_PETITII.CSV');

$thisdir='.';

$zip->addFile($thisdir . "/A_CATEGORII.CSV","/A_CATEGORII.CSV");
$zip->addFile($thisdir . "/A_COMENTARII.CSV","/A_COMENTARII.CSV");
$zip->addFile($thisdir . "/A_CONTURI.CSV","/A_CONTURI.CSV");
$zip->addFile($thisdir . "/A_PETITII.CSV","/A_PETITII.CSV");
echo "<p><a href=\"/raport.zip\"> Raport format csv</a></p>";
}

?>