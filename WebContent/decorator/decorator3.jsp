<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<title><decorator:title /></title>
<meta charset="EUC-KR">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<%-- charjs�� ���� ���ؼ� --%>
<script type="text/javascript" src="http://www.chartjs.org/dist/2.9.3/Chart.min.js">
</script>

<%-- ajax�� �̿��ؼ� ����� �����̶� jquery�� ���� --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	var randomColorFactor = function() {
		return Math.round(Math.random() *255);
	};
	var randomColor = function(opacity) {
		return "rgba("+randomColorFactor() + ","
			+ randomColorFactor() + ","
			+ randomColorFactor() + ","
			+ (opacity || '.3') +")";
	};
	
	// �����ε尡 �Ϸ�Ǹ�, exchangeRate() �Լ��� ȣ����
	$(document).ready(function() {
		exchangeRate();
//		setInterval(exchangeRate, 1000*60) // 1�и��� ���ΰ�ħ
		
		// �׷��� �ε� �Լ�
		graphs();
	})
	
	function exchangeRate() {
		// $.ajax : ������ ��û��
		// .do ==> method.properties
		$.ajax("${path}/model2/ajax/exchange3.do", { // exchange.do : �Ѱ��� ���� ��, exchange2.do : �� �ڵ�
			<%--
				data : exchange.jsp���� �����ϴ� html������
			--%>
			success : function(data) { // callback�Լ�
				$("#exchange").html(data); // ���������� �Ϸ�Ǹ�, ���̵� exchange�� ���� data�� ��
			},
			error : function(e) {
				alert("���� ����" + e.status);
			}
		})
	}
	
	// json���¸� �ڹٴܿ��� �������
	function graphs() {
		$.ajax("${path}/model2/ajax/graph.do", {
			success : function(data) {
				console.log(data);
				//pieGraphprint(data);
				//barGraphprint(data);
			},
			error : function(e) {
				alert("��������" + e.satus);
			}
		})
	}
	
	// json���¸� view�ܿ��� �������
	function graphs() {
		$.ajax("${path}/model2/ajax/graph2.do", {
			success : function(data) {
				console.log(data);
				pieGraphprint(data);
				barGraphprint(data);
			},
			error : function(e) {
				alert("��������" + e.satus);
			}
		})
	}
	
	function pieGraphprint(data) {
		// data : �������� ������ JSON���� ������
		var rows = JSON.parse(data);
		
		// �迭 �����ͷ� �������
		var names = [];
		var datas = [];
		var colors = [];
		
		$.each(rows, function(index, item) {
			names[index] = item.name; // �۾���
			datas[index] = item.cnt; // ���� ���� ����
			colors[index] = randomColor(1);
		})
		
		var config = {
			type : "pie",
			data : {
				datasets :[{
					data : datas,
					backgroundColor : colors,
				}],
				labels : names
			},
			options : {
				responsive : true,
				legend : {
					position : "top"
				},
				title : {
					display : true,
					text : "�۾��� �� �Խ��� ��� �Ǽ�"
				}
			}
		};
		var ctx = document.getElementById("canvas").getContext("2d");
		new Chart(ctx, config);
	}
	
	function barGraphprint(data) {
		// data : �������� ������ JSON���� ������
		var rows = JSON.parse(data);
		
		// �迭 �����ͷ� �������
		var names = [];
		var datas = [];
		var colors = [];
		
		$.each(rows, function(index, item) {
			names[index] = item.name; // �۾���
			datas[index] = item.cnt; // ���� ���� ����
			colors[index] = randomColor(1);
		})
		
		var config = {
			type : "bar",
			data : {
				datasets :[
				{
					type:"bar",
					label:"�Ǽ�",
					data : datas,
					backgroundColor : colors
				},
				{
					type:"list",
					label:"�Ǽ�",
					data : datas,
					backgroundColor : colors
				}],
				labels : names
			},
			options : {
				responsive : true,
				legend : {
					position : "top"
				},
				title : {
					display : true,
					text : "�۾��� �� �Խ��� ��� �Ǽ�"
				},
				scales: {
					xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: '�Խù� �ۼ���'
						},
						stacked : true // 0���� �����ϰ� ����
					}],
					yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: '�Խù� �ۼ� �Ǽ�'
						},
						stacked : true
					}]
				}
			}
		};
		var ctx = document.getElementById("canvas_bar").getContext("2d");
		new Chart(ctx, config);
	}
	
</script>
<style>
html, body, h1, h2, h3, h4, h5 {font-family: "Open Sans", sans-serif}
</style>
<decorator:head />
<link rel="stylesheet" href="${path}/css/main.css">
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js">
<%--
	��� �Խ��ǿ� ����Ʈ �����͸� ���ڴ� !
	version => full / smart / ...
--%>
</script>

<body class="w3-theme-l5">
<!-- Navbar ��ܹ� �κ�-->
<div class="w3-top">
 <div class="w3-bar w3-theme-d2 w3-left-align w3-large">
  <a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-padding-large w3-hover-white w3-large w3-theme-d2" href="javascript:void(0);" onclick="openNav()"><i class="fa fa-bars"></i></a>
  <a href="http://www.google.com" class="w3-bar-item w3-button w3-padding-large w3-theme-d4"><i class="fa fa-home w3-margin-right"></i>google �̵�</a>
  <a href="${path}/model2/member/main.me"
  	 class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white"
  	 title="News"><i class="fa fa-globe"></i><br>[ȸ������]</a>
  <a href="${path}/model2/board/list.do"
     class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white"
     title="Account Settings"><i class="fa fa-user"></i><br>[�Խ���]</a>
 </div>
</div>

<!-- Page Container -->
<div class="w3-container w3-content" style="max-width:1600px;margin-top:80px">    
  <!-- The Grid -->
  <div class="w3-row">
    <!-- Left Column -->
    <div class="w3-col m3">
      <!-- Profile -->
      <div class="w3-card w3-round w3-white">
        <div class="w3-container">
        
         <h4 class="w3-center">My Profile</h4>
         <p class="w3-center"><img src="/w3images/avatar3.png" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
         <hr>
         <p><i class="fa fa-pencil fa-fw w3-margin-right w3-text-theme"></i> Designer, UI</p>
         <p><i class="fa fa-home fa-fw w3-margin-right w3-text-theme"></i> London, UK</p>
         <p><i class="fa fa-birthday-cake fa-fw w3-margin-right w3-text-theme"></i> April 1, 1988</p>
        </div>
      </div>
      <br>
      
      <!-- Accordion -->
      <div class="w3-card w3-round">
        <div class="w3-white">
          <button onclick="myFunction('Demo1')" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i> My Groups</button>
          <div id="Demo1" class="w3-hide w3-container">
            <p>Some text..</p>
          </div>
          <button onclick="myFunction('Demo2')" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i> My Events</button>
          <div id="Demo2" class="w3-hide w3-container">
            <p>Some other text..</p>
          </div>
          <button onclick="myFunction('Demo3')" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-users fa-fw w3-margin-right"></i> My Photos</button>
          <div id="Demo3" class="w3-hide w3-container">
         <div class="w3-row-padding">
         <br>
           
         </div>
          </div>
        </div>      
      </div>
      <br>
      
      <!-- Interests => ȯ������ ��ġ --> 
      
        <div class="w3-container">
          <div id="exchange">
          	<!-- ���⿡ ȯ�������� �� ��ġ -->
          </div>
        </div>
      
      <br>
      
      <!-- Alert Box -->
      <div class="w3-container w3-display-container w3-round w3-theme-l4 w3-border w3-theme-border w3-margin-bottom w3-hide-small">
        <span onclick="this.parentElement.style.display='none'" class="w3-button w3-theme-l3 w3-display-topright">
          <i class="fa fa-remove"></i>
        </span>
        <p><strong>Hey!</strong></p>
        <p>People are looking at your profile. Find out who.</p>
      </div>
    
    <!-- End Left Column -->
    </div>
    
    <!-- Middle Column -->
    <div class="w3-col m7">
      
      <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        <c:if test="${!empty b.getFile1()}">
          <img src="file/${file1}" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
        </c:if>
        <span class="w3-right w3-opacity">${today}</span>
        <div id="container" style="width: 80%;" class="w3-row-padding">
        	<!-- ��Ʈ ��ġ -->
        	<canvas id="canvas">
			</canvas>
			<br><br>
			<canvas id="canvas_bar">
			</canvas>
        </div>
        
        <hr class="w3-clear">
        <div class="w3-row-padding" style="margin:0 -16px">
        	<decorator:body />
            <div class="w3-half">
            </div>           
        </div>
        <button type="button" class="w3-button w3-theme-d1 w3-margin-bottom"><i class="fa fa-thumbs-up"></i> ���ƿ�</button>
      </div>     
    <!-- End Middle Column -->
    </div>
    
    <!-- Right Column -->
      <div class="w3-card w3-round w3-white w3-center">
        <div class="w3-container">
          <p>Friend Request</p>
          <span>Jane Doe</span>
          <div class="w3-row w3-opacity">
            <div class="w3-half">
              <button class="w3-button w3-block w3-green w3-section" title="Accept"><i class="fa fa-check"></i></button>
            </div>
            <div class="w3-half">
              <button class="w3-button w3-block w3-red w3-section" title="Decline"><i class="fa fa-remove"></i></button>
            </div>
          </div>
        </div>
      </div>
      <br>
      
      <div class="w3-card w3-round w3-white w3-padding-16 w3-center">
        <p>ADS</p>
      </div>
      <br>
      
      <div class="w3-card w3-round w3-white w3-padding-32 w3-center">
        <p><i class="fa fa-bug w3-xxlarge"></i></p>
      </div>
      
    <!-- End Right Column -->
    </div>
    
  <!-- End Grid -->
  </div>
  
<!-- End Page Container -->
</div>
<br>

<!-- Footer -->
<footer class="w3-container w3-theme-d3 w3-padding-16">
  <h5>Footer ������ �ϴܿ� ǥ��</h5>
</footer>

<footer class="w3-container w3-theme-d5">
  <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">��ũ�� �̵������� ���</a></p>
</footer>
 
<script>
// Accordion
function myFunction(id) {
  var x = document.getElementById(id);
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
    x.previousElementSibling.className += " w3-theme-d1";
  } else { 
    x.className = x.className.replace("w3-show", "");
    x.previousElementSibling.className = 
    x.previousElementSibling.className.replace(" w3-theme-d1", "");
  }
}

// Used to toggle the menu on smaller screens when clicking on the menu button
function openNav() {
  var x = document.getElementById("navDemo");
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else { 
    x.className = x.className.replace(" w3-show", "");
  }
}
</script>

</body>
</html> 
