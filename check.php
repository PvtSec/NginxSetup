<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<?php
	echo "<p style='color: green;'>PHP executed without any errors</p>";
	
	$servername = "localhost";
	$username = "root";
	$password = "";
	
	$conn = mysqli_connect($servername, $username, $password);
	
	if (!$conn)
	{
	    echo "<p style='color: red;'>MySQL Connection Failed</p>";
	}
	else
	{
		echo "<p style='color: green;'>MySQL Connection was Successfull</p>";
	}
?> 

</body>
</html>
