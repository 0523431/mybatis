<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%-- ���� �������� ������Ʈ�� �̸��� �����ϰ� ������ ��
	 ${pageContext.request.contextPath} : /jsp_study2 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title><decorator:title /></title>
<%--
	<decorator:title /> : �ش� �������� title�� �����ְ� ��
--%>
<decorator:head />
<%--
	<decorator:head /> : title�� ������ /head ���ܰ��� ������ �����ͼ� ����
--%>
<link rel="stylesheet" href="${path}/css/main.css">
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js">
<%--
	��� �Խ��ǿ� ����Ʈ �����͸� ���ڴ� !
	version => full / smart / ...
--%>
</script>
</head>
<body>

<table>
	<tr><td colspan="3" align="right">
		������ �������� ���� 2ȸ�� ���α׷� ����
		<span style="float : right;">
			<%--
				loginAction����
			  >	request.getSession().setAttribute("login", id); <
				����� �̸��� login�� session�� value
			--%>
			<c:if test="${empty sessionScope.login}">
				<a href="${path}/model2/member/loginForm.me">[�α���]</a>
				<a href="${path}/model2/member/joinForm.me">[ȸ������]</a>
			</c:if>
			<c:if test="${!empty sessionScope.login}">
				${sessionScope.login} �ݰ����ϴ�^^
				<a href="${path}/model2/member/logout.me">[�α׾ƿ�]</a>
			</c:if>
		</span>
		</td>
	</tr>
	<tr><td width="15%">
			<a href="${path}/model2/member/main.me">[ȸ������]</a><br><br>
			<a href="${path}/model2/board/list.do">[�Խ���]</a><br>
		</td>
		<td colspan="2" style="text-align:left; vertical-align:top">
			<decorator:body />
			<%--
				<decorator:body />
				: <body></body>�κ��� ������ �����ͼ� ������
			--%>
		</td></tr>
	<tr><td colspan="3">�����ī���� Since 2016</td></tr>
</table>

</body>
</html>