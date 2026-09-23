<?php
  error_reporting(0);
  date_default_timezone_set("Asia/Jakarta");
  include "../config/connect.php";

  class Level extends Connection{
    public $tgl;
    
    //Construct
    public function __construct(){
          $this->conn = $this->get_connection();
    }
    
    /*Code Generator*/
    public function level_code(){
          $num       = '';
          $perfix    = 'LVC';
          $sql       = "SELECT MAX(id) AS kode FROM levels";
          $run       = $this->conn->query($sql);
          $data      = $run->fetch_array();
          $row       = $run->fetch_row();
          $num       = $data["kode"];
          $number    = (int)substr($num, 3, 9);
                       $number++;
          if($row > 0){
            return 'kode telah digunakan';
          }else{
            $val = $perfix.sprintf("%09s", $number);
          }
          
          return $val;
    }

    /*Get All*/
    public function getAlllevel(){
    	$data=array();
    	 $sql    = "SELECT *
                  FROM
                    levels ORDER BY name ASC";
        $exe  = $this->conn->query($sql);
        $row  = $exe->num_rows;
        if($row>0){
            if($exe){
                while($row= $exe->fetch_object())
        	      {
        	         $data[]=$row;
        	      }
        	      $response=array(
        	                     'status' => 200,
        	                     'message' =>'List Of Level',
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
                             'message' =>'Level Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }

    /*Get*/
    public function get_level($id){
       $data =array();
       $sql    = "SELECT
                    *
                  FROM
                    levels
                  WHERE id='$id'";

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
                               'message' =>'Get Level Successfully',
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
                             'message' =>'Level Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }


    /*Update*/
    public function update_level($id,$name, $color,$final_exam_grammer,$final_exam_quran){
        $id    = $this->real_escape($id);
        $name  = $this->real_escape($name);
        $color = $this->real_escape($color);
        $final_exam_grammer  = $this->real_escape($final_exam_grammer);
        $final_exam_quran    = $this->real_escape($final_exam_quran);
        $date                = date('yyyy-mm-dd H:i:s');
        $sql    = "UPDATE levels SET  
                    name              = '$name',
                    backgroundColor   = '$color',
                    final_exam_grammer= '$final_exam_grammer',
                    final_exam_quran  = '$final_exam_quran'
                  WHERE id  = '$id'";
        $exe    = $this->conn->query($sql);
        if($exe){
          $response=array(
                           'status' => 200,
                           'message' =>'Level Updated Successfully',
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


    /*Insert*/
    public function insert_level($name, $color,$final_exam_grammer,$final_exam_quran){
        $id     = $this->level_code();
        $name   = $this->real_escape($name);
        $color  = $this->real_escape($color);
        $final_exam_grammer  = $this->real_escape($final_exam_grammer);
        $final_exam_quran    = $this->real_escape($final_exam_quran);
        

          $sql    = "INSERT INTO levels(id, name, backgroundColor, final_exam_grammer, final_exam_quran)
                   VALUES ('$id','$name','$color','$final_exam_grammer','$final_exam_quran')";
          $exe    = $this->conn->query($sql);
          if($exe){
            $response=array(
                             'status' => 201,
                             'message' =>'Users Added Successfully',
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

    /*Delete*/
    public function delete_level($id){
        $id    = $this->real_escape($id);
        $sql   = "DELETE FROM levels WHERE id='$id'";
        $exe   = $this->conn->query($sql);
        if($exe){
           $response=array(
                             'status' => 200,
                             'message' =>'Users Removed Successfully',
                          );
        }else{
           $response=array(
                             'status' => 500,
                             'message' =>'Filed To Remove Level!',
                          );
        }
        /*For respon json*/
          header('Content-Type: application/json');
          echo json_encode($response);
    }

}
?>