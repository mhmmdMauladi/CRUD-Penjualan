<?php
$koneksi = mysqli_connect ("localhost","root","","api_penjualan");
$image = $_POST['image'];
$nama = $_POST['nama'];
$price = $_POST['price'];
$cookingtime = $_POST['cookingtime'];
$rate = $_POST['rate'];
$data = mysqli_query($koneksi, "insert into tb_food set image='$image', nama='$nama', price='$price', cookingtime='$cookingtime', rate='$rate'");
if($data){
    echo json_encode(array('message' => 'created!'));
}else{
    echo json_encode(array('message' => 'error!'));
}
?>