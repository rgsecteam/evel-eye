<?php

$date = date('dMYHis');
$imageData=$_POST['cat'];
$directory = 'images/';

if (!file_exists($directory)) {
    mkdir($directory, 0777, true);
}

if (!empty($_POST['cat'])) {
error_log("Received" . "\r\n", 3, "Logs.log");

}

$filteredData=substr($imageData, strpos($imageData, ",")+1);
$unencodedData=base64_decode($filteredData);
$fp = fopen($directory . 'cam' . $date . '.jpg', 'wb');
fwrite( $fp, $unencodedData);
fclose( $fp );
?>
