<?php
require_once "soal.php";
/*Define New Member*/
$soals = new Questions();
$apis  = new Connection();
$api = $_GET["api"];
/*Use Server Request Method*/
$request_method=$_SERVER["REQUEST_METHOD"];
if(!empty($api)){
   $respons = $apis->api_code($api);
   if($respons=='200'){
            switch ($request_method) {
               case 'GET':
                     if(!empty($_GET["id"])){
                        $id=$_GET["id"];
                        $soals->get_soal($id);

                     }else{ 
                        $soals->getAllsoal();
                     }
                     break;

               case 'POST':
                     if(!empty($_GET["id"])  && empty($_GET["up"])){
                        $id=$_GET["id"];
                        $soals->update_soal($id);
                    
                    //  }else if(!empty($_GET["id"]) && !empty($_GET["up"])){
                    //           $id=$_GET["id"];
                    //           $soals->update_soal_en($id);
                               
                     }else{
                        
                        $soals->insert_soal();
                     }     
                     break; 
                     
               case 'DELETE':
                        $id=$_GET["id"];
                        $soals->delete_soal($id);
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