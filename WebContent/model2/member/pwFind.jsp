<%@page import="model.Member"%>
<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀번호 찾기</title>

<script type="text/javascript">
	function closePass() {
		opener.document.f.pass.value = ""; // 전달안함
		opener.document.f.pass.focus();
		self.close();
	}
</script>

</head>

<body>
<form name="f">
 <h3 id="passcut">비밀번호 **${pass}</h3>
 <input type="button" value="닫기" onclick="closePass()">
</form>

</body>
</html>
