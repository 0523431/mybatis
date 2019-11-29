<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 
	list : 환율코드 / 환율값
	list2 : 국가이름
	today : 현재 시간
	==> 정보가 전달됨 (정보를 전달 받음)

	==> 이 뷰단에는 map객체 2개와 today속성이 들어와 있음
-->

<table class="w3-table-all">
	<caption>
		<fmt:formatDate value="${today}" pattern="yyyy-MM-dd HH:mm"/>
		현재
	</caption>
	
	<tr><th class="w3-center">통화</th>
		<th>기준율</th>
		<th>받을 때</th>
		<th>보낼 때</th>
	</tr>
	<c:forEach var="m" items="${map}">
	<tr><td>${m.key}<br>${m.value[0]}</td>
		<td>${m.value[3]}</td>
		<td>${m.value[1]}</td>
		<td>${m.value[2]}</td>
	</tr>
	</c:forEach>
</table>
