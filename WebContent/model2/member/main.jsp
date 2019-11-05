<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
	1. 로그인 후에 보여지는 페이지
	   => 로그인이 안 된 경우, loginForm.jsp 페이지 이동하기
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원관리</title>
</head>
<body>

	<h3>${sessionScope.login}(으)로 로그인 되었습니다</h3>
	<h3><a href="logout.me">로그아웃</a></h3>
	<h3><a href="info.me?id=${sessionScope.login}">회원정보보기</a></h3>
		<%--
			info.jsp옆에 id라는 파라미터가 붙어감
			info.jsp에 DB로부터 받은 login값=id
		--%>
	<co:if test="${sessionScope.login == 'admin'}"> <%--관리자로 로그인 했다면,--%>
		<h3><a href="list.me">회원목록보기</a></h3>
	</co:if>
		
</body>
</html>