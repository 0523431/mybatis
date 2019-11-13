<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<title>W3.CSS Template</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
	html,body,h1,h2,h3,h4,h5,h6 {font-family: "Roboto", sans-serif;}
	
	.w3-sidebar {
  		z-index: 3;
  		width: 250px;
  		top: 43px;
  		bottom: 0;
  		height: inherit;
	}
	
	.bar{background-color:#E71D36; text-align:right;}
</style>
<body>

<!-- Navbar -->
<div class="bar">
    <a class="w3-bar-item w3-button w3-right w3-hide-large w3-hover-white w3-large w3-theme-l1"
     href="javascript:void(0)" onclick="w3_open()"><i class="fa fa-bars"></i></a>
    <a href="#" class="w3-bar-item w3-button w3-theme-l1">
    	<img src="${path}/decorator/moana.PNG" style="width:10%">
    </a>
    <c:if test="${empty sessionScope.login}">
		<a href="${path}/model2/member/loginForm.me" style="text-decoration:none;">[�α���]</a>
		<a href="${path}/model2/member/joinForm.me" style="text-decoration:none;">[ȸ������]</a>
	</c:if>
	<c:if test="${!empty sessionScope.login}">
		${sessionScope.login}�� �ݰ����ϴ�^^
		<a href="${path}/model2/member/logout.me" style="text-decoration:none;">[�α׾ƿ�]</a>
	</c:if>
</div>

<!-- Sidebar -->
<nav class="w3-sidebar w3-bar-block w3-collapse w3-large w3-theme-l5 w3-animate-left" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-right w3-xlarge w3-padding-large w3-hover-black w3-hide-large" title="Close Menu">
    <i class="fa fa-remove"></i>
  </a>
  <h4 class="w3-bar-item"><b>�޴��޴�</b></h4>
  <a class="w3-bar-item w3-button w3-hover-black"
   href="${path}/model2/member/main.me">ȸ������</a>&nbsp;&nbsp;&nbsp;
  <a class="w3-bar-item w3-button w3-hover-black"
   href="${path}/model2/board/list.do">�Խ���</a>
</nav>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- Main content: shift it to the right by 250 pixels when the sidebar is visible -->
<div class="w3-main" style="margin-left:250px">

  <div class="w3-row w3-padding-64">
    <div class="w3-twothird w3-container">
          <decorator:body />
    </div>
    <div class="w3-third w3-container">
      <p class="w3-border w3-padding-large w3-padding-32 w3-center">
      	 <c:if test="${!empty b.getFile1()}">
          <img src="file/${file1}" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
         </c:if>
      </p>
    </div>
  </div>

  <footer id="myFooter">
    <div class="w3-container w3-theme-l2 w3-padding-32">
      <h4>Footer Ǯ</h4>
    </div>

    <div class="w3-container w3-theme-l1">
      <p>Powered by <a href="https://google.com" target="_blank">������ �̵�</a></p>
    </div>
  </footer>

<!-- END MAIN -->
</div>

<script>
// Get the Sidebar
var mySidebar = document.getElementById("mySidebar");

// Get the DIV with overlay effect
var overlayBg = document.getElementById("myOverlay");

// Toggle between showing and hiding the sidebar, and add overlay effect
function w3_open() {
  if (mySidebar.style.display === 'block') {
    mySidebar.style.display = 'none';
    overlayBg.style.display = "none";
  } else {
    mySidebar.style.display = 'block';
    overlayBg.style.display = "block";
  }
}

// Close the sidebar with the close button
function w3_close() {
  mySidebar.style.display = "none";
  overlayBg.style.display = "none";
}
</script>

</body>
</html>
