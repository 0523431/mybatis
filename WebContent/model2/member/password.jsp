<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	<co:choose>
		<co:when test="${opener}"> // test값이 true인경우, ↓↓↓ 실행됨
			alert("${msg}")
			opener.location.href="${url}"
		</co:when>
		<co:otherwise> // 값이 false인 경우
			alert("${msg}")
			location.href="${url}"
		</co:otherwise>
	</co:choose>
	
	<co:if test="${closer}"> // closer가 true인 경우, 실행
		self.close();
	</co:if>
</script>