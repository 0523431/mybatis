<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>core태그 : 조건문 예제</title>
</head>
<body>

<h3>조건문 관련 태그 : if, choose 태그</h3>

<c:if test="${5 < 10}">
	<h4>5는 10보다 작다</h4>
</c:if>

거짓이니까 나오지 h4문장이 출력되지 않음
<c:if test="${6+3 !=9}">
	<h4>6+3은 9가 아니다</h4>
</c:if>

<br>
스크립트릿으로 표현하면,
<%	if(5 <10) { %>
	<h4>5는 10보다 작다</h4>
<%	} %>

<hr>
<h3>choose, if에서 else가 없음. else에서 필요한 태그</h3>
<c:choose>
	<c:when test="${5+10 ==25}">
		<h4>5+10=25</h4>
	</c:when>
	<c:when test="${5+10 ==15}">
		<h4>5+10=15</h4>
	</c:when>
	<c:when test="${5+10 ==510}">
		<h4>5+10=510</h4>
	</c:when>
	<c:otherwise>
		<h4>5+10=모름</h4>
	</c:otherwise>
</c:choose>
</body>
</html>