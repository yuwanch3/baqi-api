<?php
  error_reporting(0);
  date_default_timezone_set("Asia/Jakarta");
  include "../config/connect.php";

  class Last extends Connection{
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
    public function getLastest(){
    	$data=array();
    	 $sql    = "SELECT *
                    FROM
                    lastest LIMIT 12";
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
        	                     'message' =>'List Of Lastest',
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
                             'message' =>'Data Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }
    
    /*Get */
    public function get_last($uid){
       //$mid = $this->real_escape($mid);
       $uid = $this->real_escape($uid);
       $data =array(); 
       $dataw=array(); 
       $datat =array();
       $sqlo    = "SELECT
                          lastest.id, lastest.mid, lastest.uid, lastest.lid,
                          lastest.sublid, lastest.excerpt, lastest.total, lastest.wrong,
                          lastest.correct, lastest.current, lastest.status,
                          lastest.dated, levels.name as lname, materi.information,
                          sub_levels.name
                        FROM
                          lastest INNER JOIN
                          levels ON lastest.lid = levels.id INNER JOIN
                          materi ON lastest.mid = materi.id INNER JOIN
                          sub_levels ON lastest.sublid = sub_levels.id
                WHERE lastest.uid = '$uid'";
       $exeo  = $this->conn->query($sqlo);

       $sqlw    = "SELECT
                        lastest.id, lastest.mid, lastest.uid, lastest.lid,
                        lastest.sublid, lastest.excerpt, lastest.total, lastest.wrong,
                        lastest.correct, lastest.current, lastest.status,
                        lastest.dated, levels.name AS lname
                      FROM
                        lastest INNER JOIN
                        levels ON lastest.mid = levels.id
                      WHERE lastest.uid = '$uid'";
       $exew  = $this->conn->query($sqlw);


       $sqlt    = "SELECT
                        lastest.id, lastest.mid, lastest.uid, lastest.lid,
                        lastest.sublid, lastest.excerpt, lastest.total, lastest.wrong,
                        lastest.correct, lastest.current, lastest.status,
                        lastest.dated, sub_levels.name
                      FROM
                        lastest INNER JOIN
                        sub_levels ON lastest.mid = sub_levels.id
                      WHERE lastest.uid = '$uid'";
       $exet  = $this->conn->query($sqlt);



            //data 1
            if($exeo){
                while($datas = $exeo->fetch_array())
                {
                    array_push($data , array(
                                  "id"         => $datas['id'],
                                  "mid"        => $datas['lid'],
                                  "uid"        => $datas['uid'],
                                  "lid"        => $datas['lid'],
                                  "sublid"     => $datas['sublid'],
                                  "excerpt"    => $datas['excerpt'],
                                  "total"      => $datas['total'],
                                  "wrong"      => $datas['wrong'],
                                  "correct"    => $datas['correct'],
                                  "current"    => $datas['current'],
                                  "status"     => $datas['status'],
                                  "dated"      => $datas['dated'],
                                  "lname"      => $datas['lname'],
                                  "information"=> $datas['excerpt'],
                                  "name"       => $datas['name']
                            ));
                }
                
            }
            
            //data 2
            if($exew){
                while($datas = $exew->fetch_array())
                {
                  array_push($dataw , array(
                                  "id"         => $datas['id'],
                                  "mid"        => $datas['lid'],
                                  "uid"        => $datas['uid'],
                                  "lid"        => $datas['lid'],
                                  "sublid"     => $datas['sublid'],
                                  "excerpt"    => $datas['excerpt'],
                                  "total"      => $datas['total'],
                                  "wrong"      => $datas['wrong'],
                                  "correct"    => $datas['correct'],
                                  "current"    => $datas['current'],
                                  "status"     => $datas['status'],
                                  "dated"      => $datas['dated'],
                                  "lname"      => $datas['lname'],
                                  "information"=> $datas['excerpt'],
                                  "name"       => $datas['lname']
                  ));
                } 


            }

            //data 3
            if($exet){
                while($datas = $exet->fetch_array())
                {
                   array_push($datat , array(
                                  "id"         => $datas['id'],
                                  "mid"        => $datas['lid'],
                                  "uid"        => $datas['uid'],
                                  "lid"        => $datas['lid'],
                                  "sublid"     => $datas['sublid'],
                                  "excerpt"    => $datas['excerpt'],
                                  "total"      => $datas['total'],
                                  "wrong"      => $datas['wrong'],
                                  "correct"    => $datas['correct'],
                                  "current"    => $datas['current'],
                                  "status"     => $datas['status'],
                                  "dated"      => $datas['dated'],
                                  "lname"      => '',
                                  "information"=> $datas['excerpt'],
                                  "name"       => $datas['name']
                  ));
                }
                
            }

            

            if(!$exew || !$exet || !$exeo){

                $response=array(
                               'status' => 500,
                               'message' =>'Internal Server Error',
                               'value' => 'null'
                            );
            
            }



            $newarray = array_merge($data,$dataw,$datat);

            if(empty($newarray)){
                $response=array(
                               'status' => 404,
                               'message' =>'Data Not Found!',
                               'value' => 'null'
                            );
            }else{

                $response=array(
                                   'status' => 200,
                                   'message' =>'Get Lastest Successfully',
                                   'value' => $newarray
                                );
            }
       
        header('Content-Type: application/json');
        echo json_encode($response);
    }

    /*Get */
    public function get_lastmid($mid, $uid, $excerpt){
       $mid     = $this->real_escape($mid);
       $uid     = $this->real_escape($uid);
       $excerpt = $this->real_escape($excerpt);
       $data    =array();
       $var_id  = substr($mid, 0,3);

       if($var_id=='MTR'){
          $sql    = "SELECT
                          lastest.id, lastest.mid, lastest.uid, lastest.lid,
                          lastest.sublid, lastest.excerpt, lastest.total, lastest.wrong,
                          lastest.correct, lastest.current, lastest.status,
                          lastest.dated, levels.name as lname, materi.information,
                          sub_levels.name
                        FROM
                          lastest INNER JOIN
                          levels ON lastest.lid = levels.id INNER JOIN
                          materi ON lastest.mid = materi.id INNER JOIN
                          sub_levels ON lastest.sublid = sub_levels.id
                WHERE lastest.uid = '$uid' AND lastest.mid='$mid'";

       }else if($var_id=='LVC'){
          $sql    = "SELECT
                        lastest.id, lastest.mid, lastest.uid, lastest.lid,
                        lastest.sublid, lastest.excerpt, lastest.total, lastest.wrong,
                        lastest.correct, lastest.current, lastest.status,
                        lastest.dated, levels.name AS lname
                      FROM
                        lastest INNER JOIN
                        levels ON lastest.mid = levels.id
                      WHERE lastest.uid = '$uid' AND lastest.mid='$mid' AND lastest.excerpt='$excerpt'";
       }else{
          $sql    = "SELECT
                        lastest.id, lastest.mid, lastest.uid, lastest.lid,
                        lastest.sublid, lastest.excerpt, lastest.total, lastest.wrong,
                        lastest.correct, lastest.current, lastest.status,
                        lastest.dated, sub_levels.name
                      FROM
                        lastest INNER JOIN
                        sub_levels ON lastest.mid = sub_levels.id
                      WHERE lastest.uid = '$uid' AND lastest.mid='$mid' AND lastest.excerpt='$excerpt'";
       }


       
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
                               'message' =>'Get Lastest Successfully',
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
                             'message' =>'Data Not Found!',
                             'value' => $mid
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }

    /*Update*/
    public function update_last($id){
        $id  = $this->real_escape($id);
        $mid = $this->real_escape($_POST['mid']);
        $uid = $this->real_escape($_POST['uid']);
        $lid = $this->real_escape($_POST['lid']);
        $sid = $this->real_escape($_POST['sublid']);
        $total   = $this->real_escape($_POST['total']);
        $wrong   = $this->real_escape($_POST['wrong']);
        $correct = $this->real_escape($_POST['correct']);
        $excerpt = $this->real_escape($_POST['excerpt']);
        $current = $this->real_escape($_POST['current']);
        $status  = $this->real_escape($_POST['status']);

        $date    = date('Y-m-d H:i:s');
        $sql     = "UPDATE lastest SET 
                    mid    = '$mid',
                    uid    = '$uid',
                    lid    = '$lid',
                    sublid = '$sublid',
                    total  = '$total',
                    wrong  = '$wrong',
                    correct= '$correct',
                    current='$current',
                    status ='$status'
                  WHERE id = '$id'";
        $exe    = $this->conn->query($sql);
        if($exe){
          $response=array(
                           'status' => 200,
                           'message' =>'Data Updated Successfully',
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
    public function insert_last(){
        $mid = $this->real_escape($_POST['mid']);
        $uid = $this->real_escape($_POST['uid']);
        $lid = $this->real_escape($_POST['lid']);
        $sid = $this->real_escape($_POST['sublid']);
        $total   = $this->real_escape($_POST['total']);
        $wrong   = $this->real_escape($_POST['wrong']);
        $correct = $this->real_escape($_POST['correct']);
        $excerpt = $this->real_escape($_POST['excerpt']);
        $current = $this->real_escape($_POST['current']);
        $status  = $this->real_escape($_POST['status']);

          $sql    = "INSERT INTO lastest(id, mid, uid, lid, sublid, excerpt, total, wrong, correct, current, status, dated)
                   VALUES ('','$mid','$uid','$lid','$sublid','$excerpt','$total','$wrong','$correct','$current','$status','')";
          $exe    = $this->conn->query($sql);
          if($exe){
            $response=array(
                             'status' => 201,
                             'message' =>'Data Added Successfully',
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
    public function delete_last($id){
        $id    = $this->real_escape($id);
        $sql   = "DELETE FROM lastest WHERE id='$id'";
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