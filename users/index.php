<?php
require_once "users.php";
/*Define New Member*/
$userss = new Users();
$apis   = new Connection();
$api = $_GET["api"];
/*Use Server Request Method*/
$request_method=$_SERVER["REQUEST_METHOD"];
if(!empty($api)){
   $respons = $apis->api_code($api);
   if($respons=='200'){
       $d = json_decode(file_get_contents('php://input'), true);
         switch ($request_method) {
               case 'GET':
                     if(!empty($_GET["id"])){
                        $id=$_GET["id"];
                        $userss->get_users($id);

                     }else{ 
                        $userss->getAllusers();
                     }
                     break;

               case 'POST':
                     if((!empty($_GET["id"])) && (empty($_FILES["picture"])) ){
                        $id=$_GET["id"];
                        $userss->update_users($id);
                        
                     }else if((!empty($_GET["id"])) && (!empty($_FILES["picture"]))){
                        $id=$_GET["id"];
                        $userss->update_photo($id);
                       
                     }else{
                        $userss->insert_users();
                     }     
                     break; 
                     
               case 'DELETE':
                        $id=$_GET["id"];
                        $userss->delete_users($id);
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