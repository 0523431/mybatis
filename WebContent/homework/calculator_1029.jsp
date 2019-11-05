<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSTL을 이용한 사칙연산</title>
</head>
<body>

<form name="f" method="post">
	<table>
		<tr><td style=text-align:center;>x</td>
			<td></td>
			<td style=text-align:center;>y</td>
			<td></td></tr>
		<tr><td><input type="text" name="x" value="${param.x}"></td>
			<td><select name="calc">
					<option ${param.calc =='+'? 'selected':''}>+</option>
					<option ${param.calc =='-'? 'selected':''}>-</option>
					<option ${param.calc =='*'? 'selected':''}>*</option>
					<option ${param.calc =='/'? 'selected':''}>/</option>
				</select></td>
				
				<script>
					var option = ${param.calc}
					if(option=='') {
						option = '+';
					} else document.f.
				</script>
				
			<td><input type="text" name="y" value="${param.y}"></td>
			<td><input type="submit" value="=">
	</table>
</form>

<h3>
	<c:out value="${param.x}${param.calc}${param.y} =" />
	
	<c:choose>
		<c:when test="${param.calc == '+' }">
			<c:out value="${param.x + param.y }" />
		</c:when>
		<c:when test="${param.calc == '-' }">
			<c:out value="${param.x - param.y }" />
		</c:when>
		<c:when test="${param.calc == '*' }">
			<c:out value="${param.x * param.y }" />
		</c:when>
		<c:when test="${param.calc == '/' }">
			<c:out value="${param.x / param.y }" />
		</c:when>
	</c:choose>
</h3>

</body>
</html>