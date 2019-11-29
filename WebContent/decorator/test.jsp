<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<title><decorator:title /></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="http://www.chartjs.org/dist/2.9.3/Chart.min.js">
</script>
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
<decorator:head />
<link rel="stylesheet" href="${path}/css/main.css">
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js">
<%--
	모든 게시판에 스마트 에디터를 쓰겠다 !
	version => full / smart / ...
--%>
</script>
<style>
	canvas {
		-moz-user-select: none; 
		-webkit-user-select: none;
		-ms-user-select: none;
	}
</style>
<script>
		var type2 = ['식비','교통비','관광비','기념품'];
		
		var barChartData = {
			labels: type2,
			datasets: [{
				label: '데이터 이름',
				backgroundColor: "#30A9DE",
				borderColor: "#791E94",
				borderWidth: 2,
				data: [10, 15, 20, -25, 60, 30, -10]
			}]
		};
			
		var config = {
				type: 'pie',
				data: {
					datasets: [{
						data: [10,20,70,10,15],
						backgroundColor: [
							"#ff7761","#A593E0","#30A9DE","#E53A40","#19A9DE"
						],
						label : "파이 그래프를 그려서 나중에 써먹자"
					}],
					labels : type2
				},
				options: {
					responsive: true,
					legend : {
						position : 'top'
					},
					title: {
						display: true,
						text: '생활비'
					},
					animation: {
						animateScale: true,
						animateRotate: true
					}
				}
			};
		
		var chartData = {
				labels: type2,
				datasets: [{
					label: '데이터 이름',
					fill: true,
					backgroundColor: "#30A9DE",
					borderColor: "#791E94",
					borderWidth: 1,
					data: [10, 15, 20, -25]
				},
				{
					label: '데이터 이름2',
					fill: false,
					backgroundColor: "#19A9DE",
					borderColor: "#251E94",
					borderWidth: 1,
					data: [-10, 45, 50, 15]
				}]
			};
		
		window.onload = function() {
			var ctx = document.getElementById('bar').getContext('2d');
			window.myBar = new Chart(ctx, {
				type: 'bar',
				data: barChartData,
				options: {
					responsive: true,
					legend: {
						position: 'bottom', // 'left','right','top'
					},
					title: {
						display: true,
						text: '지출비용'
					}
				}
			});
			
			var ctx2 = document.getElementById('pie').getContext('2d');
			window.myPie = new Chart(ctx2, config);
			
			var ctxT1 = document.getElementById('barT').getContext('2d');
			window.myBar2 = new Chart(ctxT1, {
				type: 'bar',
				data: chartData,
				options: {
					responsive: true
				}
			});
			var ctxT2 = document.getElementById('lineT').getContext('2d');
			window.myLine = new Chart(ctxT2, {
				type: 'line',
				data: chartData,
				options: {
					responsive: true
				}
			});
		};
</script>
<body>

<!-- Navbar -->
<div class="bar">
    <a class="w3-bar-item w3-button w3-right w3-hide-large w3-hover-white w3-large w3-theme-l1"
     href="javascript:void(0)" onclick="w3_open()"><i class="fa fa-bars"></i></a>
    <a href="#" class="w3-bar-item w3-button w3-theme-l1">
    	<img src="${path}/decorator/moana.PNG" style="width:10%">
    </a>
    <c:if test="${empty sessionScope.login}">
		<a href="${path}/model2/member/loginForm.me" style="text-decoration:none;">[로그인]</a>
		<a href="${path}/model2/member/joinForm.me" style="text-decoration:none;">[회원가입]</a>
	</c:if>
	<c:if test="${!empty sessionScope.login}">
		${sessionScope.login}님 반갑습니다^^
		<a href="${path}/model2/member/logout.me" style="text-decoration:none;">[로그아웃]</a>
	</c:if>
</div>

<!-- Sidebar -->
<nav class="w3-sidebar w3-bar-block w3-collapse w3-large w3-theme-l5 w3-animate-left" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-right w3-xlarge w3-padding-large w3-hover-black w3-hide-large" title="Close Menu">
    <i class="fa fa-remove"></i>
  </a>
  <h4 class="w3-bar-item"><b>메뉴메뉴</b></h4>
  <a class="w3-bar-item w3-button w3-hover-black"
   href="${path}/model2/member/main.me">회원관리</a>&nbsp;&nbsp;&nbsp;
  <a class="w3-bar-item w3-button w3-hover-black"
   href="${path}/model2/board/list.do">게시판</a>
   

</nav>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- Main content: shift it to the right by 250 pixels when the sidebar is visible -->
<div class="w3-main" style="margin-left:250px">

  <div class="w3-row w3-padding-64">
  		
  		<div id="pie_chart" style="width: 75%;">
       		<canvas id="pie"></canvas>
       	</div>
		<div id="bar_chart" style="width: 75%;">
   			<canvas id="bar"></canvas>
		</div>
		
		<div style="width: 75%;">
			<canvas id="barT"></canvas>
		</div>
		<div style="width: 75%;">
			<canvas id="lineT"></canvas>
		</div >
		
    <div class="w3-twothird w3-container">
		<decorator:body />
    </div>
    <div class="w3-third w3-container">
    </div>
  </div>

  <footer id="myFooter">
    <div class="w3-container w3-theme-l2 w3-padding-32">
      <h4>Footer 풀</h4>
    </div>

    <div class="w3-container w3-theme-l1">
      <p>Powered by <a href="https://google.com" target="_blank">누르면 이동</a></p>
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
