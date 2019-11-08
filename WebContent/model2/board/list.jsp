<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 목록 보기</title>
<link rel="stylesheet" href="../../css/main.css">

<script>
	// 검색 후, 그 결과를 페이지에 유지시켜주는 메서드함수
	function listdo(page) { // listdo 메서드에 page값을 넣고
		document.sf.pageNum.value = page; // pageNum의 value값을 바꿔주는 거야
		document.sf.submit(); // form을 submit해주는 거야
	}
</script>

</head>
<body>

<%--
	모든 액션을 form을 통해서 보내야지, 검색결과를 유지할 수 있게 됨
	그러니까 검색 결과가 12개이면, 1페이지는 10개 2페이지는 2개만 보여주면 되게 만들어줘야해
--%>
<form action="list.do" method="post" name="sf">
<input type="hidden" name="pageNum" value="1">
<table>
	<tr><td style="border-width: 0px; border-radius:10px 10px;">
		<select name="column">
			<option value="">선택하세요</option>
			<option value="title">제목</option>
			<option value="name">작성자</option>
			<option value="content">내용</option>
			<option value="title,name">제목+작성자</option>
			<option value="title,content">제목+내용</option>
			<option value="name,content">작성자+내용</option>
		</select>
		<script type="text/javascript">
			document.sf.column.value="${param.column}";
		</script>
		<input type="text" name="find" value="${param.find}" style="width:50%">
		<input type="submit" value="검색">
		</td>
	</tr>
</table>
</form>
<br>
<table>
	<caption>게시판 목록</caption>
	<co:if test="${boardcnt ==0}">
		<tr><td colspan="5">등록된 게시글이 없습니다</td></tr>
	</co:if>
	
	<co:if test="${boardcnt >0}">
		<tr><td colspan="5" style="text-align:right">글개수 : ${boardcnt}</td></tr>
		<tr><th width="8%">번호</th>
			<th width="50%">제목</th>
			<th width="14%">작성자</th>
			<th width="17%">등록일</th>
			<th width="11%">조회수</th></tr>
		<co:forEach var="b" items="${list}">
			<tr><td>${boardnum}</td><%--<%=b.getNum() %>  // boardnum : 보여주기식 번호 --%>
				<co:set var="boardnum" value="${boardnum -1}" />
				<td style="text-align:left">
					
				<%-- 첨부파일 확인--%>
				<co:if test="${!empty b.file1}">
						<a href="file/${b.file1}" style="text-decoration:none;">[첨부]</a>
				</co:if>
				<co:if test="${empty b.file1}">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</co:if>
								
				<%-- 답글 표시 : 제목을 grplevel별로 다르게 표현하는 방법 --%>
				<co:if test="${b.grplevel >0}">
					<co:forEach begin="1" end="${b.grplevel}">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</co:forEach>
					└>
				</co:if>
				
				<%-- ${b.num}&pageNum=${pageNum} --%>
				<a href="info.do?num=${b.num}">${b.title}</a></td>
				<td>${b.name}</td>
				<%-- 등록일 --%>
				<td>
					<co:set var="today" value="<%= new java.util.Date() %>" />
					<fmt:formatDate value="${today}" var="today1" pattern="yyyy-MM-dd" />
				<%--<fmt:parseDate value="${b.regdate}" var="today2" pattern="yyyy-MM-dd HH:mm:ss" />  --%>
					<fmt:formatDate value="${b.regdate}" var="today3" pattern="yyyy-MM-dd" />

					<co:if test="${today1 == today3}">
						<fmt:formatDate value="${b.regdate}" pattern="HH:mm:ss" />						
					</co:if>
					<co:if test="${today1 != today3}">
						<fmt:formatDate value="${b.regdate}" pattern="yy-MM-dd HH:mm" />
					</co:if>
				</td>
				
				<td>${b.readcnt}</td></tr>
		</co:forEach>
		
		<%-- 어려운 부분 --%>
		<tr><td colspan="5">
		<co:if test="${pageNum <=1}">
			[이전]
		</co:if>
		<co:if test="${pageNum >1}">
				<%-- <a href="list.do?pageNum=${pageNum -1}">[이전]</a> --%>
				<a href="javascript:listdo(${pageNum -1})">[이전]</a>
		</co:if>
		
		<co:forEach var="a" begin="${startpage}" end="${endpage}">
			<co:if test="${a ==pageNum}">
				[${a}]
			</co:if>
			<co:if test="${a !=pageNum}">
				<%-- <a href="list.do?pageNum=${a}">[${a}]</a> --%>
				<a href="javascript:listdo(${a})">[${a}]</a>
			</co:if>
		</co:forEach>

		<co:if test="${pageNum >= maxpage}">
			[다음]
		</co:if>
		<co:if test="${pageNum < maxpage}">
			<%-- <a href="list.do?pageNum=${pageNum +1}">[다음]</a> --%>
			<a href="javascript:listdo(${pageNum +1})">[다음]</a>
		</co:if>
		</td></tr>
	</co:if>
		
		<tr><td colspan="5" style="text-align:right">
			<a href="writeForm.do">[글쓰기]</a></td></tr>
</table>

</body>
</html>