<?php
  error_reporting(0);
  date_default_timezone_set("Asia/Jakarta");
  include "../config/connect.php";

  class Skors extends Connection{
    public $tgl;
    
    //Construct
    public function __construct(){
          $this->conn = $this->get_connection();
    }
    
    /*Code Generator*/
    public function skor_code(){
          $num       = '';
          $perfix    = 'SCR';
          $sql       = "SELECT MAX(id) AS kode FROM skors";
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

    public function array_get($id, $array){
      foreach ($array as $key => $val) {
        if($val['uid']==$id){
          return $key;
        }
      }
      return null;
    }

    /*Get All*/
    public function getAllskor(){
    	$data=array();
    	 $sql    = "SELECT *
                  FROM
                    skors ORDER BY skor ASC";
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
        	                     'message' =>'List Of Skors',
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
                             'message' =>'Skors Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }

    /*Get curent user*/
    public function get_skor($id){
       $data =array();
       $sql    =  "SET @pos=0";
       $this->conn->query($sql);

       $sqli   =  "SELECT (@pos:=@pos+1) rank, A.uid, A.total, A.name, A.picture FROM
                  (SELECT S.uid, SUM(S.skor) total, U.name, U.picture FROM skors S INNER JOIN
                  users U ON S.uid = U.id GROUP BY S.uid ) A ORDER BY A.total DESC";

        $exe  = $this->conn->query($sqli);
        $row  = $exe->num_rows;
        if($row>0){
            if($exe){
                while($datas = $exe->fetch_array())
                {
                   array_push($data, array(
                      "rank" =>$datas['rank'],
                      "uid"  =>$datas['uid'],
                      "name" =>$datas['name'],
                      "total"=>$datas['total']
                    ));
                }

                $dataa = json_encode($data);
                $ds    = json_decode($dataa, true);
                
                $find = $this->array_get($id, $ds);

                 

                $response=array(
                               'status' => 200,
                               'message' =>'Get Skors Successfully',
                               'value' => $data[$find]
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
                             'message' =>'Skors Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
   }


    /*Get */
    public function get_skor_limited(){
       $data =array();
       $sql    = "SELECT SUM(S.skor) as skor, S.uid, U.name, U.picture FROM skors S INNER JOIN
                    users U ON S.uid = U.id GROUP BY S.uid ORDER BY S.skor ASC";

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
                               'message' =>'Get All Skors Successfully',
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
                             'message' =>'Skors Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }
    
    
    public function get_skor_mid($id,$mid,$excerpt){
       $mid     = $this->real_escape($mid);
       $id      = $this->real_escape($id);
       $excerpt = $this->real_escape($excerpt);
       $data =array();
       $sql    = "SELECT * FROM skors WHERE mid ='$mid' AND uid='$id' AND excerpt='$excerpt'";

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
                               'message' =>'Get Skorss Successfully',
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
                             'message' =>'Skors Not Found!',
                             'value' => 'null'
                             
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }
    
    
    /*Update*/
    public function update_skor($id,$mid,$uid,$skor,$wrong,$correct,$excerpt){
        $id  = $this->real_escape($id);
        $mid = $this->real_escape($mid);
        $uid = $this->real_escape($uid);
        $skor    = $this->real_escape($skor);
        $wrong   = $this->real_escape($wrong);
        $correct = $this->real_escape($correct);
        $excerpt = $this->real_escape($excerpt);
        
        $date    = date('Y-m-d H:i:s');
        $sql     = "UPDATE skors SET 
                    mid   = '$mid',
                    uid   = '$uid',
                    excerpt = '$excerpt',
                    skor  = '$skor',
                    wrong  = '$wrong',
                    correct= '$correct'
                  WHERE id  = '$id'";
        $exe    = $this->conn->query($sql);
        if($exe){
          $response=array(
                           'status' => 200,
                           'message' =>'Skors Updated Successfully',
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
    public function insert_skor($mid,$uid,$skor,$wrong,$correct,$excerpt){
        $id  = $this->skor_code();
        $mid = $this->real_escape($mid);
        $uid = $this->real_escape($uid);
        $skor    = $this->real_escape($skor);
        $wrong   = $this->real_escape($wrong);
        $correct = $this->real_escape($correct);
        $excerpt = $this->real_escape($excerpt);

          $sql    = "INSERT INTO skors(id, mid, uid, excerpt, skor, wrong, correct)
                   VALUES ('$id','$mid','$uid','$excerpt', '$skor','$wrong','$correct')";
          $exe    = $this->conn->query($sql);
          if($exe){
            $response=array(
                             'status' => 201,
                             'message' =>'Skors Added Successfully',
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
    public function delete_skor($id){
        $id    = $this->real_escape($id);
        $sql   = "DELETE FROM skors WHERE id='$id'";
        $exe   = $this->conn->query($sql);
        if($exe){
           $response=array(
                             'status' => 200,
                             'message' =>'Skors Removed Successfully',
                          );
        }else{
           $response=array(
                             'status' => 500,
                             'message' =>'Filed To Remove Skors!',
                          );
        }
        /*For respon json*/
          header('Content-Type: application/json');
          echo json_encode($response);
    }

}
?>