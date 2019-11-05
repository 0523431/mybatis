<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>core�±� : ���ǹ� ����</title>
</head>
<body>

<h3>���ǹ� ���� �±� : if, choose �±�</h3>

<c:if test="${5 < 10}">
	<h4>5�� 10���� �۴�</h4>
</c:if>

�����̴ϱ� ������ h4������ ��µ��� ����
<c:if test="${6+3 !=9}">
	<h4>6+3�� 9�� �ƴϴ�</h4>
</c:if>

<br>
��ũ��Ʈ������ ǥ���ϸ�,
<%	if(5 <10) { %>
	<h4>5�� 10���� �۴�</h4>
<%	} %>

<hr>
<h3>choose, if���� else�� ����. else���� �ʿ��� �±�</h3>
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
		<h4>5+10=��</h4>
	</c:otherwise>
</c:choose>
</body>
</html>