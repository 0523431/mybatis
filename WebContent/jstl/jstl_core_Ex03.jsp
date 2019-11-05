<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSTL core 태그 : 반복문</title>
</head>
<body>

<h3>반복 관련 태그 : forEach</h3>
<co:forEach var="test" begin="1" end="10">
	${test}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</co:forEach>
<hr>
	<h4>step="2" 지정</h4>
	<co:forEach var="test" begin="1" end="10" step="2">
		${test}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</co:forEach>

<hr>
<h3>forEach 태그를 이용하여 1부터 100까지의 합 구하기</h3>
<co:forEach var="i" begin="1" end="100">
	<co:set var="sum" value="${sum +i}" />
</co:forEach>
<h4>
	1부터 100까지의 합 : ${sum}
</h4>

<hr>
<h3>forEach 태그를 이용하여 1부터 100까지 짝수의 합 구하기</h3>
<co:forEach var="even" begin="2" end="100" step="2">
	<co:set var="evensum" value="${evensum +even}" />
</co:forEach>
<h4>
	1부터 100까지 짝수의 합 : ${evensum}
</h4>

<hr>
<h3>forEach 태그를 이용하여 1부터 100까지 홀수의 합 구하기</h3>
<co:set var="sum" value="${0}" />
<co:forEach var="i" begin="1" end="100">
	<co:if test="${i%2 ==1}">
		<co:set var="sum" value="${sum +i}" />
	</co:if>
</co:forEach>
<h4>
	1부터 100까지 홀수의 합 : ${sum}
</h4>

<hr>
<h3>forEach 태그를 이용하여 2단부터 9단까지의 구구단 출력하기</h3>
<co:forEach var="i" begin="2" end="9">
	<h4>${i}단</h4>
	<co:forEach var="j" begin="1" end="9">
		${i}*${j}=${i*j}<br>
	</co:forEach>
	<br>
</co:forEach>

<hr>
<h3>forEach 태그를 이용하여 List 객체 출력하기</h3>
<%
	List<Integer> list = new ArrayList<Integer>();
	for(int i=1; i<=10; i++) {
		list.add(i*10);
	}
	// EL로 쓰기 위해서 반드시 속성에 등록해야하니까, page에 등록
	pageContext.setAttribute("list", list); // (속성이름, )
%>
<co:forEach var="i" items="${list}"> <%-- ${list} : 속성의 이름 --%>
	${i}&nbsp;&nbsp;&nbsp;&nbsp;
</co:forEach>
<%--
	var="i" items="${list}
	- i는 첨자가 아니라, list에 있는 각각 하나하나의 값
--%>
<hr>
<co:forEach var="i" items="${list}" varStatus="stat">
	<co:if test="${stat.index ==0}">
		<h4>forEach 태그의 varStatus 속성 연습</h4>
	</co:if>
	${stat.count} : ${i}<br> <%-- 출력되는 방식 --%>
</co:forEach>
<%--
	count : 1부터 시작 -> 반복되면서 2, 3, 4, ... 10 출력
	
	index : 0부터 시작 : 0번째에있는 값 출력 -> 2번째에 있는 값 ... 9번째에 있는 값 출력
--%>

<hr>
<h3>forEach 태그를 이용하여 Map 객체 출력하기</h3>
<%
	// key의 자료형:String
	// value의 자료형 :Object == 상관없이 들어올 수 있음
	// HashMap : 순서를 알 수 없어
	Map<String, Object> map = new HashMap<String, Object>();
	map.put("name", "홍길동");
	map.put("today", new Date());
	map.put("age", 20);
	// EL로 쓰기 위해서 반드시 속성에 등록되어 있어야함
	pageContext.setAttribute("maps", map);
%>
<co:forEach var="m" items="${maps}" varStatus="stat">
	${stat.count} : ${m.key} = ${m.value}<br> <%-- 출력되는 방식 --%>
</co:forEach>

<hr>
<h3>EL을 이용하여 Map 객체 출력하기</h3>
	name= ${maps.name}<br>
	today= ${maps.today}<br>
	age= ${maps.age}<br>
	name= \${maps.name} 여기서 \${maps.name}에서 maps는 속성이름<br>

<hr>
<h3>forEach 태그를 이용하여 배열 객체 출력하기</h3>
<co:set var="arr" value="<%=new int[]{10,20,30,40,50} %>" />
<%-- set은 EL뿐만 아니라, 표현식<%= %>도 value에서 쓸 수 있음 --%>

<co:forEach var="a" items="${arr }" varStatus="stat">
	arr[${stat.index}] = ${a}<br>
</co:forEach>

<hr>
<h4>그러니까, EL로 배열과 리스트의 값을 가져올 수 있음</h4>
${arr[0]}<br>
${list[2]}

<hr>
<h4>forEach 태그를 이용하여 배열 객체의 두번째 요소부터 세번째 요소까지 출력하기</h4>
<co:forEach var="a" items="${arr}" varStatus="stat" begin="1" end="2">
	arr[${stat.index}] = ${a}<br>
</co:forEach>
<%-- arr배열을 출력하는데 begin1부터 end2까지만 출력해줘라 --%>

<hr>
<h4>forEach 태그를 이용하여 배열 객체의 짝수 인덱스만 출력하기</h4>
<co:forEach var="a" items="${arr}" varStatus="stat" step="2">
	arr[${stat.index}] = ${a}<br>
</co:forEach>

<hr>
<h4>forEach 태그를 이용하여 배열 객체의 홀수 인덱스만 출력하기</h4>
<co:forEach var="a" items="${arr}" varStatus="stat" begin="1" step="2">
	arr[${stat.index}] = ${a}<br>
</co:forEach>

</body>
</html>