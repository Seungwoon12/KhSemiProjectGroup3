<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 배우 이름 수정 -->  
<%
	//파라미터 받아서 출력
 	request.setCharacterEncoding("UTF-8");
	int actor_no =Integer.parseInt(request.getParameter("actor_no"));
	ActorAdminDao actorDao = new ActorAdminDao();
	ActorDto actorDto = actorDao.select_admin(actor_no);

	
	//주연,조연 영화
	List<MovieDtoVO> main = actorDao.actor_admin(actor_no, "주연");
	List<MovieDtoVO> sub = actorDao.actor_admin(actor_no, "조연");
%>

<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<style>
        .row1 {
            width: 90%;
            margin:3px;
            border: solid 2px gray;
            border-radius: 8px;
            font-size:15px;
            padding:0.5rem;
            padding-left: 1.5rem;
        }
		
		.table2{
			border-radius: 10px;
			border-color: lightblue;
			padding:1rem;
            font-size:18px;			
		}


</style>



	
<form action="actorEdit.do" method="post">
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
			<a href="recomList.jsp"> 3조 추천 영화 리스트 </a><br><br>
			<a href="recomInsert.jsp"> 3조 추천 영화 등록 </a><br><br>
			</div>
		</aside>

		<article>

			<div>
				<h1>배우 수정</h1>
			</div>

			<!--영화 추가 테이블  -->
			<div class="row center">
				<table class="table table2" style="width: 80%; margin:10%;">
					<tbody>
						<tr>
							<th>배우 번호</th>
							<td>
								<input type="hidden" name="actor_no" value="<%=actorDto.getActor_no()%>">
								<%=actorDto.getActor_no() %>
							</td>
						</tr>
					
						<tr>
							<th style="width:30%">배우 이름</th>
							<td>
								<input type="text" class="row1" name="actor_name" placeholder="<%=actorDto.getActor_name() %>" required>
							</td>
						</tr>
						<tr>
							<th>주연작품</th>
							<td style="color:#4E6FA6; font-weight: bold;">
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
							<th colspan="2">
								<div >
									<input type="submit" class="adbtn green" value="등록" >
									<input type="button" class="adbtn yellow" value="취소" onclick="location.href='actorList.jsp'">
								</div>
							</th>
						</tr>

					</tbody>
				</table>
			</div>
		</article>
	</div>
</form>



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>     