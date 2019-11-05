<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
	tag library
		- prefix : c =>접두어
		- uri : 인터넷으로 가져오는게 아니라
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSTL core 태그 예제 : taglib 지시어를 표시해야 한다</title>
</head>
<body>

<h3>속성 설정 태그 : set, remove, out 태그</h3>
<br>
스크립트릿으로 표현하면,<br>
<% session.setAttribute("test", "Hello JSTL"); %>
<c:set var="test" value="${'Hello JSTL'}" scope="session" />

<br>
아래 두 결과는 동일하지만, c:out => 보안에 더 치중한 타입
test 속성 : ${sessionScope.test}<br>
test 속성 : <c:out value="${test}" /><br>

<c:remove var="test" />
test 속성 : ${test}<br>

</body>
</html>