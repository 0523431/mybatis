<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>

<head>

<meta charset="EUC-KR">
<title>회원 가입</title>
<link rel="stylesheet" href="/jsp_study2/css/main.css">

<script type="text/javascript">
	function win_upload() {
		var op = "width=600, height=200,munubar=no,top=200,left=200";
		open("pictureForm.me","window`s name",op);
	}
	
	function inputcheck() {
		f = document.f;
		if(f.id.value =="") {
			alert("아이디를 입력하세요");
			f.id.focus();
			return;
		}
		if(f.pass.value =="") {
			alert("비밀번호를 입력하세요");
			f.pass.focus();
			return;
		}
		if(f.name.value =="") {
			alert("이름을 입력하세요");
			f.name.focus();
			return;
		}
		if(f.gender.value =="") {
			alert("성별을 선택하세요");
			f.gender.focus();
			return;
		}
		if(f.email.value =="") {
			alert("이메일을 입력하세요");
			f.email.focus();
			return;
		}
		if(f.tel.value =="") {
			alert("전화번호를 입력하세요");
			f.tel.focus();
			return;
		}
		if(f.picture.value =="") {
			alert("사진을 등록하세요");
			f.picture.focus();
			return;
		}
		f.submit();
	}
	
</script>

</head>

<body>

<form action="join.me" name="f" method="post"> <!-- onsubmit="inputcheck()" -->
	<input type="hidden" name="picture" value="">
	<table>
		<tr><td rowspan="4" valign="bottom">
			<img src="" width="100" height="120" id="pic"><br>
			<font size="1">
				<a href="javascript:win_upload()">사진등록</a>
			</font>
			</td>
			<th>아이디</th>
			<td><input type="text" name="id"></td>
		</tr>
		<tr><th>비밀번호</th>
			<td><input type="password" name="pass"></td>
		</tr>
		<tr><th>이름</th>
			<td><input type="text" name="name"></td>
		</tr>
		<tr><th>성별</th>
			<td><input type="radio" name="gender" value="1" checked>남
				<input type="radio" name="gender" value="2">여</td>
		</tr>
		<tr><th>전화번호</th>
			<td colspan="2"><input type="text" name="tel"></td>
		</tr>
		<tr><th>이메일</th>
			<td colspan="2"><input type="text" name="email"></td>
		</tr>
		<tr><td colspan="3">
			<!-- <input type="submit" value="회원가입"> -->
			<input type="button" value="회원가입" onclick="inputcheck()">
			</td></tr>
	</table>
</form>

</body>

</html>