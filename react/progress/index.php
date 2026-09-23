<?php
require_once "progress.php";
/*Define New Member*/
$data = new Progress(); 
$apis  = new Connection();
$api = $_GET["api"];
/*Use Server Request Method*/
$request_method=$_SERVER["REQUEST_METHOD"];
if(!empty($api)){
   $respons = $apis->api_code($api);
   if($respons=='200'){ 
      $d = json_decode(file_get_contents('php://input'), true);
         switch ($request_method) {
            case 'GET':
                  if( !empty($_GET["uid"]) ){
                     $uid  = $_GET["uid"];
                     $data->getAlldata($uid);  ///-------
                    
                  }
                  break;
                  
            default:
               //Invalid Request Method
               header("HTTP/1.0 405 Method Not Allowed");
               echo $apis->not_allowed();
               break;
            break;
      }
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