<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 
	list : ȯ���ڵ� / ȯ����
	list2 : �����̸�
	today : ���� �ð�
	==> ������ ���޵� (������ ���� ����)
-->

<h4>
	<fmt:formatDate value="${today}" pattern="yyyy-MM-dd HH:mm"/>
	����
</h4>
<c:forEach var="m" items="${map}">
<table class="w3-table-all">
	<tr><td colspan="3" class="w3-center">
			${m.key}:${m.value[0]}
		</td>
	</tr>
	<tr><th>������</th><th>������</th><th>������</th>
	<tr><td>${m.value[3]}</td>
		<td>${m.value[1]}</td>
		<td>${m.value[2]}</td>
	</tr>
</table>
</c:forEach>
