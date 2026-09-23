<?php
require_once "level.php";
/*Define New Member*/
$levels = new Level();
$apis   = new Connection();
/*Use Server Request Method*/
$api = $_GET["api"];
$request_method=$_SERVER["REQUEST_METHOD"];
if(!empty($api)){
   $respons = $apis->api_code($api);
   if($respons=='200'){
      $d = json_decode(file_get_contents('php://input'), true);
      $name               = @$d['name'];
      $color              = @$d['color'];
      $final_exam_grammer = @$d['final_exam_grammer'];
      $final_exam_quran   = @$d['final_exam_quran'];

         switch ($request_method) {
            case 'GET':
                  if(!empty($_GET["id"])){
                     $id=$_GET["id"];
                     $levels->get_level($id);

                  }else{ 
                     $levels->getAlllevel();
                  }
                  break;

            case 'POST':
                  
                  if(!empty($_GET["id"])){
                     $id=$_GET["id"];
                     $levels->update_level($id,$name, $color,$final_exam_grammer,$final_exam_quran);
                  }else{
                     $levels->insert_level($name, $color,$final_exam_grammer,$final_exam_quran);
                  }     
                  break; 
                  
            case 'DELETE':
                     $id=$_GET["id"];
                     $levels->delete_level($id);
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