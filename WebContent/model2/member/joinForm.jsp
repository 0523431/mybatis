<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>

<head>

<meta charset="EUC-KR">
<title>ȸ�� ����</title>
<link rel="stylesheet" href="/jsp_study2/css/main.css">

<script type="text/javascript">
	function win_upload() {
		var op = "width=600, height=200,munubar=no,top=200,left=200";
		open("pictureForm.me","window`s name",op);
	}
	
	function inputcheck() {
		f = document.f;
		if(f.id.value =="") {
			alert("���̵� �Է��ϼ���");
			f.id.focus();
			return;
		}
		if(f.pass.value =="") {
			alert("��й�ȣ�� �Է��ϼ���");
			f.pass.focus();
			return;
		}
		if(f.name.value =="") {
			alert("�̸��� �Է��ϼ���");
			f.name.focus();
			return;
		}
		if(f.gender.value =="") {
			alert("������ �����ϼ���");
			f.gender.focus();
			return;
		}
		if(f.email.value =="") {
			alert("�̸����� �Է��ϼ���");
			f.email.focus();
			return;
		}
		if(f.tel.value =="") {
			alert("��ȭ��ȣ�� �Է��ϼ���");
			f.tel.focus();
			return;
		}
		if(f.picture.value =="") {
			alert("������ ����ϼ���");
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
				<a href="javascript:win_upload()">�������</a>
			</font>
			</td>
			<th>���̵�</th>
			<td><input type="text" name="id"></td>
		</tr>
		<tr><th>��й�ȣ</th>
			<td><input type="password" name="pass"></td>
		</tr>
		<tr><th>�̸�</th>
			<td><input type="text" name="name"></td>
		</tr>
		<tr><th>����</th>
			<td><input type="radio" name="gender" value="1" checked>��
				<input type="radio" name="gender" value="2">��</td>
		</tr>
		<tr><th>��ȭ��ȣ</th>
			<td colspan="2"><input type="text" name="tel"></td>
		</tr>
		<tr><th>�̸���</th>
			<td colspan="2"><input type="text" name="email"></td>
		</tr>
		<tr><td colspan="3">
			<!-- <input type="submit" value="ȸ������"> -->
			<input type="button" value="ȸ������" onclick="inputcheck()">
			</td></tr>
	</table>
</form>

</body>

</html>