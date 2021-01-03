<?php
	echo "PHP is working";
	
	$servername = "localhost";
	$username = "root";
	$password = "";
	
	$conn = mysqli_connect($servername, $username, $password);
	
	if (!$conn)
	{
	    echo "MySQL Connection Failed";
	}
	else
	{
		echo "MySQL Connection was successfull";
	}
?> 