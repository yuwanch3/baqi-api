<?php
  error_reporting(0);
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

    public function upload_image(){

    }


    /*Get All*/
    public function getAllsoal(){
    	$data=array();
    	 $sql    = "SELECT *
                  FROM
                    soal";
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


    /*Update- image blm*/ 
    public function update_soal($id){
        $id        = $this->real_escape($id);
        $question  = $this->real_escape($_POST['question']);
        $type      = $this->real_escape($_POST['type']);
        $mid       = $this->real_escape($_POST['mid']);
        $options   = $_POST['options'];
        $options_img     = $_FILES['options']['name'];
        $images          = $this->real_escape($_POST['image']);
        $correct_options = $_POST['correct_option'];
        $foto            = $_FILES['image']['name']; $sizeFile = $_FILES['image']['size'];
        $img_response    = '';
        $img_main_res    = '';
        $img_opt_res     = '';
        $mb_date         = date('Y-m-d H:i:s');
        $localIP         = $_SERVER['HTTP_HOST'];
        $url             = $localIP.'/assets/imgsoal/';

        $extensiValid = array("jpg","jpeg","png");
        

        //For delete old image
        $data      = array();
        $foderfoto = "../assets/imgsoal/";
        $urld       = 'https://api.pondok-huda.com/assets/imgsoal/';
        $qremove   = "SELECT * FROM soal WHERE id='$id'";
        $run       = $this->conn->query($qremove);              
        $getAd     = $run->fetch_array();
        $dataopt   = $getAd["options"];
        $dataimg   = $getAd["image"];
        $opt       = unserialize($getAd["options"]);
        $jum       = count($opt);

        //begin to delete main image
        $newimg    = str_replace($urld, '', $dataimg);
        if(is_file($foderfoto.$newimg)){
          $img_main_res = 'Successfully';
          unlink($foderfoto.$newimg);
        }

        //begin to deleted option image
        for ($i=0; $i < $jum; $i++) { 
          //hapus foto lama
          $new = str_replace($urld, '', $opt[$i]); 
          if(is_file($foderfoto.$new)){
            $img_opt_res = 'Successfully';
            unlink($foderfoto.$new);
            
          }
         
        }
        //delete old image
        
  
        //Images Question
            if ($foto!="" || $sizeFile!=0){
                $url_univ = '';
                $rand     = rand();
                $namaFile = $_FILES['image']['name'];
                $sizeFile = $_FILES['image']['size'];
                $tmpName  = $_FILES['image']['tmp_name'];
                // cari ekstensi gambar, explode
                $extensi      = explode('.', $namaFile);
                //ambil array terakhir (ekstensi gambar) dan diubah jd huruf kecil
                $extensi      = strtolower(end($extensi));
                //cek ekstensi di dalam array ekstensi yg valid
                $new       = $rand.'_'.$id."-".str_replace(' ', '-', $namaFile);
                
                //Foto
                // Get dimensions of the coriginal image

                if (in_array($extensi, $extensiValid)) {
                      //cek ukuran file
                      if ($sizeFile < 1000000) {
                        if (move_uploaded_file($tmpName, $foderfoto.$new)) {
                              $url_univ  = 'https://'.$url.$new;
                              $img_responseutm = 'uploaded';
                        }else{
                              $img_responseutm = 'error upload';
                        }
                      }else{
                          $img_responseutm = 'file big';
                      }

                }else{
                    $img_responseutm = 'not support';
                }  
                
            
            }else{
              $img_responseutm = 'no image';
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
                    //$extensiValid = array("jpg","jpeg","png");
                    // cari ekstensi gambar, explode
                    $extensi   = explode('.', $namaFile[$i]);
                    //ambil array terakhir (ekstensi gambar) dan diubah jd huruf kecil
                    $extensi   = strtolower(end($extensi));
                    $namaImg   = str_replace('_', '-', $namaFile[$i]);
                    $new       = $rands.'_'.$id."-".str_replace(' ', '-', $namaImg);
                    

                    if (in_array($extensi, $extensiValid)) {
                          //cek ukuran file
                          if ($sizeFile[$i] < 1000000) { 
                            $ra = $rands;
                            $op[] = $rands.'_'.$id."-".str_replace(' ', '-', $namaImg);

                            if (move_uploaded_file($tmpName[$i], $foderfoto.$rands.'_'.$id."-".str_replace(' ', '-', $namaImg))) {
                                 
                                for ($a=0; $a < $option_imge; $a++) { 
                                  
                                  array_push($url_univarr, 'https://'.$url.$op[$a]);
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
            }else{
              $img_response = 'not image';
            }
        //For option type image


        $num = count($options);
        
        //define type Options
        if($type=='option'){
            $newoptions  = serialize($options);
            $newCorrectOption = $correct_options;
            $crt_img= "string";

        }else if($type=='image option'){ //pilihan => array image
            $data            = json_encode($url_univarr);
            $newoptions      = serialize($url_univarr);
            $crt_img         = '';
            $correct_name    = $_FILES['correct_option']['name'];
            $sizeFile        = $_FILES['correct_option']['size'];
            $tmpName         = $_FILES['correct_option']['tmp_name'];
            $extensi         = explode('.', $correct_name);
            $extensi         = strtolower(end($extensi));
            $namaFiles       = str_replace('_', '-', $correct_name);
            $new_crt         = $id."-".str_replace(' ', '-', $namaFiles);

            if (in_array($extensi, $extensiValid)) {
                $val   = implode('_', json_decode($data));
                $ex    = explode('_', $val);
                $key   = array_search($new_crt,$ex); 
                $newCorrectOption =  $ex[$key-1].'_'.$ex[$key];
                $crt_img = 'support';
            }else{
               $crt_img = 'not support';
            }

        }else if($type=='yesorno'){
            $newoptions  = serialize($options);
            $newCorrectOption = $correct_options;
            $crt_img= "string";

        }else if($type=='drag'){  //jawaban dan pilihan => array
            //correctoption array
            $newoptions       = serialize($options);
            $newCorrectOption = serialize($correct_options);
            $crt_img= "string";
        }else if($type=='multi'){ //jawaban dan pilihan => array
            $newoptions  = serialize($options);
            $newCorrectOption = serialize($correct_options);
            $crt_img= "string";

            //correctoption array
        }//define type Options

       
        $newoptions =  $this->real_escape($newoptions);
        $newCorrectOption =  $this->real_escape($newCorrectOption);

        //Action to database
        if( ($img_response=='uploaded') && ($crt_img=='support') && ($img_responseutm=='uploaded' || $img_responseutm=='no image') ){
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

        //for multi/yesorno - options not image with Image main or not
        }else if(($img_response=='not image') && ($crt_img=='string') && ($img_responseutm=='uploaded' || $img_responseutm=='no image')){
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

        //for option text only
        }else if($img_response=='not image' && $img_responseutm=='no image' && $crt_img=='string'){
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
        }else if($img_response=='error upload' || $img_responseutm=='error upload'){
              $response=array(
                               'status' => 500,
                               'message' =>'Filed uploading image!',
                            );

        }else if($img_response=='file big' || $img_responseutm=='file big'){
              $response=array(
                               'status' => 500,
                               'message' =>'Image is oversize!',
                            );
        }else if($img_response=='not support' || $img_responseutm=='not support' || $img_crt=='not support'){
              $response=array(
                               'status' => 500,
                               'message' =>'Image format not suported!',
                            );

        }//Action to database

      /*For respon json*/
      header('Content-Type: application/json');
 
      echo json_encode($response);
    }

    /*Updata en*/
    public function update_soal_en($id){
        $id        = $this->real_escape($id);
        $question  = $this->real_escape($_POST['question']);
        $type      = $this->real_escape($_POST['type']);
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
        $url             = $localIP.'/assets/imgsoal/';

        $extensiValid = array("jpg","jpeg","png");


        //For delete old image
        $data      = array();
        $foderfoto = "../assets/imgsoal/";
        $urld       = 'https://api.pondok-huda.com/assets/imgsoal/';
        $qremove   = "SELECT * FROM soal WHERE id='$id'";
        $run       = $this->conn->query($qremove);
        $getAd     = $run->fetch_array();
        $dataopt   = $getAd["options"];
        $dataimg   = $getAd["image"];
        $opt       = unserialize($getAd["options"]);
        $jum       = count($opt);

        //begin to delete main image
        $newimg    = str_replace($urld, '', $dataimg);
        if(is_file($foderfoto.$newimg)){
          $img_main_res = 'Successfully';
          unlink($foderfoto.$newimg);
        }

        //begin to deleted option image
        for ($i=0; $i < $jum; $i++) {
          //hapus foto lama
          $new = str_replace($urld, '', $opt[$i]);
          if(is_file($foderfoto.$new)){
            $img_opt_res = 'Successfully';
            unlink($foderfoto.$new);

          }

        }
        //delete old image


        //Images Question
            if ($foto!="" || $sizeFile!=0){
                $url_univ = '';
                $rand     = rand();
                $namaFile = $_FILES['image']['name'];
                $sizeFile = $_FILES['image']['size'];
                $tmpName  = $_FILES['image']['tmp_name'];
                // cari ekstensi gambar, explode
                $extensi      = explode('.', $namaFile);
                //ambil array terakhir (ekstensi gambar) dan diubah jd huruf kecil
                $extensi      = strtolower(end($extensi));
                //cek ekstensi di dalam array ekstensi yg valid
                $new       = $rand.'_'.$id."-".str_replace(' ', '-', $namaFile);

                //Foto
                // Get dimensions of the coriginal image

                if (in_array($extensi, $extensiValid)) {
                      //cek ukuran file
                      if ($sizeFile < 1000000) {
                        if (move_uploaded_file($tmpName, $foderfoto.$new)) {
                              $url_univ  = 'https://'.$url.$new;
                              $img_responseutm = 'uploaded';
                        }else{
                              $img_responseutm = 'error upload';
                        }
                      }else{
                          $img_responseutm = 'file big';
                      }

                }else{
                    $img_responseutm = 'not support';
                }


            }else{
              $img_responseutm = 'no image';
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
                    //$extensiValid = array("jpg","jpeg","png");
                    // cari ekstensi gambar, explode
                    $extensi   = explode('.', $namaFile[$i]);
                    //ambil array terakhir (ekstensi gambar) dan diubah jd huruf kecil
                    $extensi   = strtolower(end($extensi));
                    $namaImg   = str_replace('_', '-', $namaFile[$i]);
                    $new       = $rands.'_'.$id."-".str_replace(' ', '-', $namaImg);


                    if (in_array($extensi, $extensiValid)) {
                          //cek ukuran file
                          if ($sizeFile[$i] < 1000000) {
                            $ra = $rands;
                            $op[] = $rands.'_'.$id."-".str_replace(' ', '-', $namaImg);

                            if (move_uploaded_file($tmpName[$i], $foderfoto.$rands.'_'.$id."-".str_replace(' ', '-', $namaImg))) {

                                for ($a=0; $a < $option_imge; $a++) {

                                  array_push($url_univarr, 'https://'.$url.$op[$a]);
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
            }else{
              $img_response = 'not image';
            }
        //For option type image


        $num = count($options);

        //define type Options
        if($type=='option'){
            $newoptions  = serialize($options);
            $newCorrectOption = $correct_options;
            $crt_img= "string";


        }else if($type=='image option'){ //pilihan => array image
            $data            = json_encode($url_univarr);
            $newoptions      = serialize($url_univarr);
            $crt_img         = '';
            $correct_name    = $_FILES['correct_option']['name'];
            $sizeFile        = $_FILES['correct_option']['size'];
            $tmpName         = $_FILES['correct_option']['tmp_name'];
            $extensi         = explode('.', $correct_name);
            $extensi         = strtolower(end($extensi));
            $namaFiles       = str_replace('_', '-', $correct_name);
            $new_crt         = $id."-".str_replace(' ', '-', $namaFiles);

            if (in_array($extensi, $extensiValid)) {
                $val   = implode('_', json_decode($data));
                $ex    = explode('_', $val);
                $key   = array_search($new_crt,$ex);
                $newCorrectOption =  $ex[$key-1].'_'.$ex[$key];
                $crt_img = 'support';
            }else{
               $crt_img = 'not support';
            }

        }else if($type=='yesorno'){
            $newoptions  = serialize($options);
            $newCorrectOption = $correct_options;
            $crt_img= "string";

        }else if($type=='drag'){  //jawaban dan pilihan => array
            //correctoption array
            $newoptions       = serialize($options);
            $newCorrectOption = serialize($correct_options);
            $crt_img= "string";
        }else if($type=='multi'){ //jawaban dan pilihan => array
            $newoptions  = serialize($options);
            $newCorrectOption = serialize($correct_options);
            $crt_img= "string";

            //correctoption array
        }//define type Options


        //$newoptions =  $this->real_escape($newoptions);
        //$newCorrectOption =  $this->real_escape($newCorrectOption);

        //Action to database
        if( ($img_response=='uploaded') && ($crt_img=='support') && ($img_responseutm=='uploaded' || $img_responseutm=='no image') && $type=='image option' ){
            $sql    = "UPDATE soal SET
                              question_en = '$question',
                              options_en  = '$newoptions',
                              image    = '$url_univ',
                              correct_option_en = '$newCorrectOption',
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
                               'message' =>'Internal Server Error 1',
                            );
            }

        //for multi/yesorno - options not image with Image main or not
      }else if(($img_response=='not image') && ($crt_img=='string') && ($img_responseutm=='uploaded' || $img_responseutm=='no image') && ($type=='multi' || $type=='yesorno')){
            $sql    = "UPDATE soal SET
                              question_en = '$question',
                              options_en  = '$newoptions',
                              image    = '$url_univ',
                              correct_option_en = '$newCorrectOption',
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
                               'message' =>'Internal Server Error 2',
                            );
            }

        //for option text only
      }else if($img_response=='not image' && $img_responseutm=='no image' && $crt_img=='string' && $type=='option'){
            $sql    = "UPDATE soal SET
                              question_en = '$question',
                              options_en  = '$newoptions',
                              image    = '$url_univ',
                              correct_option_en = '$newCorrectOption',
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
                               'message' =>'Internal Server Errorss',
                            );
            }
        }else if($img_response=='error upload' || $img_responseutm=='error upload'){
              $response=array(
                               'status' => 500,
                               'message' =>'Filed uploading image!',
                            );

        }else if($img_response=='file big' || $img_responseutm=='file big'){
              $response=array(
                               'status' => 500,
                               'message' =>'Image is oversize!',
                            );
        }else if($img_response=='not support' || $img_responseutm=='not support' || $img_crt=='not support'){
              $response=array(
                               'status' => 500,
                               'message' =>'Image format not suported!',
                            );

        }//Action to database

      /*For respon json*/
      header('Content-Type: application/json');
      // echo json_encode(
      // array(
      //     'opsi img' => $img_response,
      //     'img utama' =>$img_responseutm,
      //     'crt'=>$crt_img,
      //     'type'=>$type,
      //     'corect'=>$newCorrectOption,
      //     'del main'=>$img_main_res,
      //     'del opt'=>$img_opt_res,
      //     'opt num'=>$val,
      //     'question'=>$question,
      //     'newoptions'=>$newoptions,
      //     'url_univ'=>$url_univ,
      //     'newCorrectOption'=>$newCorrectOption,
      //     'mb_dat'=>$mb_date,
      //     'id'=>$id,
      //
      //
      //
      //     )
      // );
      // echo 'sql: '.$sql;
      echo json_encode($response);
    }
    
    /*Insert - image blm---------------------------------------------------------------*/
    public function insert_soal(){
        $id        = $this->soal_code();
        $question  = $this->real_escape($_POST['question']);
        $type      = $this->real_escape($_POST['type']);
        $mid       = $this->real_escape($_POST['mid']);
        $options   = $_POST['options'];
        $options_img     = $_FILES['options']['name'];
        $images          = $this->real_escape($_POST['image']);
        $correct_options = $_POST['correct_option'];
        $foto         = $_FILES['image']['name']; $sizeFile = $_FILES['image']['size'];
        $extensiValid = array("jpg","jpeg","png");
        $img_response = 's';
        $foderfoto    = "../assets/imgsoal/";
        $mb_date      = date('Y-m-d H:i:s');
        $localIP      = $_SERVER['HTTP_HOST'];
        $url          = $localIP.'/assets/imgsoal/';

        //Images Question
        if ($foto!="" || $sizeFile!=0){
          $url_univ = '';
          $rand     = rand();
          $namaFile = $_FILES['image']['name'];
          $sizeFile = $_FILES['image']['size'];
          $tmpName  = $_FILES['image']['tmp_name'];
          // cari ekstensi gambar, explode
          $extensi      = explode('.', $namaFile);
          //ambil array terakhir (ekstensi gambar) dan diubah jd huruf kecil
          $extensi      = strtolower(end($extensi));
          //cek ekstensi di dalam array ekstensi yg valid
          $new       = $rand.'_'.$id."-".str_replace(' ', '-', $namaFile);
          
          //Foto
          // Get dimensions of the coriginal image

          if (in_array($extensi, $extensiValid)) {
                //cek ukuran file
                if ($sizeFile < 1000000) {
                  if (move_uploaded_file($tmpName, $foderfoto.$new)) {
                        $url_univ  = 'https://'.$url.$new;
                        $img_responseutm = 'uploaded';
                  }else{
                        $img_responseutm = 'error upload';
                  }
                }else{
                    $img_responseutm = 'file big';
                }

          }else{
              $img_responseutm = 'not support';
          }  
          
          
        }else{
          $img_responseutm = 'no image';
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
                  //$extensiValid = array("jpg","jpeg","png");
                  // cari ekstensi gambar, explode
                  $extensi   = explode('.', $namaFile[$i]);
                  //ambil array terakhir (ekstensi gambar) dan diubah jd huruf kecil
                  $extensi   = strtolower(end($extensi));
                  $namaImg   = str_replace('_', '-', $namaFile[$i]);
                  $new       = $rands.'_'.$id."-".str_replace(' ', '-', $namaImg);
                  

                  if (in_array($extensi, $extensiValid)) {
                        //cek ukuran file
                        if ($sizeFile[$i] < 1000000) { 
                          $ra = $rands;
                          $op[] = $rands.'_'.$id."-".str_replace(' ', '-', $namaImg);

                          if (move_uploaded_file($tmpName[$i], $foderfoto.$rands.'_'.$id."-".str_replace(' ', '-', $namaImg))) {
                               
                              for ($a=0; $a < $option_imge; $a++) { 
                                
                                array_push($url_univarr, 'https://'.$url.$op[$a]);
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

          
        }else{
          $img_response = 'not image';
        }
        //For option type image


        //define type Options
        if($type=='option'){
            $newoptions  = serialize($options);
            $newCorrectOption = $correct_options;
            $crt_img= "string";

        }else if($type=='image option'){ //pilihan => array image
            $data            = json_encode($url_univarr);
            $newoptions      = serialize($url_univarr);
            $crt_img         = '';
            $correct_name    = $_FILES['correct_option']['name'];
            $sizeFile        = $_FILES['correct_option']['size'];
            $tmpName         = $_FILES['correct_option']['tmp_name'];
            $extensi         = explode('.', $correct_name);
            $extensi         = strtolower(end($extensi));
            $namaFiles       = str_replace('_', '-', $correct_name);
            $new_crt         = $id."-".str_replace(' ', '-', $namaFiles);

            if (in_array($extensi, $extensiValid)) {
                $val   = implode('_', json_decode($data));
                $ex    = explode('_', $val);
                $key   = array_search($new_crt,$ex); 
                $newCorrectOption =  $ex[$key-1].'_'.$ex[$key];
                $crt_img = 'support';
            }else{
               $crt_img = 'not support';
            }

        }else if($type=='yesorno'){
            $newoptions  = serialize($options);
            $newCorrectOption = $correct_options;
            $crt_img= "string";

        }else if($type=='drag'){  //jawaban dan pilihan => array
            //correctoption array
            $newoptions       = serialize($options);
            $newCorrectOption = serialize($correct_options);
            $crt_img= "string";
        }else if($type=='multi'){ //jawaban dan pilihan => array
            $newoptions  = serialize($options);
            $newCorrectOption = serialize($correct_options);
            $crt_img= "string";

            //correctoption array
        }//define type Options


        $newoptions =  $this->real_escape($newoptions);
        $newCorrectOption =  $this->real_escape($newCorrectOption);
        //Action to database // for image option with image main or not
        if(($img_response=='uploaded') && ($crt_img=='support') && ($img_responseutm=='uploaded' || $img_responseutm=='no image')){
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

        //for multi/yesorno - options not image with Image main or not
        }else if(($img_response=='not image') && ($crt_img=='string') && ($img_responseutm=='uploaded' || $img_responseutm=='no image')){
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

        //for option text only
        }else if($img_response=='not image' && $img_responseutm=='no image' && $crt_img=='string'){
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

        
        }else if($img_response=='error upload' || $img_responseutm=='error upload'){
              $response=array(
                               'status' => 500,
                               'message' =>'Filed uploading image!',
                            );

        }else if($img_response=='file big' || $img_responseutm=='file big'){
              $response=array(
                               'status' => 500,
                               'message' =>'Image is oversize!',
                            );
        }else if($img_response=='not support' || $img_responseutm=='not support' || $img_crt=='not support'){
              $response=array(
                               'status' => 500,
                               'message' =>'Image format not suported!',
                            );

        }

    /*For respon json*/
    header('Content-Type: application/json');
     echo json_encode($response);
   
   }
    /*Delete*/
    public function delete_soal($id){
        $id        = $this->real_escape($id);
        $data      = array();
        $foderfoto = "../assets/imgsoal/";
        $url       = 'https://api.pondok-huda.com/assets/imgsoal/';
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