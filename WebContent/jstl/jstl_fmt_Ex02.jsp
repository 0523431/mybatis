<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>형식관련 태그 예제2</title>
</head>
<body>

<h1>
형식화  tag<br>
format : 원본 ▷ 문자열<br>
parse : 문자열 ▷ 원본
</h1>

<hr>
<h3>Format된 숫자를 일반 숫자로 변경</h3>
<fmt:parseNumber value="20,000" var="num1" pattern="##,###" />
<fmt:parseNumber value="10,000" var="num2" pattern="##,###" />
합 : ${num1 + num2}<br>
합 : <fmt:formatNumber value="${num1+num2}" pattern="##,###" /><br>
합 : <fmt:formatNumber value="${num1+num2}" pattern="##,###" var="num3"/>
	${num3} <%-- num3은 문자열 --%>
<hr>
<h3>Format된 날짜를 일반 날짜로 변경</h3>
<fmt:parseDate value="2019-10-31 12:00:00" var="day" pattern="yyyy-MM-dd HH:mm:ss" />
날짜 : ${day}

<h3>2019-10-30의 요일 출력하기</h3>
<fmt:formatDate value="${day}" pattern="yyyy-MM-dd E요일" />
<%-- 원본으로 만든 정보를 다시 내 입맛에 맞게 형식화(pattern) --%>

</body>
</html>