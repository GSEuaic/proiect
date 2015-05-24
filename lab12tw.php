<?php 
$xml=file_get_contents('http://www.telize.com/geoip');
$infos = json_decode($xml);
$city = $infos->{'city'};
$lat = $infos->{'latitude'};
$lon = $infos->{'longitude'};
$url2 = 'http://api.openweathermap.org/data/2.5/find?lat='.$lat.'&lon='.$lon.'&cnt=10';
$xml=file_get_contents($url2);
$infos = json_decode($xml,true);
//echo $xml;
echo '<br>weather in '.$city.' is ';//.$infos->{'weather'};

echo $infos['list']['weather']['main'];
//foreach ($infos['list'] as $i)
  //  echo $i['id'];	
 ?>