<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- super helpful: 
http://krams915.blogspot.com/2011/01/spring-mvc-3-and-jquery-integration.html
http://duckranger.com/2011/07/spring-mvc-3-0-with-sts-tutorial-part-i/
http://docs.oracle.com/javaee/5/tutorial/doc/bnakc.html
 -->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript"
	src="<c:url value="/resources/js/jquery/jquery-1.4.4.min.js" />"></script>
<link href="<c:url value="/resources/css/objects.css" />"
	rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript">
     var jq = jQuery.noConflict();
 </script>

<title>CED2AR Query Demo</title>
</head>
<body>
	<h1>CED2AR Query Demo</h1>
<h4>Pick a query:</h4>
	<select id="queries" name="queries" onchange="select()">
<option value="">Select a query</option>
<option value="let $ced2ar := collection('CED2AR') for $codebook in $ced2ar/codeBook  where $codebook/dataDscr/var[(starts-with(lower-case(@name), lower-case('a')))] return		<codeBook> { $codebook/docDscr }<dataDscr> {	for $var in $codebook/dataDscr/var where  (starts-with(lower-case($var/@name), lower-case('a')))  return $var } </dataDscr></codeBook>">Test Advanced Search Query</option>
<option value="<codeBooks> { for $cedar in  collection('CED2AR') return <codeBook><docDscr>  <citation>   <titlStmt> <titl>  { $cedar/codeBook/docDscr/citation/titlStmt/titl } </titl></titlStmt></citation></docDscr><dataDscr> { $cedar/codeBook/dataDscr/var[position() <= 10]  }</dataDscr></codeBook> } </codeBooks>">First 10 variables across all data sources</option>
<option value="<codeBooks> { for $cedar in  collection('CED2AR') where ($cedar/codeBook/dataDscr/var[ends-with(labl, 'War')]) return <codeBook><docDscr>  <citation>   <titlStmt> <titl>  { $cedar/codeBook/docDscr/citation/titlStmt/titl } </titl></titlStmt></citation></docDscr><dataDscr> { $cedar/codeBook/dataDscr/var[ends-with(labl, 'War')]  }</dataDscr></codeBook> } </codeBooks>">All variables with labels ending with: 'War'</option>
<option value="<codeBooks> { for $cedar in  collection('CED2AR') where ($cedar/codeBook/dataDscr/var[@conf='true']) return <codeBook><docDscr>  <citation>   <titlStmt> <titl>  { $cedar/codeBook/docDscr/citation/titlStmt/titl } </titl></titlStmt></citation></docDscr><dataDscr> { $cedar/codeBook/dataDscr/var[@conf='true']  }</dataDscr></codeBook> } </codeBooks>">All confidential variables </option>
<option value="<codeBooks> { for $cedar in  collection('CED2AR') where ($cedar/codeBook/dataDscr/var[@name='totfam_kids' or @name='mh1']) return <codeBook><docDscr>  <citation>   <titlStmt> <titl>  { $cedar/codeBook/docDscr/citation/titlStmt/titl } </titl></titlStmt></citation></docDscr><dataDscr> { $cedar/codeBook/dataDscr/var[@name='totfam_kids' or @name='mh1']  }</dataDscr></codeBook> } </codeBooks>">All confidential variables including public versions </option>
<option value="<codeBooks> { for $cedar in  collection('CED2AR') where ($cedar/codeBook/dataDscr/var[contains(txt, 'household')]) return <codeBook><docDscr>  <citation>   <titlStmt> <titl>  { $cedar/codeBook/docDscr/citation/titlStmt/titl } </titl></titlStmt></citation></docDscr><dataDscr> { $cedar/codeBook/dataDscr/var[contains(txt, 'household')]  }</dataDscr></codeBook> } </codeBooks>">All variables with text containing: 'household'</option>
<option value="for $ced2ar in collection('CED2AR') /codeBook/docDscr/citation/titlStmt/titl return $ced2ar">The titles of all data sources</option>
<option value="<codeBooks> { for $cedar in  collection('CED2AR') where ($cedar/codeBook/docDscr/citation/titlStmt/titl = 'Codebook for an IPUMS-USA') return <codeBook><docDscr>  <citation>   <titlStmt> <titl>  { $cedar/codeBook/docDscr/citation/titlStmt/titl } </titl></titlStmt></citation></docDscr><dataDscr> { $cedar/codeBook/dataDscr/var[position() <= 100]  }</dataDscr></codeBook> } </codeBooks>">First 100 variables from IPUMS</option>
<option value="<codeBooks> { for $cedar in  collection('CED2AR') where ($cedar/codeBook/docDscr/citation/titlStmt/titl = 'SSB Codebook') return <codeBook><docDscr>  <citation>   <titlStmt> <titl>  { $cedar/codeBook/docDscr/citation/titlStmt/titl } </titl></titlStmt></citation></docDscr><dataDscr> { $cedar/codeBook/dataDscr/var[position() <= 100]  }</dataDscr></codeBook> } </codeBooks>">First 100 variables from SSB</option>
<option value="<codeBooks> { for $cedar in  collection('CED2AR') where ($cedar/codeBook/docDscr/citation/titlStmt/titl = 'ACS 2009 G') return <codeBook><docDscr>  <citation>   <titlStmt> <titl>  { $cedar/codeBook/docDscr/citation/titlStmt/titl } </titl></titlStmt></citation></docDscr><dataDscr> { $cedar/codeBook/dataDscr/var[position() <= 100]  }</dataDscr></codeBook> } </codeBooks>">First 100 variables from ACS 2009g</option>
<option value="<codeBooks> { for $cedar in  collection('CED2AR') where ($cedar/codeBook/docDscr/citation/titlStmt/titl = 'ACS 2009 H') return <codeBook><docDscr>  <citation>   <titlStmt> <titl>  { $cedar/codeBook/docDscr/citation/titlStmt/titl } </titl></titlStmt></citation></docDscr><dataDscr> { $cedar/codeBook/dataDscr/var[position() <= 100]  }</dataDscr></codeBook> } </codeBooks>">First 100 variables from ACS 2009h</option>
<option value="<codeBooks> { for $cedar in  collection('CED2AR') where ($cedar/codeBook/docDscr/citation/titlStmt/titl = 'ACS 2009 P') return <codeBook><docDscr>  <citation>   <titlStmt> <titl>  { $cedar/codeBook/docDscr/citation/titlStmt/titl } </titl></titlStmt></citation></docDscr><dataDscr> { $cedar/codeBook/dataDscr/var[position() <= 100]  }</dataDscr></codeBook> } </codeBooks>">First 100 variables from ACS 2009p</option>
<option value="<codeBooks> { for $cedar in  collection('CED2AR') where ($cedar/codeBook/docDscr/citation/titlStmt/titl = 'ACS 2009 T') return <codeBook><docDscr>  <citation>   <titlStmt> <titl>  { $cedar/codeBook/docDscr/citation/titlStmt/titl } </titl></titlStmt></citation></docDscr><dataDscr> { $cedar/codeBook/dataDscr/var[position() <= 100]  }</dataDscr></codeBook> } </codeBooks>">First 100 variables from ACS 2009t</option>
<option value="<codeBooks> { for $ced2ar in collection('CED2AR')  return <codeBook>{ $ced2ar/codeBook/docDscr } </codeBook> } </codeBooks>">The document description from each data source</option>
<option value="<codeBooks> { for $ced2ar in collection('CED2AR')  return <codeBook>{ $ced2ar/codeBook/stdyDscr } </codeBook> } </codeBooks>">The study description from each data source</option>
<option value="<codeBooks> { for $ced2ar in collection('CED2AR')  return <codeBook>{ $ced2ar/codeBook/fileDscr } </codeBook> } </codeBooks>">The file description from each data source</option>
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
				jq.post("/CED2AR_QueryDemo/query", {
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