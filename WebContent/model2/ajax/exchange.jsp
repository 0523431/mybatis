<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 
	list : 환율코드 / 환율값
	list2 : 국가이름
	today : 현재 시간
	==> 정보가 전달됨 (정보를 전달 받음)
-->

<h4>
	<fmt:formatDate value="${today}" pattern="yyyy-MM-dd HH:mm"/>
	현재
</h4>
<table class="w3-table-all">
	<tr><td colspan="3" class="w3-center">
			${list2[0]}:${list[0]}
		</td>
	</tr>
	<tr><th>기준율</th><th>받을때</th><th>보낼때</th>
	<tr><td>${list[3]}</td>
		<td>${list[1]}</td>
		<td>${list[2]}</td>
	</tr>
	<tr><td colspan="3" class="w3-center">
			${list2[1]}:${list[7]}
		</td>
	</tr>
	<tr><th>기준율</th><th>받을때</th><th>보낼때</th>
	<tr><td>${list[10]}</td>
		<td>${list[8]}</td>
		<td>${list[9]}</td>
	</tr>
</table>