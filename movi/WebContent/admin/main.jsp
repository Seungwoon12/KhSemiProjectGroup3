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
  		<table class="center">
  		  	<tr>
  				<th>
  				 	<div style="width:200px">
  						<h1>총 회원 수</h1>
						 <h1><%=count_mem%>명</h1>
  					</div>
  				</th>
  				<th>
  				  	<div style="width:200px">
  						<h1>이벤트 참여자 수</h1>
						<h1><%=count_cou %>명</h1>
  					</div>
  				</th>
  				<th>
  					<div style="width:200px">
  				  		<h1>등록된 영화의 개수</h1>
  				  		<h1><%=count_mov %>개</h1>
  					</div>
  				</th>
  				<th>
  					<div style="width:200px">
  						<h1>리뷰 총 개수</h1>
  						<h1><%=count_rev %>개</h1>
  					</div>
  				</th>
  			</tr>
  		
  		
  		</table>
  		<table>
  			<tr>
  				<th colspan="2">
  				  	<div>
  						<h1>방문자 수</h1>
							<div id="chartContainer" style="height: 350px; width: 800px"></div>
							<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
  					</div>
  				</th>
  			</tr>
  			<tr>
  				<th>
  				 	<div>
  				 	<!--파이차트 -->
  						<h1>장르별 좋아요 비율</h1>

  					</div>
  				</th>
  				<th>
  				  	<div>
  				  	<!-- 리스트  -->
  						<h1>영화 좋아요 순위</h1>
  					</div>
  				</th>
  			</tr>
  		</table>
  	</article>
</div>



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>