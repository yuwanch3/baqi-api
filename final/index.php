<?php
require_once "final.php";
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
                 
                     
                     if( !empty($_GET["id"]) && !empty($_GET["excerpt"]) ){
                        $id=$_GET["id"]; $excerpt=$_GET["excerpt"];
                        $soals->get_soal($id,$excerpt);

                     }else if(empty($_GET["id"]) && !empty($_GET["excerpt"]) ){
                        $excerpt=$_GET["excerpt"];
                        $soals->getAllsoal($excerpt);
                    
                     }else if(!empty($_GET["id"]) && empty($_GET["excerpt"]) ){
                        $id=$_GET["id"];
                        $soals->getAllsoalid($id);
                    
                     }else{ 
                        echo json_encode(array(
                              'status' =>500,
                              'message'=>'Please make request correctly!'
                           ));
                     }
                     break;

               case 'POST':
              
                     if(!empty($_GET["id"]) && empty($_GET["up"])){
                        $id=$_GET["id"];
                        $soals->update_soal($id);
                        
                    //  }else if(!empty($_GET["id"]) && !empty($_GET["up"])){
                    //       $id=$_GET["id"];
                    //       $soals->update_soal_en($id);
                           
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