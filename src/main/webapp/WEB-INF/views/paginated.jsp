<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript"
	src="<c:url value="/resources/js/jquery/jquery-1.4.4.min.js" />"></script>
<link href="<c:url value="/resources/css/objects.css" />"
	rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript">
     var jq = jQuery.noConflict();
 </script>

<title>Paginated Results</title>
</head>
<body>
	<h1>Paginated Results</h1>
<h4>Pick a query:</h4>
	<select id="queries" name="queries" onchange="select()">
<option value="">Select a query</option>
<option value="let $ced2ar := collection('CED2AR') for $codebook in $ced2ar/codeBook  where $codebook/dataDscr/var[(starts-with(lower-case(@name), lower-case('a')))] return		<codeBook> { $codebook/docDscr }<dataDscr> {	for $var in $codebook/dataDscr/var where  (starts-with(lower-case($var/@name), lower-case('a')))  return $var } </dataDscr></codeBook>">Test Advanced Search Query</option>
	</select>
	<br />
	<h4>Feel free to edit the corresponding xQuery:</h4>
	<textarea id="queryInput" name="queryInput"
		style="width: 500px; height: 200px; vertical-align: top;"></textarea>
	<br /><br />
	<input id="submit" value="Submit" type="submit" onclick="query('0')" />
	<br /><br />
	<div id="results" style="width: 925px"></div>

	<script type="text/javascript">
		function select() {
			jq(function() {
				jq('#queryInput').html(jq('#queries').val());
			});
		}
		
		function query(currpage) {
			jq(function() {
				// Call a URL and pass two arguments
				// Also pass a call back function
				// See http://api.jquery.com/jQuery.post/
				// See http://api.jquery.com/jQuery.ajax/
				// You might find a warning in Firefox: Warning: Unexpected token in attribute selector: '!' 
				// See http://bugs.jquery.com/ticket/7535
				jq.post("/CED2AR_QueryDemo/paginated", {
					xquery : jq("#queryInput").val(), paginate : 'true', page : currpage
				}, function(data) {
					// data contains the result
					// Assign result span with id "results"
					jq("#results").html(data);
				});
			});
		}
	</script>
</body>
</html>