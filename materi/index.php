<?php
require_once "materi.php";
/*Define New Member*/
$materis = new Materi();
$apis  = new Connection();
$api = $_GET["api"];
/*Use Server Request Method*/
$request_method=$_SERVER["REQUEST_METHOD"];
if(!empty($api)){
   $respons = $apis->api_code($api);
   if($respons=='200'){
            switch ($request_method) {
               case 'GET':
                    
                     if( (!empty($_GET["level"])) && (!empty($_GET["sub"])) && (empty($_GET["id"]))){
                        $level = $_GET["level"]; $sub = $_GET["sub"];
                        $materis->get_materi($level, $sub);
                        
                     }else if( !empty($_GET["id"]) && (empty($_GET["level"])) && (empty($_GET["sub"])) ){
                        $id = $_GET["id"];
                        $materis->get_materi_id($id);
                        
                     }else{ 
                        $materis->getAllmateri();
                        
                     }
                     break;

               case 'POST':
                     if(!empty($_GET["id"]) && empty($_GET["type"])){
                        $id=$_GET["id"];
                        $materis->update_materi($id);
                        
                     }else if(!empty($_GET["id"]) && !empty($_GET["type"])){
                         $id =$_GET["id"];
                         $type =$_GET["type"];
                         
                         $materis->update_doc($id,$type);   
                     
                     }else{
                        $materis->insert_materi();
                     }     
                     break; 
                     
               case 'DELETE':
                        $id=$_GET["id"];
                        $materis->delete_materi($id);
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