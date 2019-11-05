<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>MODEL2 연습</title>
</head>
<body>

<form action="add.me" method="post">
	<input type="text" name="num1" value="${param.num1}">
	+
	<input type="text" name="num2" value="${param.num2}">
	<input type="submit" value="=">
	<input type="text" name="result" value="${result}"> <%-- result : 속성값 --%>
</form>

<%--
	요청이 들어가는 곳 : add.me
	그 요청을 acton.properties에서 요청하고
	
--%>

</body>
</html>