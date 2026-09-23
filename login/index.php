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
           switch ($request_method) {
              case 'POST':
                    if((!empty($_POST["username"])) && (!empty($_POST["password"])) && (empty($_POST["email"])) ){
                       $username =$_POST["username"];
                       $password =$_POST["password"];
                       $log->get_login($username,$password);
                       
                    }else if((!empty($_POST["email"])) && (empty($_POST["username"])) && (empty($_POST["password"]))){
                       $email =$_POST["email"];
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