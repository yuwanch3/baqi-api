<?php
require_once "login.php";
/*Define New Member*/
$log = new Login();
$apis  = new Connection();
$api = $_GET["api"];
/*Use Server Request Method*/
$request_method=$_SERVER["REQUEST_METHOD"];
if(!empty($api)){
   $respons = $apis->api_code($api);
   if($respons=='200'){
    $v = json_decode(file_get_contents('php://input'), true);
    
           switch ($request_method) {
              case 'POST':
                    if((!empty($v["username"])) && (!empty($v["password"])) && (empty($v["email"])) ){
                       $username =$v["username"];
                       $password =$v["password"];
                       $log->get_login($username,$password);
                       
                    }else if((!empty($v["email"])) && (empty($v["username"])) && (empty($v["password"]))){
                       $email =$v["email"];
                       $log->get_soslogin($email);
    
                    }else{ 
                       $response=array(
                                       'status' => 405,
                                       'message' =>'Not Allowed'
                                       
                                    );
                       header('Content-Type: application/json');
                       echo json_encode($response);
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