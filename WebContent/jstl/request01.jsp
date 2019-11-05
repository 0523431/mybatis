<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>전송된 파라미터 정보</title>
</head>
<body>

<fmt:requestEncoding value="euc-kr" />

이름 : ${param.name}<br>
나이 : ${param.age}<br>
성별 : ${param.gender==1? "남":"여"}<br>
취미 : ${param.hobby}<br>
출생년도 : ${param.year}<br>

<h3>취미 정보 모두 조회하기</h3>
취미 : 
<c:forEach var="hob" items="${paramValues.hobby}">
	${hob}
</c:forEach>
<br>
${paramValues.hobby}가 배열의 형태로 저장됨.
${paramValues.hobby[0]}

<hr>
<h3>모든 파라미터 정보 조회하기(hidden포함)</h3>
<table>
	<tr><th>파라미터이름</th><th>파라미터 값</th></tr>
	<c:forEach var="p" items="${paramValues}">
		<tr><td>${p.key}</td>
			<td>
			<c:forEach var="v" items="${p.value}">
				${v}&nbsp;&nbsp;&nbsp;&nbsp;
			</c:forEach>
			</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>