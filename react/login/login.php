<?php
  error_reporting(0);
  date_default_timezone_set("Asia/Jakarta");
  include "../config/connect.php";

  class Login extends Connection{
    public $tgl;
    
    //Construct
    public function __construct(){
          $this->conn = $this->get_connection();
    }
    

    public function get_login($username,$password){
       $username  = $this->real_escape($username);
       $password  = $this->real_escape($password);
       $newpass = $password;//SHA1($password);
       $data      = array();
       $sql    = "SELECT
                    id, name, email, phone, username, picture, created, updated
                  FROM
                    users
                  WHERE username='$username' AND password='$newpass'";

        $exe  = $this->conn->query($sql);
        $row  = $exe->num_rows;
        if($row>0){
            if($exe){
                while($datas = $exe->fetch_object())
                {
                   $data[]=$datas;
                }
                $response=array(
                               'status' => 200,
                               'message' =>'Login Successfully',
                               'value' => $data
                            );
            }else{
                $response=array(
                               'status' => 500,
                               'message' =>'Internal Server Error',
                               'value' => 'null'
                            );
            }
        }else{
            $response=array(
                             'status' => 404,
                             'message' =>'Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }
    
    public function get_soslogin($email){
       $email  = $this->real_escape($email);

       $data      = array();
       $sql    = "SELECT
                    id, name, email, phone, username, picture, created, updated
                  FROM
                    users
                  WHERE username = '$email'";

        $exe  = $this->conn->query($sql);
        $row  = $exe->num_rows;
        if($row>0){
            if($exe){
                while($datas = $exe->fetch_object())
                {
                   $data[]=$datas;
                }
                $response=array(
                               'status' => 200,
                               'message' =>'Data found',
                               'value' => $data
                            );
            }else{
                $response=array(
                               'status' => 500,
                               'message' =>'Internal Server Error',
                               'value' => 'null'
                            );
            }
        }else{
            $response=array(
                             'status' => 404,
                             'message' =>'Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }

}
?>