<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>fmt 태그 : 인코딩</title>
</head>
<body>

<fmt:requestEncoding value="euc-kr" />

<form method="post" name="f">
	이름 :  <input type="text" name="name" value="${param.name}"><br>
	입사일 : <input type="text" name="hiredate" value="${param.hiredate}">yyyy-MM-dd 형태로 입력<br>
	급여 :  <input type="text" name="salary" value="${param.salary}"><br>
		  <input type="submit" value="전송">
</form>

<hr>
이름 : ${param.name}<br>
입사일 : ${param.hiredate}<br>
급여 : ${param.salary}

<hr>
<h3>
	입사일은 yyyy년 MM월 dd일 E요일 형태로 출력 <br>
	급여 세자리마다 , 출력 <br>
	연봉 =급여*12 / 세자리마다 , 출력
</h3>
<c:catch var="formatexception">
	<fmt:parseDate value="${param.hiredate}" var="getDate" pattern="yyyy-MM-dd" />
</c:catch>
<c:if test="${formatexception == null}"> <%-- catch가 null : 잘 입력함 / 예외발생 안됨  --%>
	이름 : ${param.name}<br>
	입사일 :
		<fmt:formatDate value="${getDate}" pattern="yyyy년 MM월 dd일 E요일"/><br>
	급여 :
		<fmt:formatNumber value="${param.salary}" pattern="###,###" /><br>
	연봉 :
		<fmt:formatNumber value="${param.salary *12}" pattern="###,###" var="salary12"/>
		${salary12}
</c:if>
<c:if test="${formatexception !=null}"> <%-- catch가 null이 아니야(var값에 객체가 생김) : 잘 못 입력함  --%>
	<font color="red">입사일은 yyyy-MM-dd 형태로 입력하세요</font>
</c:if>

</body>
</html>