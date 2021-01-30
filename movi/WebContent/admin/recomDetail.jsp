<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 인코딩값 : UTF-8 -->
<%
	request.setCharacterEncoding("UTF-8");
%>

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
  		<table style="margin:10%">
  			<tbody>
  				<tr>
  					<th>#<%=recom_title %></th>
  				</tr>
  				<%for(RecommendDtoVO recomMovie : recomDto){ %>
  				<tr >
  					<td>
  						<a class="abtn orange movie_delete" href="#">
							<%=recomMovie.getRecom_movie_name() %>  X						
  						</a>
  					</td>
  				</tr>
  				<%} %>
  			</tbody>
  		</table>
				<div style="display-block; margin:10%">
  					<input type="button" class="adbtn gray" value="태그이름 변경" onclick="location.href='recomEdit.jsp?recom_title=<%=recom_title%>'">
  					<input type="button" class="adbtn gray recom_delete" value="태그삭제">				
				</div>

  	
  	</div>
	
	</article>
	
</div>	



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>     