<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 인코딩값 : UTF-8 -->
<%
	request.setCharacterEncoding("UTF-8");
%> 

<!-- 3조 추천 태그 -->
<%
	RecomAdminDao recomDao = new RecomAdminDao();
	List<RecommendDto> recomList = recomDao.select_title();
%>


<jsp:include page="/adminTemplate/header.jsp"></jsp:include>


<div class="outbox" style="width:100%">
	<aside>
		<div class="row center " >
			<h2 style="color: #4B89DC;" >영화 관리</h2>
		</div>
		<div class="left ">
			<a href="movieList.jsp"> 영화리스트 </a><br><br> 
			<a href="movieInsert.jsp"> 영화 등록 </a><br><br>
			<a href="actorList.jsp"> 배우 리스트 </a><br><br>
			<a href="actorInsert.jsp"> 배우 등록 </a><br><br>
			<a href="recomList.jsp"> 3조 추천 영화 리스트 </a><br><br>
			<a href="recomInsert.jsp"> 3조 추천 영화 등록 </a><br><br>
		</div>
	</aside>
	
  	<article>
  	
  	<div>
  		<h1>3조 추천 태그 리스트</h1>
  	</div>
  	
		<div class="row">
			<table class="center" style="width:1000px; ">
				<thead>
					<tr>
						<th>3조 추천 태그 목록</th>
					</tr>
				</thead>
				<tbody>
				<%for(RecommendDto recomDto : recomList){ %>
					<tr>
						<td>
							<a class="abtn purple" href="recomDetail.jsp?recom_title=<%=recomDto.getRecom_title()%>">
							&#35 <%=recomDto.getRecom_title() %>
							</a>
							
						</td>
					</tr>
					<%} %>
				</tbody>
			</table>
			
		</div>	
	</article>
		<div class="right">
		<input type="button" class="adbtn gray" value="3조 추천 태그 생성&영화 추가" onclick="location.href='recomInsert.jsp'">
		</div>
</div>	

<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>    