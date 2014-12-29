<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Trend Analysis Tool</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
  <script>
  $(function() {
    $( ".datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' } );
  });
  </script>
</head>
<body>
<h1>Trend Analysis Tool</h1>
			<form id="form1" method="post" action="TrendAnalysisServlet">
			
			<table>
			<tr>
				<td>Enter the Category One</td> 
				<td><select >
 				 <option value="volvo">Sports</option>
  				<option value="saab">Saab</option>
  				<option value="vw">VW</option>
  				<option value="audi" selected>Audi</option>
				</select></td>
					
			</tr>
			<tr>
				<td>Enter the Sub Category One</td> 
				<td><select name="subCategory1">
 				 <option value="The_Reaper">The_Reaper </option>
  				<option value="saab">Saab</option>
  				<option value="vw">VW</option>
  				<option value="audi" selected>Audi</option>
				</select></td>
					
			</tr>
			<tr>
				<td>Start Date</td> 
				<td><input name="startDate" type="text" class="datepicker"></td> 
			</tr>
			<tr>
				<td>Enter the Category Two</td> 
				<td><select>
 				 <option value="volvo">Sports</option>
  				<option value="saab">Saab</option>
  				<option value="vw">VW</option>
  				<option value="audi" selected>Audi</option>
				</select></td>
					
			</tr>
			<tr>
				<td>Enter the Sub Category Two</td> 
				<td><select name="subCategory2">
 				 <option value="With_You">With_You</option>
  				<option value="saab">Saab</option>
  				<option value="vw">VW</option>
  				<option value="audi" selected>Audi</option>
				</select></td>
					
			</tr>
			<tr>
				<td>End Date</td> 
				<td><input name="endDate" type="text" class="datepicker"> </td>
					
			</tr>
			</table>
			<input type="submit" value="Submit">
			</form>
</body>
</html>