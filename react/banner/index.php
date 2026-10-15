<?php
date_default_timezone_set("Asia/Jakarta");
include "../config/connect.php";
  
$apis  = new Connection();
$api = $_GET["api"];

/*Use Server Request Method*/
$request_method=$_SERVER["REQUEST_METHOD"];

if(!empty($api)){
   $respons = $apis->api_code($api);
   if($respons=='200'){
                $data = array();
                $localIP        = $_SERVER['HTTP_HOST'];
            
                if ($handle = opendir('../assets/banner/')) {
            
                    while (false !== ($entry = readdir($handle))) {
            
                        if ($entry != "." && $entry != "..") {
                            array_push($data, array(
                              "image"=> 'https://'.$localIP.'/react/assets/banner/'.$entry
                            ));
                        }
                    }
            
                    closedir($handle);
                }
            
                $response = array(
                    'status'=> 200,
                    'message'=>'success',
                    'baner'=> $data
                );
                header('Content-Type: application/json');
                echo json_encode($response);
    
       }else{
          //not allowed
          //Invalid Request Method
          header("HTTP/1.0 405 Method Not Allowed");
          echo $apis->not_allowed();
       }
    }else{
       echo $apis->corecction();
    } 
    
 ?>
