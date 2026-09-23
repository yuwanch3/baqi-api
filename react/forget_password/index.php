<?php
require_once "fgpassw.php";
/*Define New Member*/
$upass  = new Fgpass();
$apis   = new Connection();
/*Use Server Request Method*/
$api = $_GET["api"];
$request_method=$_SERVER["REQUEST_METHOD"];
if(!empty($api)){
   $respons = $apis->api_code($api);
   if($respons=='200'){
      $d = json_decode(file_get_contents('php://input'), true);
      $uname              = @$d['uname'];

         switch ($request_method) {
            case 'POST':
                  if( !empty($d["uname"]) && empty(@$d['password'])){
                     $un  = $d["uname"];
                     $upass->get_users($un);
                    
                  }else
                  if(!empty($_GET["id"]) && !empty(@$d['password'])){
                     $newpass      = @$d['password'];
                     $id=$_GET["id"];
                     $upass->update_pass($id,$newpass);
                  }else{
                     $res = array(
                           'status'  => 400 ,
                           'message' =>'Id not recognized!'
                        );
                     echo json_encode($res);
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