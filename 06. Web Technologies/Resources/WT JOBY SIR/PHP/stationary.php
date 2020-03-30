<?xml version = "1.0" encoding = "utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<!-- stationary.php - Process the form described in stationary.html -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>Process the Stationary.html form</title>
</head>
<body>
<?php
// Get form data values
$book = $_POST["book"];
$pen = $_POST["pen"];
$pencil = $_POST["pencil"];
$eraser = $_POST["eraser"];
$name = $_POST["name"];
$street = $_POST["street"];
$city = $_POST["city"];
$payment = $_POST["payment"];
// If any of the quantities are blank set them to zero
if ($book == " ") $book = 0;
if ($pen == " ") $pen = 0;
if ($pencil == " ") $pencil = 0;
if ($eraser == " ") $eraser = 0;
//Compute the item costs and total cost
$book_cost = 15.00 * $book;
$pen_cost = 8.00 * $pen;
$pencil_cost = 3.00 * $pencil;
$eraser_cost = 5.00 * $eraser;
$total_price = $book_cost + $pen_cost + $pencil_cost + $eraser_cost;
$total_items = $book + $pen + $pencil + $eraser;
// Return the results to the browser in a table
?>
<h4>Customer: </h4>
<?php
print ("$name <br/> $street <br/> $city <br/>");
?>
<p/><p/>
<table border = "border">
<caption> Order Information </caption>
<tr>
<th> Product </th>
<th> Unit Price </th>
<th> Quantity Ordered </th>
<th> Item Cost </th>
</tr>
<tr align = "center">
<td> Note Book </td>
<td> Rs15.00 </td>
<td> <?php print ("$book"); ?> </td>
<td> <?php printf ("Rs %4.2f", $book_cost); ?> </td>
</tr>
<tr align = "center">
<td> Ball Pen </td>
<td> Rs8.00 </td>
<td> <?php print ("$pen"); ?> </td>
<td> <?php printf ("Rs %4.2f", $pen_cost); ?> </td>
</tr>
<tr align = "center">
<td> Pencil </td>
<td> Rs3.00 </td>
<td> <?php print ("$pencil"); ?> </td>
<td> <?php printf ("Rs %4.2f", $pencil_cost); ?> </td>
</tr>
<tr align = "center">
<td> Eraser </td>
<td> Rs5.00 </td>
<td> <?php print ("$eraser"); ?> </td>
<td> <?php printf ("Rs %4.2f", $eraser_cost); ?> </td>
</tr>
</table>
<p/><p/>
<?php
print "You ordered $total_items items <br/>";
printf ("Your total bill is: Rs %5.2f <br/>", $total_price);
print "Your chosen method of payment is: $payment <br/>";
?>

</body>
</html>
