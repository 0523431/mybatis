<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խ��� �۾���</title>
<link rel="stylesheet" href="../../css/main.css">

<script type="text/javascript">
	function inputcheck() {
		ff = document.f;
		if(ff.name.value=="") {
			alert("�۾��̸� �Է��ϼ���");
			ff.name.focus();
			return;
		}
		if(ff.pass.value=="") {
			alert("��й�ȣ�� �Է��ϼ���0");
			ff.pass.focus();
			return;
		}
		if(ff.title.value=="") {
			alert("������ �Է��ϼ���");
			ff.title.focus();
			return;
		}
		/* if(ff.content.value=="") {
			alert("������ �Է��ϼ���");
			ff.content.focus();
			return;
		} */
		ff.submit(); // write.jsp�� �̵�
	}
</script>

</head>
<body>

<form action="write.do" method="post" enctype="multipart/form-data" name="f">
	
	<table>
		<caption>�Խ��� �۾���</caption>
		<tr><th>�۾���</th>
			<td><input type="text" name="name"></td></tr>
		<tr><th>��й�ȣ</th>
			<td><input type="password" name="pass"></td></tr>
		<tr><th>����</th>
			<td><input type="text" name="title"></td></tr>
		
		<tr><th>����</th>
			<td><textarea rows="15" name="content" id="content1"></textarea></td></tr>
			<script>
				<%-- �� ����� ���� ���뿡 �̹����� �ø� �� ����
					  �̹��� ���ε�� url : filebrowserImageUploadUrl => ���ε� ���� �������
					  
					 imgupload.do : ���ε带 ���� url�� ��������
					 
					 -------------------------------------
					 ���ε� �ǿ��� �̹��� �����ϰ� ���ε� ��ư�� ������ CKEDITOR�� imgupload.do�� �����Ŵ
					 �׷��� method.properties���� imgupload �޼���� ���� ��Ű��
				--%>
				CKEDITOR.replace("content1", {filebrowserImageUploadUrl : "imgupload.do"});
			</script>
		
		<tr><th>÷������</th>
			<td><input type="file" name="file1"></td></tr>
		<tr><td colspan="2">
			<a href="javascript:inputcheck()">[�Խù����]</a></td></tr>
	</table>
</form>

</body>
</html>