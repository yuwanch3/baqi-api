<?php
require_once "lastest.php";
/*Define New Member*/
$skors = new Last(); 
$apis  = new Connection();
$api = $_GET["api"];
/*Use Server Request Method*/
$request_method=$_SERVER["REQUEST_METHOD"];
if(!empty($api)){
   $respons = $apis->api_code($api);
   if($respons=='200'){
         switch ($request_method) {
            case 'GET':
                  if(!empty($_GET["uid"]) && empty($_GET["mid"]) ){
                     //$mid  = $_GET["mid"];
                     $uid  = $_GET["uid"];
                     $skors->get_last($uid);  ///-------
                     
                  }else if(!empty($_GET["mid"]) && !empty($_GET["uid"]) ){
                       $mid  = $_GET["mid"];
                       $uid  = $_GET["uid"];  $excerpt=$_GET['excerpt'];
                       $skors->get_lastmid($mid, $uid, $excerpt);
                  }else{  
                     $skors->getLastest(); ///-------
                     
                  }
                  break;

            case 'POST':
                  if(!empty($_GET["id"])){
                     $id=$_GET["id"];
                     $skors->update_last($id);  ///-------
                  }else{
                     $skors->insert_last();     ///-------
                  }     
                  break; 
                  
            case 'DELETE':
                     $id=$_GET["id"];
                     $skors->delete_last($id);
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