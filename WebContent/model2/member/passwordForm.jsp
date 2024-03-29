<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀 번호 변경</title>
<link rel="stylesheet" href="/jsp_study2/css/main.css">

<script>
	function checkinput(form) {
		if(form.new_pass.value != form.conf_pass.value) {
			alert("변경 비밀번호와 재입력한 비밀번호가 다릅니다");
			form.conf_pass.value =""; // 내용 지워줌
			form.conf_pass.focus(); // 커서 위치 지정
			return false;
		}
		return true;
	}
</script>

</head>
<body>

<form action="password.me" name="f" method="post"
	  onsubmit="return checkinput(this)"> <%--this==form --%>
<input type="hidden" name="id" value='${login}'>
	  
<table>
	<caption>비밀번호 변경</caption>
	<tr><th>현재 비밀번호</th>
		<td><input type="text" name="old_pass"></td></tr> <%-- db랑 검증 --%>
	<tr><th>변경 비밀번호</th>
		<td><input type="text" name="new_pass"></td></tr>
	<tr><th>변경 비밀번호 재입력</th>
		<td><input type="text" name="conf_pass"></td></tr>
	<tr><td colspan="2"><input type="submit" value="비밀번호 변경"></td></tr>
</table>
</form>

</body>
</html>