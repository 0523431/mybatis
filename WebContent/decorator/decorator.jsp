<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%-- 실제 실행중인 프로젝트의 이름을 간단하게 가져온 것
	 ${pageContext.request.contextPath} : /jsp_study2 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title><decorator:title /></title>
<%--
	<decorator:title /> : 해당 페이지의 title를 보여주게 됨
--%>
<decorator:head />
<%--
	<decorator:head /> : title을 제외한 /head 전단계의 내용을 가져와서 실행
--%>
<link rel="stylesheet" href="${path}/css/main.css">
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js">
<%--
	모든 게시판에 스마트 에디터를 쓰겠다 !
	version => full / smart / ...
--%>
</script>
</head>
<body>

<table>
	<tr><td colspan="3" align="right">
		디지털 컨버전스 과정 2회차 프로그램 연습
		<span style="float : right;">
			<%--
				loginAction에서
			  >	request.getSession().setAttribute("login", id); <
				등록한 이름이 login인 session의 value
			--%>
			<c:if test="${empty sessionScope.login}">
				<a href="${path}/model2/member/loginForm.me">[로그인]</a>
				<a href="${path}/model2/member/joinForm.me">[회원가입]</a>
			</c:if>
			<c:if test="${!empty sessionScope.login}">
				${sessionScope.login} 반갑습니다^^
				<a href="${path}/model2/member/logout.me">[로그아웃]</a>
			</c:if>
		</span>
		</td>
	</tr>
	<tr><td width="15%">
			<a href="${path}/model2/member/main.me">[회원관리]</a><br><br>
			<a href="${path}/model2/board/list.do">[게시판]</a><br>
		</td>
		<td colspan="2" style="text-align:left; vertical-align:top">
			<decorator:body />
			<%--
				<decorator:body />
				: <body></body>부분의 내용을 가져와서 보여줌
			--%>
		</td></tr>
	<tr><td colspan="3">구디아카데미 Since 2016</td></tr>
</table>

</body>
</html>