<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 배우의 상세보기  -->
<%
//배우 상세정보
	int actor_no =Integer.parseInt(request.getParameter("actor_no"));
	ActorAdminDao actorDao = new ActorAdminDao();
	ActorDto actorDto = actorDao.select_admin(actor_no);
	
//주연,조연 영화
	List<MovieDtoVO> main = actorDao.actor_admin(actor_no, "주연");
	List<MovieDtoVO> sub = actorDao.actor_admin(actor_no, "조연");

%>    
    
    
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<!-- 각종 기능 -->
<script>
//영화 삭제시 alert확인
	window.onload= function(){
		document.querySelector(".actor_delete").addEventListener("click", function(){
			
			var check = window.confirm("영화를 삭제하시겠습니까?");
			if(check){
				location.href="<%=request.getContextPath()%>/admin/actorDelete.do?movie_no=<%=actorDto.getActor_no()%>" ;
			}else{
				location.href= "<%=request.getContextPath()%>/admin/actorList.jsp" ;
			}
		});
	}; 
	

</script>



<div class="outbox" style="width: 100%">
	<aside>
		<div class="row center">
			<h2 style="color: deepskyblue;">영화 관리</h2>
		</div>
		<div class="left">
			<a href="movieList.jsp"> 영화리스트 </a><br><br> 
			<a href="movieInsert.jsp"> 영화 등록 </a><br><br>
			<a href="actorList.jsp"> 배우 리스트 </a><br><br>
			<a href="actorInsert.jsp"> 배우 등록 </a><br><br>
			<a href="#"> 3조 추천 영화 리스트 </a><br><br>
			<a href="#"> 3조 추천 영화 등록 </a><br><br> 
		</div>
	</aside>

	<article>

		<div>
			<h1>배우 상세보기</h1>
		</div>

		<!--배우 상세보기 테이블  -->
		<div class="row center">
			<table class="table table-border" style="width:80%">
				<tbody>
					<tr>
						<th style="width:10%">배우 번호</th>
						<td><%=actorDto.getActor_no() %></td>
					</tr>
					<tr>
						<th>배우 이름</th>
						<td>
							<%=actorDto.getActor_name() %>
						</td>
					</tr>
					<tr>
						<th>주연작품</th>
						<td>
							<%for(MovieDtoVO actor : main){ %>
								[<%=actor.getMovie_name() %>]
							<%} %>	
						</td>
					</tr>
					<tr>
						<th>조연작품</th>
						<td>
							<%for(MovieDtoVO actor : sub){ %>
								[<%=actor.getMovie_name() %>]
							<%} %>
						</td>
					</tr>

					<tr>
						<th colspan="3">
							<input type="button" value="수정" id="actorEdit" onclick="location.href='actorEdit.jsp?actor_no=<%=actorDto.getActor_no()%>'">
							<input type="button" value="삭제" class="actor_delete">
						</th>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 영화리스트로 돌아가기 -->
		<div class="right">
			<a href="actorList.jsp">배우리스트로 돌아가기</a>
		</div>
		


	</article>
</div>




<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>    