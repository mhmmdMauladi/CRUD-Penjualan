<?php
$koneksi = mysqli_connect ("localhost","root","","api_penjualan");
$id = $_POST['id'];
$data = mysqli_query($koneksi, "delete from tb_food where id='$id'");
if($data){
    echo json_encode(array('message' => 'deleted!'));
}else{
    echo json_encode(array('message' => 'error!'));
}
?>