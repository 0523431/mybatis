<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<% request.setCharacterEncoding("euc-kr"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title></title>
</head>
<body>
<%
	session.setAttribute("today", new Date());
%>

이름 : ${param.name }<br>
나이 : ${param.age }<br>
성별 : ${param.gender==1? "남":"여" }<br>
출생년도 : ${param.year }<br>
만나이 : ${2019 - param.year}
</body>
</html>