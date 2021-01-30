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
		text: "그래프"
	},
	 axisX:{
		  title : "통계 그래프"
		 },
		 data: [
		        {
		          type: "column",
		          dataPoints: [
		            { label: "총 회원수", y: <%=count_mem%> },
		            { label: "이벤트 참여자 수", y: <%=count_cou %> },
		            { label: "등록된 영화의 개수", y: <%=count_mov %> },
		            { label: "리뷰 총 개수", y: <%=count_rev %> }
		          ],
		        },
		      ]
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
  				 	<div style="width:200px" class="margin static">
  						<h1>총 회원 수</h1>
						 <h1><%=count_mem%>명</h1>
  					</div>
  				</th>
  				<th>
  				  	<div style="width:200px" class="margin static">
  						<h1>이벤트 참여자 수</h1>
						<h1><%=count_cou %>명</h1>
  					</div>
  				</th>
  				<th>
  					<div style="width:200px" class="margin static">
  				  		<h1>등록된 영화의 개수</h1>
  				  		<h1><%=count_mov %>개</h1>
  					</div>
  				</th>
  				<th>
  					<div style="width:200px" class="margin static">
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