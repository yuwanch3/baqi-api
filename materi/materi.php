<?php
  error_reporting(0);
  date_default_timezone_set("Asia/Jakarta");
  include "../config/connect.php";

  class Materi extends Connection{
    public $tgl;
    
    //Construct
    public function __construct(){
          $this->conn = $this->get_connection();
    }
    
    /*Code Generator*/
    public function materi_code(){
          $num       = '';
          $perfix    = 'MTR';
          $sql       = "SELECT MAX(id) AS kode FROM materi";
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
    public function getAllmateri(){
    	$data=array();
    	 $sql    = "SELECT *
                  FROM
                    materi";
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
        	                     'message' =>'List Of Materi',
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
                             'message' =>'Materi Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }

    /*Get by level and sublevel*/
    public function get_materi($level, $sub){
       $level = $this->real_escape($level);
       $sub   = $this->real_escape($sub);
       $data  = array();
       $sql   = "SELECT
                    *
                  FROM
                    materi
                  WHERE level='$level' AND sub_levels='$sub'";

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
                               'message' =>'Get Materi Successfully',
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
                             'message' =>'Materi Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }

    /*Get*/
    public function get_materi_id($id){
       $id   = $this->real_escape($id);
       $data = array();
       $sql    = "SELECT
                    *
                  FROM
                    materi
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
                               'message' =>'Get Materi Successfully',
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
                             'message' =>'Materi Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }

    /*Update*/
    public function update_materi($id){
        $id         = $this->real_escape($id);
        $level      = $this->real_escape($_POST['level']);
        $sub_levels = $this->real_escape($_POST['sub_levels']);
        $doc        = $this->real_escape($_POST['doc']);
        $test       = $this->real_escape($_POST['test']);
        $watch      = $this->real_escape($_POST['watch']);
        $information= $this->real_escape($_POST['information']);
        $description= $this->real_escape($_POST['description']);
        $date       = date('Y-m-d H:i:s');
        $sql    = "UPDATE materi SET 
                    level       ='$level', 
                    sub_levels  ='$sub_levels', 
                    doc         ='$doc', 
                    test        ='$test', 
                    watch       ='$watch', 
                    information ='$information', 
                    description ='$description',
                    updated     ='$date'
                  WHERE id      ='$id'";
        $exe    = $this->conn->query($sql);
        if($exe){
          $response=array(
                           'status' => 201,
                           'message' =>'Materi Updated Successfully',
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
    
    /*Update document*/
    public function update_doc($id,$type){
      $id         = $this->real_escape($id);
      $type       = $this->real_escape($type);
      $url_doc    = $this->real_escape($_POST['url_doc']);
      $date       = date('Y-m-d H:i:s');
      $data       = array();
      
      if($type=='id'){
        $sql = "UPDATE materi SET doc='$url_doc', updated='$date' WHERE id='$id'";

      }else if($type=='en'){
        $sql = "UPDATE materi SET doc_en='$url_doc', updated='$date' WHERE id='$id'";
      }

      $exe    = $this->conn->query($sql);
      //-----------------------------------------------------------
      $sql_select = "SELECT id, doc, doc_en, watch, information, created, updated FROM materi WHERE id='$id'";
      $rundata    = $this->conn->query($sql_select);

      if($exe && $rundata){

        while($datas = $rundata->fetch_object())
        {
           $data[]=$datas;
        }
        $response=array(
                         'status' => 200,
                         'message' =>'Doc Updated Successfully',
                         'date'    => $data
                      );
      }else{
        $response=array(
                         'status' => 500,
                         'message' =>'Internal Server Error',
                      );
      }

      header('Content-Type: application/json');
      echo json_encode($response);

    }

    /*Insert*/
    public function insert_materi(){
        $id         = $this->materi_code();
        $level      = $this->real_escape($_POST['level']);
        $sub_levels = $this->real_escape($_POST['sub_levels']);
        $doc        = $this->real_escape($_POST['doc']);
        $test       = $this->real_escape($_POST['test']);
        $watch      = $this->real_escape($_POST['watch']);
        $information= $this->real_escape($_POST['information']);
        $description= $this->real_escape($_POST['description']);

          $sql    = "INSERT INTO materi(id, level, sub_levels, doc, test, watch, information, description, updated)
                     VALUES ('$id','$level','$sub_levels','$doc','$test','$watch','$information','$description','')";
          $exe    = $this->conn->query($sql);
          if($exe){
            $response=array(
                             'status' => 201,
                             'message' =>'Materi Added Successfully',
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
    public function delete_materi($id){
        $id    = $this->real_escape($id);
        $sql   = "DELETE FROM materi WHERE id='$id'";
        $exe   = $this->conn->query($sql);
        if($exe){
           $response=array(
                             'status' => 200,
                             'message' =>'Materi Removed Successfully',
                          );
        }else{
           $response=array(
                             'status' => 500,
                             'message' =>'Filed To Remove Materi!',
                          );
        }
        /*For respon json*/
          header('Content-Type: application/json');
          echo json_encode($response);
    }

}
?>