<?php
require_once "sublevels.php";
/*Define New Member*/
$sub = new Sublevels();
$apis   = new Connection();
$api = $_GET["api"];
/*Use Server Request Method*/
$request_method=$_SERVER["REQUEST_METHOD"];
if(!empty($api)){
   $respons = $apis->api_code($api);
   if($respons=='200'){
      $d = json_decode(file_get_contents('php://input'), true);
      $name           = @$d['name'];
      $level          = @$d['level'];
      $ujian_grammer  = @$d['ujian_grammer'];
      $ujian_pelajaran= @$d['ujian_pelajaran'];
      $backgroundColor= @$d['backgroundColor'];

            switch ($request_method) {
               case 'GET':
                     if(!empty($_GET["level"])){
                        $var = $_GET["level"];
                        $sub->get_sublevels($var);
                        
                     }else{ 
                        $sub->getAllsub();
                     }
                     break;

               case 'POST':
                     if(!empty($_GET["id"])){
                        $id=$_GET["id"];
                        $sub->update_sublevels($id,$name,$level,$ujian_grammer,$ujian_pelajaran,$backgroundColor);
                        
                     }else{
                        $sub->insert_sublevels($name,$level,$ujian_grammer,$ujian_pelajaran,$backgroundColor);
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