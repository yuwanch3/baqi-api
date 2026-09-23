<?php
require_once "splash.php";
/*Define New Member*/
$ss = new Splash();
$apis   = new Connection();
$api = $_GET["api"];
/*Use Server Request Method*/
$request_method=$_SERVER["REQUEST_METHOD"];
if(!empty($api)){
   $respons = $apis->api_code($api);
   if($respons=='200'){
      $d      = json_decode(file_get_contents('php://input'), true);
      $apikey           = @$d['api'];

            switch ($request_method) {
               case 'GET' :
                   if(!empty($_GET["api"])){
                       $apis = $_GET["api"];
                       $ss->getStatusApp($apis);
                   }
                   break; 
               case 'POST':
                     if(!empty($_GET["api"])){
                        $apis = $_GET["api"];
                        $ss->getStatusApp($apis);
                        
                     }else{
                        $response=array(
                            'status'=> 405,
                            'message'=> 'Access Denied!'
                            );
                            
                        echo json_encode($response);
                     }     
                     break; 
                     
               case 'DELETE':
                        $id=$_GET["id"];
                        $sub->delete_sublevels($id);
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