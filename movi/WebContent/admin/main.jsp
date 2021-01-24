<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<% %>

    
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>    


<!-- 선형 차트  -->
<script>
window.onload = function () {

var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	theme: "light2",
	title:{
		text: "Simple Line Chart"
	},
	data: [{        
		type: "line",
      	indexLabelFontSize: 16,
		dataPoints: [
			{ y: 450 },
			{ y: 414},
			{ y: 520, indexLabel: "\u2191 highest",markerColor: "red", markerType: "triangle" },
			{ y: 460 },
			{ y: 450 },
			{ y: 500 },
			{ y: 480 },
			{ y: 480 },
			{ y: 410 , indexLabel: "\u2193 lowest",markerColor: "DarkSlateGrey", markerType: "cross" },
			{ y: 500 },
			{ y: 480 },
			{ y: 510 }
		]
	}]
});
chart.render();

}
</script>
<!-- 파이 차트 -->
<script>
window.onload = function() {

var chart = new CanvasJS.Chart("chartContainer2", {
	animationEnabled: true,
	title: {
		text: "Desktop Search Engine Market Share - 2016"
	},
	data: [{
		type: "pie",
		startAngle: 240,
		yValueFormatString: "##0.00\"%\"",
		indexLabel: "{label} {y}",
		dataPoints: [
			{y: 79.45, label: "Google"},
			{y: 7.31, label: "Bing"},
			{y: 7.06, label: "Baidu"},
			{y: 4.91, label: "Yahoo"},
			{y: 1.26, label: "Others"}
		]
	}]
});
chart.render();

}
</script>

<div class="outbox" style="width:100%">
   <aside>
   		<div class="row center">
       		<h2 style="color:deepskyblue;">관리자 페이지</h2>     
  	 	</div>
  	 	<div class="left">
  	 		<a href="#">-   통계 </a>
  	 	</div>
  	</aside>
	
  	<article>
  		<div>
  			<h1>통계</h1>
  		</div>
  		<table>
  			<tr>
  				<th colspan="2">
  				  	<div>
  						<h1>방문자 수</h1>
							<div id="chartContainer" style="height: 370px; width: 100%;"></div>
  					</div>
  				</th>
  			</tr>
  			<tr>
  				<th>
  				 	<div>
  						<h1>장르별 좋아요 현황</h1>
								<div id="chartContainer2" style="height: 370px; width: 100%;"></div>
								<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
  					</div>
  				</th>
  				<th>
  				  	<div>
  						<h1>인기 검색어</h1>
  						<img src="https://placehold.it/300x300?text=IMAGE">

  					</div>
  				</th>
  			</tr>
  		</table>
  	</article>
</div>



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>