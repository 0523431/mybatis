<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSTL 형식화 태그 예제</title>
</head>
<body>

<h1>
형식화 태그<br>
format : 원본 ▷ 문자열<br>
parse : 문자열 ▷ 원본
</h1>

<hr>
<h3>숫자 관련 형식 지정하기</h3>
<fmt:formatNumber value="5000000" type="currency" currencySymbol="￦" /><br>
<fmt:formatNumber value="0.15" type="percent" /><br>
<fmt:formatNumber value="500000000000.366" pattern="###,###.00" /><br>
									  <%-- pattern : 반올림가능 --%>
fmt:setLocale : 지역 설정(브라우저의 해더에 디폴트 국가가 설정되어있음)<br>
<fmt:setLocale value="en_US" />
<fmt:formatNumber value="500000" type="currency" /><br>
<fmt:setLocale value="ko_KR" />
<fmt:formatNumber value="500000" type="currency" currencySymbol="￦" /><br><br>

<hr>
<h3>날짜 관련 형식 지정하기</h3>
<%-- <jsp:useBean id="today" class="java.util.Date" /> --%>
<c:set var="today" value="<%=new java.util.Date() %>" />
${today}<br>
년월일 : <fmt:formatDate value="${today}" type="date" /><br>
시분초 : <fmt:formatDate value="${today}" type="time" /><br>
일시 	: <fmt:formatDate value="${today}" type="both" /><br>
형식지정 : <fmt:formatDate value="${today}" pattern="yyyy-MM-dd HH:mm:ss a E요일" /><br>

일시1 : <fmt:formatDate value="${today}" type="both" timeStyle="short" dateStyle="short" /><br>
일시2 : <fmt:formatDate value="${today}" type="both" timeStyle="long" dateStyle="long" /><br>
일시3 : <fmt:formatDate value="${today}" type="both" timeStyle="full" dateStyle="full" /><br>
일시4 : <fmt:formatDate value="${today}" type="both" timeStyle="full" dateStyle="full" timeZone="GMT"/><br>

</body>
</html>