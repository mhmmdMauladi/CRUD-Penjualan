<?php
$koneksi = mysqli_connect ("localhost","root","","api_penjualan");

$id = $_POST['id'];
$image = $_POST['image'];
$nama = $_POST['nama'];
$price = $_POST['price'];
$cookingtime = $_POST['cookingtime'];
$rate = $_POST['rate'];

$data = mysqli_query($koneksi, "update tb_food set nama='$nama', image='$image', price='$price', cookingtime='$cookingtime', rate='$rate' where id='$id'");
if($data){
    echo json_encode(array('message' => 'updated!'));
}else{
    echo json_encode(array('message' => 'error!'));
}
?>