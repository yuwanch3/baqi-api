<?php
  error_reporting(0);
  date_default_timezone_set("Asia/Jakarta");
  include "../config/connect.php";

  class Fgpass extends Connection{
    public $tgl;
    
    //Construct
    public function __construct(){
          $this->conn = $this->get_connection();
    }
    
    
    /*Get*/
    public function get_users($username){
       $data       = array();
       $username   = $this->real_escape($username);
       $sql    = "SELECT
                    id, name, email, phone, username, created, updated
                  FROM
                    users
                  WHERE username='$username'";

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
                               'message' =>'Get Member Successfully',
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
                             'message' =>'Member Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }

    /*Update*/
    public function update_pass($id,$pass){
        $id  = $this->real_escape($id);
        $pass = $this->real_escape($pass);
        
        $mb_date= date('Y-m-d H:i:s');
        $sql    = "UPDATE users SET 
                    password = '$pass',
                    updated  = '$mb_date'
                  WHERE id   = '$id'";
        $exe    = $this->conn->query($sql);
        if($exe){
          $response=array(
                           'status' => 200,
                           'message' =>'Password Updated Successfully',
                        );
        }else{
          $response=array(
                           'status' => 500,
                           'message' =>'Internal Server Error',
                        );
        }

        /*For respon json*/
        header('Content-Type: application/json');
        echo json_encode($response);
    }


}
?>