<?php
  error_reporting(0);
  date_default_timezone_set("Asia/Jakarta");
  include "../config/connect.php";

  class Sublevels extends Connection{
    public $tgl;
    
    //Construct
    public function __construct(){
          $this->conn = $this->get_connection();
    }
    
    /*Code Generator*/
    public function sublevels_code(){
          $num       = '';
          $perfix    = 'SLV';
          $sql       = "SELECT MAX(id) AS kode FROM sub_levels";
          $run       = $this->conn->query($sql);
          $data      = $run->fetch_array();
          $row       = $run->fetch_row();
          $num       = $data["kode"];
          $number    = (int)substr($num, 3, 12);
                       $number++;
          if($row > 0){
            return 'kode telah digunakan';
          }else{
            $val = $perfix.sprintf("%012s", $number);
          }
          
          return $val;
    }

    /*Get All*/
    public function getAllsub(){
    	$data=array();
    	 $sql    = "SELECT *
                  FROM
                    sub_levels ORDER BY name ASC";
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
        	                     'message' =>'List Of Sublevels',
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
                             'message' =>'Sublevels Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }

    /*Get one*/
    public function get_sublevels($var){
       
       $data =array();
       $sql    = "SELECT
                    *
                  FROM
                    sub_levels
                  WHERE level='$var'";

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
                               'message' =>'Get Sublevels Successfully',
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
                             'message' =>'Sublevels Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }

    //---------------------------------------------
    /*Update*/
    public function update_sublevels($id,$name,$level,$ujian_grammer,$ujian_pelajaran,$backgroundColor){
        $id      = $this->real_escape($id);
        $name    = $this->real_escape($name);
        $level   = $this->real_escape($level);
        $ujian_grammer   = $this->real_escape($ujian_grammer);
        $ujian_pelajaran = $this->real_escape($ujian_pelajaran);
        $backgroundColor = $this->real_escape($backgroundColor);
        $date   = date('Y-m-d H:i:s');
        $sql    = "UPDATE sub_levels SET 
                    name = '$name',
                    level= '$level',
                    ujian_grammer= '$ujian_grammer',
                    ujian_pelajaran= '$ujian_pelajaran',
                    backgroundColor = '$backgroundColor',
                    updated = '$date'
                  WHERE id  = '$id'";
        $exe    = $this->conn->query($sql);
        if($exe){
          $response=array(
                           'status' => 200,
                           'message' =>'Sublevels Updated Successfully',
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
    public function insert_sublevels($name,$level,$ujian_grammer,$ujian_pelajaran,$backgroundColor){
        $id  = $this->sublevels_code();
        $name    = $this->real_escape($name);
        $level   = $this->real_escape($level);
        $ujian_grammer   = $this->real_escape($ujian_grammer);
        $ujian_pelajaran = $this->real_escape($ujian_pelajaran);
        $backgroundColor = $this->real_escape($backgroundColor);
        

          $sql    = "INSERT INTO sub_levels(id, name, level, ujian_grammer, ujian_pelajaran, backgroundColor, updated)
                   VALUES ('$id','$name','$level','$ujian_grammer','$ujian_pelajaran','$backgroundColor','')";
          $exe    = $this->conn->query($sql);
          if($exe){
            $response=array(
                             'status' => 201,
                             'message' =>'Sublevels Added Successfully',
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
    public function delete_sublevels($id){
        $id    = $this->real_escape($id);
        $sql   = "DELETE FROM sub_levels WHERE id='$id'";
        $exe   = $this->conn->query($sql);
        if($exe){
           $response=array(
                             'status' => 200,
                             'message' =>'Sublevels Removed Successfully',
                          );
        }else{
           $response=array(
                             'status' => 500,
                             'message' =>'Filed To Remove Sublevels!',
                          );
        }
        /*For respon json*/
          header('Content-Type: application/json');
          echo json_encode($response);
    }

}
?>