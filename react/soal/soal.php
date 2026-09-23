<?php
  //error_reporting(0);
  date_default_timezone_set("Asia/Jakarta");
  include "../config/connect.php";

  class Questions extends Connection{
    public $tgl;
    
    //Construct
    public function __construct(){
          $this->conn = $this->get_connection();
    }
    
    /*Code Generator*/
    public function soal_code(){
          $num       = '';
          $perfix    = 'QST';
          $sql       = "SELECT MAX(id) AS kode FROM soal";
          $run       = $this->conn->query($sql);
          $data      = $run->fetch_array();
          $row       = $run->fetch_row();
          $num       = $data["kode"];
          $number    = (int)substr($num, 3, 20);
                       $number++;
          if($row > 0){
            return 'kode telah digunakan';
          }else{
            $val = $perfix.sprintf("%020s", $number);
          }
          
          return $val;
    }

   
    /*Get All*/
    public function getAllsoal(){
    	$data=array();
    	 $sql    = "SELECT *
                  FROM
                    soal ORDER BY id ASC";
        $exe  = $this->conn->query($sql);
        $row  = $exe->num_rows;
        if($row>0){
            if($exe){
                while($row= $exe->fetch_array())
        	      {
                   if($row['type']=='drag' || $row['type']=='mult'){
                       $correctOption = unserialize($row['correct_option']);
                   }else{
                       $correctOption =$row['correct_option'];
                   }


        	         array_push($data, array(
                        'status'  => 200,
                        'message' =>'List Of Questions',
                        'id'      => $row['id'],
                        'value'   => array(
                                        'question'=> $row['question'],
                                        'type'    => $row['type'],
                                        'mid'     => $row['mid'],
                                        'options' => unserialize($row['options']),
                                        'image'   => $row['image'],
                                        'correct_option'=> $correctOption,
                                        'created'       => $row['created']
                                     )
                    ));

                   

        	      } $response=$data;
            	      
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
                             'message' =>'Questions Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }
    

    /*Get*/
    public function get_soal($id){
       $data =array();
       $sql    = "SELECT
                    *
                  FROM
                    soal
                  WHERE id='$id'";

        $exe  = $this->conn->query($sql);
        $row  = $exe->num_rows;
        if($row>0){
            if($exe){
                while($row= $exe->fetch_array())
                {
                   if($row['type']=='drag' || $row['type']=='multi'){
                       $correctOption = unserialize($row['correct_option']);
                   }else{
                       $correctOption =$row['correct_option'];
                   }

                   array_push($data, array(
                        'status'  => 200,
                        'message' =>'List Of Questions',
                        'id'      => $row['id'],
                        'value'   => array(
                                        'question'=> $row['question'],
                                        'type'    => $row['type'],
                                        'mid'     => $row['mid'],
                                        'options' => unserialize($row['options']),
                                        'image'   => $row['image'],
                                        'correct_option'=> $correctOption,
                                        'created'       => $row['created']
                                     )
                    ));

                   

                } $response=$data;

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
                             'message' =>'Questions Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }
    
    
    /*Get*/
    public function get_soalmid($mid){
       $data =array();
       $sql    = "SELECT
                    *
                  FROM
                    soal
                  WHERE mid='$mid'";

        $exe  = $this->conn->query($sql);
        $row  = $exe->num_rows;
        if($row>0){
            if($exe){
                while($row= $exe->fetch_array())
                {
                   if($row['type']=='drag' || $row['type']=='multi'){
                       $correctOption = unserialize($row['correct_option']);
                   }else{
                       $correctOption =$row['correct_option'];
                   }

                   array_push($data, array(
                        'status'  => 200,
                        'message' =>'List Of Questions',
                        'id'      => $row['id'],
                        'value'   => array(
                                        'question'=> $row['question'],
                                        'type'    => $row['type'],
                                        'mid'     => $row['mid'],
                                        'options' => unserialize($row['options']),
                                        'image'   => $row['image'],
                                        'correct_option'=> $correctOption,
                                        'created'       => $row['created']
                                     )
                    ));

                   

                } $response=$data;

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
                             'message' =>'Questions Not Found!',
                             'value' => 'null'
                          );
        }
        header('Content-Type: application/json');
        echo json_encode($response);
    }

    /*Update Admin- image blm*/ 
    public function update_soal($id){
        $id        = $this->real_escape($id);
        $question  = $this->real_escape($_POST['question']);
        $type      = $this->real_escape($_POST['type']);
        $mid       = $this->real_escape($_POST['mid']);
        $options   = $_POST['options'];
        $options_img     = $_FILES['options']['name'];
        $images          = $this->real_escape($_POST['image']);
        $correct_options = $this->real_escape($_POST['correct_option']);
        $foto            = $_FILES['image']['name']; $sizeFile = $_FILES['image']['size'];
        $img_response    = '';
        $img_main_res    = '';
        $img_opt_res     = '';
        $mb_date         = date('Y-m-d H:i:s');
        $localIP         = $_SERVER['HTTP_HOST'];
        $url             = $localIP.'/baqi/assets/imgsoal/';


        //For delete old image
        $data      = array();
        $foderfoto = "../assets/imgsoal/";
        $url       = 'http://localhost/baqi/assets/imgsoal/';
        $qremove   = "SELECT * FROM soal WHERE id='$id'";
        $run       = $this->conn->query($qremove);              
        $getAd     = $run->fetch_array();
        $dataopt   = $getAd["options"];
        $dataimg   = $getAd["image"];
        $opt       = unserialize($getAd["options"]);
        $jum       = count($opt);

        //begin to delete main image
        $newimg    = str_replace($url, '', $dataimg);
        if(is_file($foderfoto.$newimg)){
          $img_main_res = 'Successfully';
          unlink($foderfoto.$newimg);
        }

        //begin to deleted option image
        for ($i=0; $i < $jum; $i++) { 
          //hapus foto lama
          $new = str_replace($url, '', $opt[$i]); 
          if(is_file($foderfoto.$new)){
            $img_opt_res = 'Successfully';
            unlink($foderfoto.$new);
          }
        }
        //delete old image
        
        //If image old has been deleted
        if($img_main_res=='Successfully' && $img_opt_res=='Successfully'){

          //Images Question
          if ($foto!="" || $sizeFile!=0){
            $url_univ = '';
            $rand     = rand();
            $namaFile = $_FILES['image']['name'];
            $sizeFile = $_FILES['image']['size'];
            $tmpName  = $_FILES['image']['tmp_name'];
            //ekstensi gambar valid/boleh di upload
            $extensiValid = array("jpg","jpeg","png");
            $extensi   = explode('.', $namaFile);
            $extensi   = strtolower(end($extensi));
            $new       = $rand.'_'.$id."_".str_replace(' ', '_', $namaFile);

            if (in_array($extensi, $extensiValid)) {
                  //cek ukuran file
                  if ($sizeFile < 1000000) {
                    if (move_uploaded_file($tmpName, $foderfoto.$new)) {
                          $url_univ  = 'http://'.$url.$new;
                          $img_response = 'uploaded';
                    }else{
                          $img_response = 'error upload';
                    }
                  }else{
                      $img_response = 'file big';
                  }

            }else{
                $img_response = 'not support';
            }  
            
          }//Images Question

          $option_string  = count($options);
          $option_imge    = count($options_img);

          //For option type image
          if($option_imge>0){
              for ($i=0; $i < $option_imge; $i++) { 
                
                    $url_univarr= array();
                    $rands      = rand();
                    $namaFile   = $_FILES['options']['name'];
                    $sizeFile   = $_FILES['options']['size'];
                    $tmpName    = $_FILES['options']['tmp_name'];
                    //ekstensi gambar valid/boleh di upload
                    $extensiValid = array("jpg","jpeg","png");
                    $extensi   = explode('.', $namaFile[$i]);
                    $extensi   = strtolower(end($extensi));
                    $new       = $rands.'_'.$id."_".str_replace(' ', '_', $namaFile[$i]);

                    if (in_array($extensi, $extensiValid)) {
                          //cek ukuran file
                          if ($sizeFile[$i] < 1000000) { 
                            $ra = $rands;
                            $op[] = $rands.'_'.$id."_".str_replace(' ', '_', $namaFile[$i]);

                            if (move_uploaded_file($tmpName[$i], $foderfoto.$rands.'_'.$id."_".str_replace(' ', '_', $namaFile[$i]))) {
                                for ($a=0; $a < $option_imge; $a++) { 
                                  array_push($url_univarr, 'http://'.$url.$op[$a]);
                                }
                                  $img_response = 'uploaded';
                            }else{
                                  $img_response = 'error upload';
                            }
                          }else{
                              $img_response = 'file big';
                          }

                    }else{
                        $img_response = 'not support';
                    }  
                    
                  //Images

              }
          }
          //For option type image

        }//image old deleted suscces


        $num = count($options);
        
        //define type Options
        if($type=='option'){
            $newoptions  = serialize($options);
            $newCorrectOption = $correct_options;

        }else if($type=='image option'){ //pilihan => array image
            $newoptions  = serialize($url_univarr);
            $newCorrectOption = $correct_options;

        }else if($type=='yesorno'){
            $newoptions  = serialize($data);
            $newCorrectOption = $correct_options;

        }else if($type=='drag'){  //jawaban dan pilihan => array
            //correctoption array
            $newoptions  = serialize($options);
            $newCorrectOption = serialize($correct_options);

        }else if($type=='multi'){ //jawaban dan pilihan => array
            $newoptions  = serialize($data);
            $newCorrectOption = serialize($correct_options);
            //correctoption array
        }//define type Options


        //Action to database
        if($img_response=='uploaded'){
            $sql    = "UPDATE soal SET 
                              question = '$question',
                              type     = '$type',
                              mid      = '$mid',
                              options  = '$newoptions',
                              image    = '$url_univ',
                              correct_option = '$newCorrectOption',
                              updated        = '$mb_date'
                       WHERE id  = '$id'";
            $exe    =  $this->conn->query($sql);
            if($exe){
              $response=array( 
                               'status' => 200,
                               'message' =>'Questions Updated Successfully',
                            );
            }else{
              $response=array(
                               'status' => 500,
                               'message' =>'Internal Server Error',
                            );
            }
        }else if($img_response=='error upload'){
          $response=array(
                               'status' => 500,
                               'message' =>'Filed uploading image!',
                            );

          }else if($img_response=='file big'){
              $response=array(
                               'status' => 500,
                               'message' =>'Image is oversize!',
                            );
            }else if($img_response=='not support'){
              $response=array(
                               'status' => 500,
                               'message' =>'Image format not suported!',
                            );

        }//Action to database
      /*For respon json*/
      header('Content-Type: application/json');
      echo json_encode($response);
    }


    /*Insert Admin- image blm*/
    public function insert_soal(){
        $id        = $this->soal_code();
        $question  = $this->real_escape($_POST['question']);
        $type      = $this->real_escape($_POST['type']);
        $mid       = $this->real_escape($_POST['mid']);
        $options   = $_POST['options'];
        $options_img = $_FILES['options']['name'];
        $images    = $this->real_escape($_POST['image']);
        $correct_options = $this->real_escape($_POST['correct_option']);
        //$num       = count($options);
        $foto      = $_FILES['image']['name']; $sizeFile = $_FILES['image']['size'];
        $img_response = 's';

        //Images Question
        if ($foto!="" || $sizeFile!=0){
          $url_univ = '';
          $rand     = rand();
          $namaFile = $_FILES['image']['name'];
          $sizeFile = $_FILES['image']['size'];
          $tmpName  = $_FILES['image']['tmp_name'];
          //ekstensi gambar valid/boleh di upload
          $extensiValid = array("jpg","jpeg","png");
          // cari ekstensi gambar, explode
          $extensi   = explode('.', $namaFile);
          //ambil array terakhir (ekstensi gambar) dan diubah jd huruf kecil
          $extensi   = strtolower(end($extensi));
          //cek ekstensi di dalam array ekstensi yg valid
          $foderfoto = "../assets/imgsoal/";
          $fodercrop = "../assets/imgsoal/crop";
          $new       = $rand.'_'.$id."_".str_replace(' ', '_', $namaFile);
          $mb_date   = date('Y-m-d H:i:s');
          $localIP   = $_SERVER['HTTP_HOST'];
          $url       = $localIP.'/baqi/assets/imgsoal/';
          //Foto
          // Get dimensions of the coriginal image

          if (in_array($extensi, $extensiValid)) {
                //cek ukuran file
                if ($sizeFile < 1000000) {
                  if (move_uploaded_file($tmpName, $foderfoto.$new)) {
                        $url_univ  = 'http://'.$url.$new;
                        $img_response = 'uploaded';
                  }else{
                        $img_response = 'error upload';
                  }
                }else{
                    $img_response = 'file big';
                }

          }else{
              $img_response = 'not support';
          }  
          
        }//Images Question

        $option_string  = count($options);
        $option_imge    = count($options_img);

        //For option type image
        if($option_imge>0){
            for ($i=0; $i < $option_imge; $i++) { 
              
                  $url_univarr= array();
                  $rands      = rand();
                  $namaFile   = $_FILES['options']['name'];
                  $sizeFile   = $_FILES['options']['size'];
                  $tmpName    = $_FILES['options']['tmp_name'];
                  //ekstensi gambar valid/boleh di upload
                  $extensiValid = array("jpg","jpeg","png");
                  // cari ekstensi gambar, explode
                  $extensi   = explode('.', $namaFile[$i]);
                  //ambil array terakhir (ekstensi gambar) dan diubah jd huruf kecil
                  $extensi   = strtolower(end($extensi));
                  //cek ekstensi di dalam array ekstensi yg valid
                  $foderfoto = "../assets/imgsoal/";
                  $fodercrop = "../assets/imgsoal/crop";
                  $new       = $rands.'_'.$id."_".str_replace(' ', '_', $namaFile[$i]);
                  $mb_date   = date('Y-m-d H:i:s');
                  $localIP   = $_SERVER['HTTP_HOST'];
                  $url       = $localIP.'/baqi/assets/imgsoal/';
                  //Foto
                  // Get dimensions of the coriginal image

                  if (in_array($extensi, $extensiValid)) {
                        //cek ukuran file
                        if ($sizeFile[$i] < 1000000) { 
                          $ra = $rands;
                          $op[] = $rands.'_'.$id."_".str_replace(' ', '_', $namaFile[$i]);

                          if (move_uploaded_file($tmpName[$i], $foderfoto.$rands.'_'.$id."_".str_replace(' ', '_', $namaFile[$i]))) {
                               
                              for ($a=0; $a < $option_imge; $a++) { 
                                
                                array_push($url_univarr, 'http://'.$url.$op[$a]);
                              }
                                $img_response = 'uploaded';
                          }else{
                                $img_response = 'error upload';
                          }
                        }else{
                            $img_response = 'file big';
                        }

                  }else{
                      $img_response = 'not support';
                  }  
                  
                //Images

            }
        }
        //For option type image


        //define type Options
        if($type=='option'){
            $newoptions  = serialize($options);
            $newCorrectOption = $correct_options;

        }else if($type=='image option'){ //pilihan => array image
            $newoptions  = serialize($url_univarr);
            $newCorrectOption = $correct_options;

        }else if($type=='yesorno'){
            $newoptions  = serialize($data);
            $newCorrectOption = $correct_options;

        }else if($type=='drag'){  //jawaban dan pilihan => array
            //correctoption array
            $newoptions  = serialize($options);
            $newCorrectOption = serialize($correct_options);

        }else if($type=='multi'){ //jawaban dan pilihan => array
            $newoptions  = serialize($data);
            $newCorrectOption = serialize($correct_options);
            //correctoption array
        }//define type Options

        //Action to database
        if($img_response=='uploaded'){
            $sql    = "INSERT INTO soal(id, question, type, mid, options, image, correct_option, updated) 
                       VALUES ('$id','$question','$type','$mid','$newoptions','$url_univ','$newCorrectOption','')";
            $exe    =  $this->conn->query($sql);
            if($exe){
              $response=array( 
                               'status' => 201,
                               'message' =>'Questions Added Successfully',
                            );
            }else{
              $response=array(
                               'status' => 500,
                               'message' =>'Internal Server Error',
                            );
            }
        }else if($img_response=='error upload'){
          $response=array(
                               'status' => 500,
                               'message' =>'Filed uploading image!',
                            );

          }else if($img_response=='file big'){
              $response=array(
                               'status' => 500,
                               'message' =>'Image is oversize!',
                            );
            }else if($img_response=='not support'){
              $response=array(
                               'status' => 500,
                               'message' =>'Image format not suported!',
                            );

        }

    /*For respon json*/
    header('Content-Type: application/json');
    echo json_encode($response);
         
    
    }

    /*Delete Admin*/
    public function delete_soal($id){
        $id        = $this->real_escape($id);
        $data      = array();
        $foderfoto = "../assets/imgsoal/";
        $url       = 'http://localhost/baqi/assets/imgsoal/';
        $qremove   = "SELECT * FROM soal WHERE id='$id'";
        $run       = $this->conn->query($qremove);              
        $getAd     = $run->fetch_array();
        $dataopt   = $getAd["options"];
        $dataimg   = $getAd["image"];
        $opt       = unserialize($getAd["options"]);
        $jum       = count($opt);

        
        $newimg    = str_replace($url, '', $dataimg);
        if(is_file($foderfoto.$newimg))unlink($foderfoto.$newimg);

        for ($i=0; $i < $jum; $i++) { 
          //hapus foto lama
          $new = str_replace($url, '', $opt[$i]); 
          if(is_file($foderfoto.$new))unlink($foderfoto.$new);
        }
        

        $sql   = "DELETE FROM soal WHERE id='$id'";
        $exe   = $this->conn->query($sql);
        if($exe){
           $response=array(
                             'status' => 200,
                             'message' =>'Questions Removed Successfully',
                          );
        }else{
           $response=array(
                             'status' => 500,
                             'message' =>'Filed To Remove Questions!',
                          );
        }
        /*For respon json*/
        header('Content-Type: application/json');
        echo json_encode($response);
    }

}
?>