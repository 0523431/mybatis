<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խù� ���� ȭ��</title>
<link rel="stylesheet" href="../../css/main.css">

<script type="text/javascript">
	function file_delete() { // ÷�������� ������, �����ϴ� �޼���
		document.f.file2.value =""; // hidden���� ���ؼ� db�� ������ ���� (file�� db���踦 ����)
		file_desc.style.display ="none"; // display="none" ===> �������ʰ� ����
	}
</script>

</head>
<body>

<form action="update.do" name="f" method="post" enctype="multipart/form-data">
	<input type="hidden" name="num" value="${info.num}"> <%-- �̰� �޾ƾ� update.do�� �� �� �־� --%>
	<input type="hidden" name="file2" value="${info.file1}">
									  <%--   ${info.file1==null? "":info.file1}
									  		  �̷��� ���� �ʾƵ�, el�� null�ΰ��� �������� �ʾƼ� ������
									  --%>
	<table>
		<caption>�Խñ� ���� ȭ��</caption>
		<tr><th>�۾���</th>
			<td><input type="text" name="name" value="${info.name}"></td></tr>
		<tr><th>��й�ȣ</th>
			<td><input type="password" name="pass"></td></tr>
		<tr><th>����</th>
			<td><input type="text" name="title" value="${info.title}"></td></tr>
		<tr><th>����</th>
			<td><textarea rows="15" name="content" id="content1">${info.content}</textarea></td></tr>
			<script>
				<%-- <id�� �����������>
				
					  �� ����� ���� ���뿡 �̹����� �ø� �� ����
					  �̹��� ���ε�� url : filebrowserImageUploadUrl => ���ε� ���� �������
					  
					 imgupload.do : ���ε带 ���� url�� ��������
					 
					 -------------------------------------
					 ���ε� �ǿ��� �̹��� �����ϰ� ���ε� ��ư�� ������ CKEDITOR�� imgupload.do�� �����Ŵ
					 �׷��� method.properties���� imgupload �޼���� ���� ��Ű��
				--%>
				CKEDITOR.replace("content1", {filebrowserImageUploadUrl : "imgupload.do"});
			</script>
		<tr><td>÷������</td>
			<td style="text-align : left">
				<c:if test="${!empty info.file1}">
					<div id="file_desc">
						${info.file1}
						<a href="javascript:file_delete()">[÷������ ����]</a>
					</div>
				</c:if>
				<input type="file" name="file1"></td></tr>
		<tr><td colspan="2">
			<a href="javascript:document.f.submit()">[�Խù�����]</a></td></tr>
	</table>
</form>

</body>
</html>