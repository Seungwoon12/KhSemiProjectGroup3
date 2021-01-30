<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<!-- 태그 상세보기  -->
<%
//태그 상세목록
	String recom_title = request.getParameter("recom_title");
	RecomAdminDao recomDao = new RecomAdminDao();
	List<RecommendDtoVO> recomDto = recomDao.select_admin(recom_title);
%>

<!-- 각종 기능 -->
<script>
//리뷰 삭제시 alert확인
	window.onload= function(){
		document.querySelector(".recom_delete").addEventListener("click", function(){
			
			var check = window.confirm("이 태그를 삭제하시겠습니까?");
			if(check){
				location.href="<%=request.getContextPath()%>/admin/recomDelete.do?recom_title=<%=recom_title%>" ;
			}else{
				location.href= "<%=request.getContextPath()%>/admin/recomList.jsp" ;
			}
		});
	}; 


	//태그안에 있는 영화 삭제시 alert 확인	
	$(function(){
		//삭제시 알림창 보여주기
		$(".movie_delete").click(function(e){
			e.preventDefault();
			
			var check = window.confirm("이 영화를 태그에서 삭제하시겠습니까?");
			if(check){
				location.href=$(this).attr("href");
			}
		});	
	});
</script>


    
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<style>
	.abtn{
		padding-left: 20px;
		padding-right: 20px;
	}


</style>

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
			<a href="recomList.jsp"> 3조 추천 영화 등록 </a><br><br>
		</div>
	</aside>
	
  	<article>
  	
  	<div>
  		<h1>3조 추천 태그 상세보기</h1>
  	</div>
  	<div>
  		<table class="table2  table" style="width:500px; margin:auto">
  			<tbody>
  				<tr>
  					<th>#<%=recom_title %></th>
  				</tr>
  				<%for(RecommendDtoVO recomMovie : recomDto){ %>
  				<tr >
  					<td >
  						<form action="movie_no_delete.do" method="get">
  							<input type="hidden" name="recom_no" value="<%=recomMovie.getRecom_no()%>">
  							<input type="hidden" name="recom_movie_no" value="<%=recomMovie.getRecom_movie_no()%>">
							<input class= "abtn orange movie_no_delete" type="submit" value="<%=recomMovie.getRecom_movie_name() %>    X">	
						</form>	
		
  					</td>
  				</tr>
  				<%} %>
  			</tbody>
  		</table>
				<div class="center" style="margin:1rem; ">
  					<input type="button" class="adbtn gray" value="태그 이름 수정" onclick="location.href='recomEdit.jsp?recom_title=<%=recom_title%>'">
  					<input type="button" class="adbtn gray recom_delete" value="태그삭제">				
				</div>

  	
  	</div>
	
	</article>
	
</div>	



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>     