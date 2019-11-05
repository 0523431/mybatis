<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>el_Ex01.jsp의 결과 화면</title>
</head>
<body>

<%
	request.setCharacterEncoding("euc-kr");

	String tel = "010-1234-1234";
	
	// 페이지영역을 담당하는 객체 pageContext
	// (해당되는 그 페이지 하나 = 가장 작은 영역)
	pageContext.setAttribute("tel", tel);
	
	pageContext.setAttribute("test", "pageContext객체의 test 속성값");
	request.setAttribute("test", "request객체의 test 속성값");
	application.setAttribute("test", "application객체의 test 속성값");

%>

<h3>JSP의 스크립트를 이용하여 파라미터와 속성값 출력</h3>

pageContext test 속성값 : <%=pageContext.getAttribute("test") %><br>
session test 속성값 : <%=session.getAttribute("test") %><br>
today 속성값 : <%=session.getAttribute("today") %><br>
name 파라미터값 : <%=request.getParameter("name") %><br>
tel 변수값 : <%=tel %><br>
tel 속성값 : <%=pageContext.getAttribute("tel") %><br>
noAttr 속성값 : <%=pageContext.getAttribute("noAttr") %><br>
noparam 파라미터값 : <%=request.getParameter("noparam") %>

<br>
<hr>
<br>
<%--
	EL(표현언어) : 표현식을 대체하는 언어
				${값}
				단, 변수값은 표현할 수 없음 => 속성이나 파라미터 값만 표현 가능
--%>
<h3>
	JSP의 EL(표현)을 이용하여 파라미터와 속성값 출력<br>
	반드시 속성에 들있는 값만 불러올 수 있음
</h3>
pageContext test 속성값 : ${test }<br>
session test 속성값 : ${sessionScope.test }<br>
today 속성값 : ${today }<br>
<%--
	today속성은 session에 있음 => 별로 표시가 없으면, 작은 영역부터 찾음
	단계별로 찾지않고 바로 그 영역으로 가고 싶으면,
		- 영역Scope.속성이름을 사용

	영역의 크기
	: page < request < session < application
--%>
name 파라미터값 : ${param.name }<br>
tel 변수값 : EL로 표현 못 함. <%=tel %><br>
tel 속성값 : ${tel }<br>
noAttr 속성값 : ${noAttr }<br>
noparam 속성값 :${param.noparam }
	<%--
	${test} : 영역담당 객체에 저장된 속성 중 이름이 test인 값을 리턴
	  - page 영역 : pageContext 객체
	  - request 영역 : request
	  - session 영역 : session
	  - application 영역 : application

	1. pageContext 객체에 등로된 속성 중 이름이 test인 속성의 값을 리턴
	2. 1번에 해당하는 속성이 없는 경우
	   request 객체에 등로된 속성 중 이름이 test인 속성의 값을 리턴
	3. 2번에 해당하는 속성이 없는 경우
	   session 객체에 등로된 속성 중 이름이 test인 속성의 값을 리턴
	4. 3번에 해당하는 속성이 없는 경우
	   application 객체에 등로된 속성 중 이름이 test인 속성의 값을 리턴
	5. 4번에 해당하는 속성이 없는 경우
	   null이 아니고 아무것도 출력하지 않음. 오류발생도 없음
	   
	<직접 영역 담당 객체를 지정하여 출력하기>
	 - pageContext 객체의 속성 : ${pageScope.test}
 	 - request 객체의 속성 : ${requestScope.test}
 	 - session 객체의 속성 : ${sessionScope.test}
 	 - application 객체의 속성 : ${applicationScope.test}

--%>
<hr>
<h3>
	영역을 설정하여 test 속성값 출력하기
</h3>
\${test} = ${test }<br>
\${pageScope.test} = ${pageScope.test}<br>
\${requestScope.test} = ${requestScope.test}<br>
\${sessionScope.test} = ${sessionScope.test}<br>
\${applicationScope.test} = ${applicationScope.test}<br>
\${requestScope.today} = ${requestScope.today}<br>
▷(request영역에는 today라는 속성이 없으니까 아무것도 안나옴)
</body>
</html>