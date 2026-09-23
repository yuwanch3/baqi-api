<?php
  error_reporting(0);
  date_default_timezone_set("Asia/Jakarta");
  include "../config/connect.php";

  class Users extends Connection{
    public $tgl;
    
    //Construct
    public function __construct(){
          $this->conn = $this->get_connection();
    }
    
    /*Code Generator*/
    public function users_code(){
          $num       = '';
          $perfix    = 'USR';
          $sql       = "SELECT MAX(id) AS kode FROM users";
          $run       = $this->conn->query($sql);
          $data      = $run->fetch_array();
          $row       = $run->fetch_row();
          $num       = $data["kode"];
          $number    = (int)substr($num, 3, 17);
                       $number++;
          if($row > 0){
            return 'kode telah digunakan';
          }else{
            $val = $perfix.sprintf("%017s", $number);
          }
          
          return $val;
    }

    /*Get All*/
    public function getAllusers(){
    	$data=array();
    	 $sql    = "SELECT id, name, email, phone, username, picture, created, updated
                  FROM
                    users";
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
        	                     'message' =>'List Of Member',
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
                             'data' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }

    /*Get*/
    public function get_users($id){
       $data =array();
       $sql    = "SELECT
                    id, name, email, phone, username, picture, created, updated
                  FROM
                    users
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
    public function update_users($id){
        $id  = $this->real_escape($id);
        $mb_name = $this->real_escape($_POST['name']);
        $mb_email = $this->real_escape($_POST['email']);
        $mb_phone  = $this->real_escape($_POST['phone']);
        $mb_date      = date('Y-m-d H:i:s');
        $sql    = "UPDATE users SET 
                    name = '$mb_name',
                    email= '$mb_email',
                    phone= '$mb_phone',
                    updated= '$mb_date'
                  WHERE id  = '$id'";
        $exe    = $this->conn->query($sql);
        if($exe){
          $response=array(
                           'status' => 200,
                           'message' =>'Users Updated Successfully',
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


    public function update_photo($id){
        $id       = $this->real_escape($id);
        $rand     = rand();
        $namaFile = $_FILES['picture']['name'];
        $sizeFile = $_FILES['picture']['size'];
        $tmpName  = $_FILES['picture']['tmp_name'];
        //ekstensi gambar valid/boleh di upload
        $extensiValid = array("jpg","jpeg","png");
        // cari ekstensi gambar, explode
        $extensi  = explode('.', $namaFile);
        //ambil array terakhir (ekstensi gambar) dan diubah jd huruf kecil
        $extensi  = strtolower(end($extensi));
        //cek ekstensi di dalam array ekstensi yg valid
        $foderfoto = "../assets/img/";
        $fodercrop = "../assets/img/crop";
        $new       = $rand.'_'.$id."_".str_replace(' ', '-', $namaFile);;
        $mb_date   = date('Y-m-d H:i:s');
        $localIP   = $_SERVER['HTTP_HOST'];
        $url       = $localIP.'/react/assets/img/';
        $urlold    = 'https://api.pondok-huda.com/react/assets/img/';
        //Foto
        // Get dimensions of the coriginal image

        if (in_array($extensi, $extensiValid)) {
              //cek ukuran file
              if ($sizeFile < 1000000) {
                if (move_uploaded_file($tmpName, $foderfoto.$new)) {
                     $qremove     = "SELECT * FROM users WHERE id='$id'";
                      $run        = $this->conn->query($qremove);
                      
                      $getAd      = $run->fetch_array();
                      $dataimg    = $getAd["picture"];
                      $newimg     = str_replace($urlold, '', $dataimg);
                    //hapus foto lama
                    if(is_file($foderfoto.$newimg))
                        unlink($foderfoto.$newimg);
                      $url    = 'https://'.$url.$new;
                      $update = "UPDATE users SET 
                                  picture  ='$url',
                                  updated  ='$mb_date'
                                WHERE id ='$id'";
                      $exe    = $this->conn->query($update);

                      if ($exe) {
                            $response=array(
                                            'status'  => 200,
                                            'message' =>'Update Picture Successfully',
                                            'picture' => $url,
                                         
                          );     
                           //sukses
                      } else {
                          $response=array(
                             'status' => 500,
                             'message' =>'Internal Server Error',
                          );
                      }

                }else{
                      $response=array(
                             'status' => 500,
                             'message' =>'Internal Server Error',
                          );
                }
              }else{
                  $response=array(
                             'status' => 500,
                             'message' =>'Image Size is too Big!',
                          );
              }

        }else{
            $response=array(
                             'status' => 500,
                             'message' =>'Extension not supported!',
                          );
        }
   
        /*For respon json*/
        header('Content-Type: application/json');
        echo json_encode($response);  

    }

    /*Insert*/
    public function insert_users(){
        $mb_id  = $this->users_code();
        $mb_name = $this->real_escape($_POST['name']);
        $mb_email = $this->real_escape($_POST['email']);
        $mb_phone  = $this->real_escape($_POST['phone']);
        $mb_username = $this->real_escape($_POST['username']);
        $mb_password = $this->real_escape($_POST['password']);
        

          $sql    = "INSERT INTO users(id, name, email, phone, username, password, picture, updated)
                   VALUES ('$mb_id','$mb_name','$mb_email','$mb_phone','$mb_username','$mb_password','','')";
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
    public function delete_users($id){
        $id    = $this->real_escape($id);
        $sql   = "DELETE FROM users WHERE id='$id'";
        $exe   = $this->conn->query($sql);
        if($exe){
            $response=array(
                             'status' => 200,
                             'message' =>'Users Removed Successfully',
                          );
        }else{
            $response=array(
                             'status' => 500,
                             'message' =>'Filed To Remove Member!',
                          );
        }
        /*For respon json*/
          header('Content-Type: application/json');
          echo json_encode($response);
    }

}
?>