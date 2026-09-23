<?php
  error_reporting(0);
  date_default_timezone_set("Asia/Jakarta");
  include "../config/connect.php";

  class Splash extends Connection{
    public $tgl;
    
    //Construct
    public function __construct(){
          $this->conn = $this->get_connection();
    }
    

    /*Get All*/
    public function getStatusApp($api){
        $api = $this->real_escape($api);
        
    	$data=array();
    	 $sql    = "SELECT statusApp
                  FROM
                    api WHERE apiKey='$api'";
        $exe  = $this->conn->query($sql);
        $row  = $exe->num_rows;
        if($row>0){
            if($exe){
                  $dt = $exe->fetch_array();
        	      
        	      $data = $dt['statusApp'];
        	      
        	      $response=array(
        	                     'status' => 200,
        	                     'message' =>'status app',
        	                     'value' => $data
        	                  );
            }else{
                $response=array(
                               'status' => 500,
                               'message' =>'Internal Server Error',
                               'value' => ''
                            );
            }

        }else{
            $response=array(
                             'status' => 404,
                             'message' =>'Not Found!',
                             'value' => ''
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }


}
?>