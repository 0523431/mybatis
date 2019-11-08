<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시판 글쓰기</title>
<link rel="stylesheet" href="../../css/main.css">

<script type="text/javascript">
	function inputcheck() {
		ff = document.f;
		if(ff.name.value=="") {
			alert("글쓴이를 입력하세요");
			ff.name.focus();
			return;
		}
		if(ff.pass.value=="") {
			alert("비밀번호를 입력하세요0");
			ff.pass.focus();
			return;
		}
		if(ff.title.value=="") {
			alert("제목을 입력하세요");
			ff.title.focus();
			return;
		}
		/* if(ff.content.value=="") {
			alert("내용을 입력하세요");
			ff.content.focus();
			return;
		} */
		ff.submit(); // write.jsp로 이동
	}
</script>

</head>
<body>

<form action="write.do" method="post" enctype="multipart/form-data" name="f">
	
	<table>
		<caption>게시판 글쓰기</caption>
		<tr><th>글쓴이</th>
			<td><input type="text" name="name"></td></tr>
		<tr><th>비밀번호</th>
			<td><input type="password" name="pass"></td></tr>
		<tr><th>제목</th>
			<td><input type="text" name="title"></td></tr>
		
		<tr><th>내용</th>
			<td><textarea rows="15" name="content" id="content1"></textarea></td></tr>
			<script>
				<%-- 이 기능을 쓰면 내용에 이미지를 올릴 수 있음
					  이미지 업로드용 url : filebrowserImageUploadUrl => 업로드 탭이 만들어짐
					  
					 imgupload.do : 업로드를 위한 url을 지정해줌
					 
					 -------------------------------------
					 업로드 탭에서 이미지 선택하고 업로드 버튼을 누르면 CKEDITOR가 imgupload.do를 실행시킴
					 그러면 method.properties에서 imgupload 메서드로 연결 시키고
				--%>
				CKEDITOR.replace("content1", {filebrowserImageUploadUrl : "imgupload.do"});
			</script>
		
		<tr><th>첨부파일</th>
			<td><input type="file" name="file1"></td></tr>
		<tr><td colspan="2">
			<a href="javascript:inputcheck()">[게시물등록]</a></td></tr>
	</table>
</form>

</body>
</html>