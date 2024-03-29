<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 수정 화면</title>
<link rel="stylesheet" href="../../css/main.css">

<script type="text/javascript">
	function file_delete() { // 첨부파일이 있을때, 실행하는 메서드
		document.f.file2.value =""; // hidden값을 통해서 db와 연결을 끊고 (file과 db관계를 끊음)
		file_desc.style.display ="none"; // display="none" ===> 보이지않게 만듦
	}
</script>

</head>
<body>

<form action="update.do" name="f" method="post" enctype="multipart/form-data">
	<input type="hidden" name="num" value="${info.num}"> <%-- 이걸 받아야 update.do로 갈 수 있어 --%>
	<input type="hidden" name="file2" value="${info.file1}">
									  <%--   ${info.file1==null? "":info.file1}
									  		  이렇게 하지 않아도, el은 null인값은 보여주지 않아서 괜찮음
									  --%>
	<table>
		<caption>게시글 수정 화면</caption>
		<tr><th>글쓴이</th>
			<td><input type="text" name="name" value="${info.name}"></td></tr>
		<tr><th>비밀번호</th>
			<td><input type="password" name="pass"></td></tr>
		<tr><th>제목</th>
			<td><input type="text" name="title" value="${info.title}"></td></tr>
		<tr><th>내용</th>
			<td><textarea rows="15" name="content" id="content1">${info.content}</textarea></td></tr>
			<script>
				<%-- <id를 설정해줘야함>
				
					  이 기능을 쓰면 내용에 이미지를 올릴 수 있음
					  이미지 업로드용 url : filebrowserImageUploadUrl => 업로드 탭이 만들어짐
					  
					 imgupload.do : 업로드를 위한 url을 지정해줌
					 
					 -------------------------------------
					 업로드 탭에서 이미지 선택하고 업로드 버튼을 누르면 CKEDITOR가 imgupload.do를 실행시킴
					 그러면 method.properties에서 imgupload 메서드로 연결 시키고
				--%>
				CKEDITOR.replace("content1", {filebrowserImageUploadUrl : "imgupload.do"});
			</script>
		<tr><td>첨부파일</td>
			<td style="text-align : left">
				<c:if test="${!empty info.file1}">
					<div id="file_desc">
						${info.file1}
						<a href="javascript:file_delete()">[첨부파일 삭제]</a>
					</div>
				</c:if>
				<input type="file" name="file1"></td></tr>
		<tr><td colspan="2">
			<a href="javascript:document.f.submit()">[게시물수정]</a></td></tr>
	</table>
</form>

</body>
</html>