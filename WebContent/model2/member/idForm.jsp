<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>아이디 찾기</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>

<form action="idFind.me" name="f" method="post">
	
	<table>
		<caption>아이디찾기</caption>
		<tr><th>이메일</th>
			<td><input type="text" name="email"></td></tr>
		<tr><th>전화번호</th>
			<td><input type="text" name="tel"></td></tr>
		<tr><td colspan="2"><input type="submit" value="아이디찾기"></td></tr>
	</table>
</form>

</body>
</html>