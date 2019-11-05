<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%--
	1. 파일업로드			: java 영역
	2. opener 화면에 결과	: javaScript 영역 ==> 여기서 하는 기능
	3. 현재화면 close()		: javaScript 영역 ==> 여기서 하는 기능
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%  // 1. 파일 업로드 = java 영역 =========> PictureAction.java가 할거야	%>

<script type="text/javascript">
	img = opener.document.getElementById("pic");
	img.src = "picture/${fname}"; // fname이라는 속성이 필요해(PictureAction에서 만들거야)
	
	opener.document.f.picture.value="${fname}";
	self.close();
</script>

</body>
</html>