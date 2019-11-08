<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>정보 수정</title>
<link rel="stylesheet" href="/jsp_study2/css/main.css">

<script type="text/javascript">
	function win_upload() {
		var op = "width=600, height=300,munubar=no,top=200,left=200";
		open("pictureForm.me","window`s name",op);
	}
	
	// pass가 입력이 안되어있으면 submit이 실행되지 않아
	function inputcheck(check) {
		<co:if test="${sessionScope.login != 'admin'}">
			// 여기는 java영역
			if(check.pass.value == "") {
				alert("비밀번호를 입력하세요");
				check.pass.focus();
				return false;
			}
		</co:if>
	}
	
	function win_modify() {
		var op = "width=500, height=350, munubar=no, top=300, left=400";
		open("passwordForm.me","",op);
		// 강제로 submit()을 해줘야해 f.submit()?
	}
</script>

</head>
<body>

<form action="update.me" name="f" method="post" onsubmit="return inputcheck(this)">
	<input type="hidden" name="picture" value="${info.picture}">

	<table>
		<caption>회원 정보 수정</caption>
		<tr><td rowspan="4" valign="bottom">
			<img src="picture/${info.picture}" width="100" height="120" id="pic"><br>
			<%--picture/ 이 뒤에 주소를 붙여주게 되는 거 --%>
			<font size ="1"><a href="javascript:win_upload()">사진수정</a></font></td>
			<th>아이디</th><td><input type="text" name="id" readonly value="${info.id}"></td></tr>
													  <%--readonly : 수정할 수 없음 --%>
		<tr><th>비밀번호</th><td><input type="password" name="pass"></td></tr>
		<tr><th>이름</th><td><input type="text" name="name" value="${info.name}"></td></tr>
		<tr><th>성별</th><td><input type="radio" name="gender" value="1" ${info.gender==1? "checked":""}>남
							<input type="radio" name="gender" value="2" ${info.gender==2? "checked":""}>여</td></tr>
		<tr><th>전화번호</th><td colspan="2"><input type="text" name="tel" value="${info.tel}"></td></tr>
		<tr><th>이메일</th><td colspan="2"><input type="text" name="email" value="${info.email}"></td></tr>
		<tr><td colspan="3">
			<input type="submit" value="회원수정">
			<co:if test="${sessionScope.login != 'admin' || sessionScope.login == param.id}">
				<input type="button" value="비밀번호수정" onclick="win_modify()">
			</co:if></td></tr>
	</table>
</form>

</body>
</html>
