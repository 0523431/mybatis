<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ����</title>
<link rel="stylesheet" href="/jsp_study2/css/main.css">

<script type="text/javascript">
	function win_upload() {
		var op = "width=600, height=200,munubar=no,top=200,left=200";
		open("pictureForm.me","window`s name",op);
	}
	
	// pass�� �Է��� �ȵǾ������� submit�� ������� �ʾ�
	function inputcheck(check) {
		<co:if test="${sessionScope.login != 'admin'}">
			// ����� java����
			if(check.pass.value == "") {
				alert("��й�ȣ�� �Է��ϼ���");
				check.pass.focus();
				return false;
			}
		</co:if>
	}
	
	function win_modify() {
		var op = "width=500, height=250, munubar=no, top=300, left=400";
		open("passwordForm.me","",op);
		// ������ submit()�� ������� f.submit()?
	}
</script>

</head>
<body>

<form action="update.me" name="f" method="post" onsubmit="return inputcheck(this)">
	<input type="hidden" name="picture" value="${info.picture}">

	<table>
		<caption>ȸ�� ���� ����</caption>
		<tr><td rowspan="4" valign="bottom">
			<img src="picture/${info.picture}" width="100" height="120" id="pic"><br>
			<%--picture/ �� �ڿ� �ּҸ� �ٿ��ְ� �Ǵ� �� --%>
			<font size ="1"><a href="javascript:win_upload()">��������</a></font></td>
			<th>���̵�</th><td><input type="text" name="id" readonly value="${info.id}"></td></tr>
													  <%--readonly : ������ �� ���� --%>
		<tr><th>��й�ȣ</th><td><input type="password" name="pass"></td></tr>
		<tr><th>�̸�</th><td><input type="text" name="name" value="${info.name}"></td></tr>
		<tr><th>����</th><td><input type="radio" name="gender" value="1" ${info.gender==1? "checked":""}>��
							<input type="radio" name="gender" value="2" ${info.gender==2? "checked":""}>��</td></tr>
		<tr><th>��ȭ��ȣ</th><td colspan="2"><input type="text" name="tel" value="${info.tel}"></td></tr>
		<tr><th>�̸���</th><td colspan="2"><input type="text" name="email" value="${info.email}"></td></tr>
		<tr><td colspan="3">
			<input type="submit" value="ȸ������">
			<co:if test="${sessionScope.login != 'admin' || sessionScope.login == param.id}">
				<input type="button" value="��й�ȣ����" onclick="win_modify()">
			</co:if></td></tr>
	</table>
</form>

</body>
</html>