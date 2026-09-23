<?php
//This script to connect to database
class Connection{
	public function get_connection(){
	    $host     = "localhost";     // your server
	    $database = "pondokhu_baqiapps";  // your db name
	    $username = "pondokhu_baqidev";          // username of phpmyadmin
	    $password = "D3v4apps@$22Baqi";              // password of phpmyadmin
	    $connect  = new mysqli($host, $username, $password, $database);
	    return $connect;
	 }
	 //D3v4apps@$22Baqi
	//Construct
    public function __construct(){
          $this->conn = $this->get_connection();
    }
    
 	//To protect from unique characters
	public function real_escape($val){
		return $this->conn->real_escape_string($val);
	} 

	//To Generate date system If needed
	public function date_sistem($var){
		$date = date('Y-m-d', strtotime($var));
		return $date;
	}

	public function api_code($key){
          $sql       = "SELECT apiKey FROM api WHERE apiKey='$key'";
          $run       = $this->conn->query($sql);
          $row       = $run->fetch_row();
          
          if($row > 0){
            $val = '200';
          }else{
            $val = '404';
          }
          return $val;
    }

    public function corecction(){
		return 'Please make the request correctly!';
	}

	public function not_allowed(){
		return '405 Not Allowed!';
	}

}
?>