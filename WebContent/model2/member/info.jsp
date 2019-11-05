<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 정보 조회</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>

<table> <%-- property 접근 --%>
	<caption>회원 정보 보기</caption>
	<tr><td rowspan="6">
		<img src="picture/${info.picture}" width="150" height="180"></td>
		<th>아이디</th><td>${info.id}</td>
	</tr>
	<tr><th>이름</th><td>${info.name}</td></tr>
	<tr><th>성별</th><td>${info.gender==1? "남자":"여자"}</td></tr>
	<tr><th>전화</th><td>${info.tel}</td></tr>
	<tr><th>이메일</th><td>${info.email}</td></tr>
	<tr><td colspan="2">
		<a href="updateForm.me?id=${info.id}">[수정]</a>
		<a href="main.me">[메인화면]</a>
						
		<%-- admin이 아닌 경우, [탈퇴] 버튼이 생김 (admin 탈퇴 불가) --%>
		<co:if test="${info.id != 'admin' && sessionScope.login !='admin'}">
			<a href="deleteForm.me?id=${info.id}">[탈퇴]</a>
		</co:if>
		
		</td></tr>
</table>

</body>
</html>
