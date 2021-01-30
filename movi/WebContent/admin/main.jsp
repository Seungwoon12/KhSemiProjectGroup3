<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 인코딩값 : UTF-8 -->
<%
	request.setCharacterEncoding("UTF-8");
%>

<!-- 총 회원 수 -->
<%
	MemberAdminDao memberDao = new MemberAdminDao();
	int count_mem = memberDao.count_admin();
%>
<!-- 이벤트 참여자 횟수 -->
<%
	CouponAdminDao eventDao = new CouponAdminDao();
	int count_cou = eventDao.count_admin();
%>
<!--등록된 영화의 개수  -->
<%
	MovieAdminDao movieDao = new MovieAdminDao();
	int count_mov = movieDao.count_admin();
%>
<!-- 리뷰 총 개수 -->
<%
	ReviewAdminDao reviewDao = new ReviewAdminDao();
	int count_rev = reviewDao.count_admin();
 %>
    
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>    

<!-- 선형 차트  -->
<script>
window.onload = function () {

var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	theme: "light2",
	title:{
		text: "방문자 수"
	},
	 axisX:{
		  title : "방문 날짜"
		 },
	data: [{        
		type: "line",
      	indexLabelFontSize: 16,
		dataPoints: [

			{x: new Date(2021, 00, 20), y: 9 },
			{x: new Date(2021, 00, 21), y: 15 },
			{x: new Date(2021, 00, 22), y: 7  , indexLabel: "\u2193 lowest",markerColor: "DarkSlateGrey", markerType: "cross"},
			{x: new Date(2021, 00, 23), y: 22 },
			{x: new Date(2021, 00, 24), y: 34 ,indexLabel: "\u2191 highest",markerColor: "red", markerType: "triangle" },
			{x: new Date(2021, 00, 25), y: 21 },
			{x: new Date(2021, 00, 26), y: 17 },
			{x: new Date(2021, 00, 27), y: 24 },
			{x: new Date(2021, 00, 28), y: 29 },
			{x: new Date(2021, 00, 29), y: 32 },
			{x: new Date(2021, 00, 30), y: 20 },
			{x: new Date(2021, 00, 31), y: 23 },
			{x: new Date(2021, 01, 01), y: 25 }

		]
	}]
});
chart.render();

}
</script>
<!-- 파이 차트 -->


<div class="outbox" style="width:100%">
   <aside>
   		<div class="row center">
       		<h2 style="color:#4B89DC;">관리자 페이지</h2>     
  	 	</div>
  	 	<div class="left">
  	 		<a href="#">통계 </a>
  	 	</div>
  	</aside>
	
  	<article>
  		<div>
  			<h1>통계</h1>
  		</div>
  		<table class="center">
  		  	<tr>
  				<th>
  				 	<div style="width:200px" class="margin">
  						<h1>총 회원 수</h1>
						 <h1><%=count_mem%>명</h1>
  					</div>
  				</th>
  				<th>
  				  	<div style="width:200px" class="margin">
  						<h1>이벤트 참여자 수</h1>
						<h1><%=count_cou %>명</h1>
  					</div>
  				</th>
  				<th>
  					<div style="width:200px" class="margin">
  				  		<h1>등록된 영화의 개수</h1>
  				  		<h1><%=count_mov %>개</h1>
  					</div>
  				</th>
  				<th>
  					<div style="width:200px" class="margin">
  						<h1>리뷰 총 개수</h1>
  						<h1><%=count_rev %>개</h1>
  					</div>
  				</th>
  			</tr>
  		
  		
  		</table>
  		<div >
  			<h1>방문자 수</h1>
			<div id="chartContainer" style="height: 350px; width: 900px; margin: 50px" ></div>
			<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
  		</div>

  	</article>
</div>



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>