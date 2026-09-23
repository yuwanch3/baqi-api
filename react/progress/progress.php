<?php
  error_reporting(0);
  date_default_timezone_set("Asia/Jakarta");
  include "../config/connect.php";

  class Progress extends Connection{
    public $tgl;
    
    //Construct
    public function __construct(){
          $this->conn = $this->get_connection();
    }
    

    public function array_get($id, $array){
      foreach ($array as $key => $val) {
        if($val['uid']==$id){
          return $key;
        }
      }
      return null;
    }

    /*Get All*/
    public function getAlldata($uid){
    	  $data=array();
        $totalAll = 0;
        $total_lid  = 0; $total_sid  = 0; $total_mid  = 0;
    	  $sql    = "SELECT count(id) AS lid FROM levels WHERE state_exam = 'yes'";
        $exe    = $this->conn->query($sql);

        $sqlo    = "SELECT count(id) AS sid FROM sub_levels WHERE state_exam = 'yes'";
        $exeo    = $this->conn->query($sqlo);

        $sqlt    = "SELECT count(id) AS mid FROM materi WHERE state_exam = 'yes'";
        $exet    = $this->conn->query($sqlt);

        //$row     = $exe->num_rows;

       
            if( $exe ){
                $row_lid = $exe->fetch_array();
                $total_lid   = $row_lid['lid'];
            }else{
                $response=array(
                               'status' => 500,
                               'message' =>'Internal Server Error',
                               'value' => 'null'
                            );
            }

            if( $exeo ){
                $row_sid     = $exeo->fetch_array();  
                $total_sid   =  $row_sid['sid'];
            }else{
                $response=array(
                               'status' => 500,
                               'message' =>'Internal Server Error',
                               'value' => 'null'
                            );
            }

            if( $exet ){
                $row_mid = $exet->fetch_array();
                $total_mid   = $row_mid['mid'];

            }else{
                $response=array(
                               'status' => 500,
                               'message' =>'Internal Server Error',
                               'value' => 'null'
                            );
            }

            $totalAll = $total_lid + $total_sid + $total_mid;


       $uid     = $this->real_escape($uid);
       $datacur = 0;
       $sqlc    = "SELECT count(uid) as numbers FROM skors WHERE uid = '$uid'";
       $exec    = $this->conn->query($sqlc);
       $row     = $exec->num_rows;

        
            if($exec){
                $datas    = $exec->fetch_array();
                $datacur  = $datas['numbers']+0;
                
                $response=array(
                               'status'  => 200,
                               'message' =>'Get Data Successfully',
                               'value'   => array(
                                              'total'  =>$totalAll,
                                              'done'   =>$datacur
                                            )
                            );
            }else{
                $response=array(
                               'status' => 500,
                               'message' =>'Internal Server Error',
                               'value' => 'null'
                            );
            }
        
        header('Content-Type: application/json');
        echo json_encode($response);
   
    }

    /*Get */
    public function get_current_user_progress($uid){
       $uid  = $this->real_escape($_POST['uid']);
       $data = '';
       $sql    = "SELECT count(uid) as numbers FROM skors WHERE uid = 'uid'";
       $exe  = $this->conn->query($sql);
       $row  = $exe->num_rows;

        if($row>0){
            if($exe){
                while($datas = $exe->fetch_array())
                {
                   $data = $datas['numbers'];
                }
                $response=array(
                               'status'  => 200,
                               'message' =>'Get Data Successfully',
                               'value'   => $data
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
                             'message' =>'Data Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }

}
?>