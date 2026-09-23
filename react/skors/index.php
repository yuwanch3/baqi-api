<?php
require_once "skors.php";
/*Define New Member*/
$skors = new Skors(); 
$apis  = new Connection();
$api = $_GET["api"];
/*Use Server Request Method*/
$request_method=$_SERVER["REQUEST_METHOD"];
if(!empty($api)){
   $respons = $apis->api_code($api);
   if($respons=='200'){
      $d = json_decode(file_get_contents('php://input'), true);
      $mid = @$d['mid'];
      $uid  = @$d['uid'];
      $skor  = @$d['skor'];
      $wrong  = @$d['wrong'];
      $correct = @$d['correct'];
      $excerpt  = @$d['excerpt'];

         switch ($request_method) {
            case 'GET':
                  if(!empty($_GET["id"]) && empty($_GET['mid']) ){
                     $id=$_GET["id"];
                     $skors->get_skor($id);
                     
                  }else if(!empty($_GET["id"]) && !empty($_GET['mid']) && !empty($_GET['excerpt'])){
                     $id   = $_GET["id"];
                     $miid = $_GET["mid"];
                     $excerpts = $_GET["excerpt"];
                     $skors->get_skor_mid($id, $miid, $excerpts);
                  }else{ 
                     
                     $skors->get_skor_limited();
                  }
                  break;

            case 'POST':
                  if(!empty($_GET["id"])){
                     $id=$_GET["id"];
                     $skors->update_skor($id,$mid,$uid,$skor,$wrong,$correct,$excerpt);
                  }else{
                     $skors->insert_skor($mid,$uid,$skor,$wrong,$correct,$excerpt);
                  }     
                  break; 
                  
            case 'DELETE':
                     $id=$_GET["id"];
                     $skors->delete_skor($id);
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