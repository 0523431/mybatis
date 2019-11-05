<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
	1. 로그아웃상태 : 로그인이 필요합니다. 메시처 출력
				  loginForm.jsp페이지로 이동
	2. 로그인 상태
	   - 일반 사용자 : '관리자만 가능한 거리입니다' 메시지 출력
	   - 관리자 : 정상적인 거래 가능
	3. DB에서 모든 회원 정보를 조회하여, LIST<Member> 객체로 리턴
	   List<Member> list - new MemberDao().list();
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 목록 보기</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>

<table>
	<caption>회원 목록</caption>
	<tr><th>아이디</th><th>이름</th><th>성별</th><th>전화</th><th>이메일</th><th>&nbsp;</th></tr>
	
		<co:forEach var="m" items="${list}">
			<tr><td><a href="info.me?id=${m.id}">${m.id}</a></td>
				<td>${m.name}</td>
				<td>${m.gender==1? "남자":"여자"}</td>
				<td>${m.tel}</td>
				<td>${m.email}</td>
				<td><a href="updateForm.me?id=${m.id}">[수정]</a>
					<co:if test="${m.id != 'admin'}">
						<a href="delete.me?id=${m.id}">[강제탈퇴]</a>
					</co:if>
					</td>
			</tr>
		</co:forEach>
</table>

</body>
</html>