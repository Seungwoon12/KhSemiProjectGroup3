<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <!-- 배우 등록하기 -->
 
 
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>    
    
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
				<h1>배우 등록</h1>
			</div>
			
		<form action="actorInsert.do" method="post">
			<div class="row center">
				<table class="table table-border" style="width: 80%">
					<thead>
						<h1 class="left">배우 기본정보</h1>
					</thead>
					<tbody>
							
						<tr>
							<th style="width:30%">배우 이름</th>
							<td>
								<input type="text" name="actor_name" required>
							</td>
						</tr>
						<tr>
							<th colspan="2">
								<div >
									<input type="submit" value="등록" >
									<input type="button" value="취소" onclick="location.href='actorList.jsp'">
								</div>
							</th>
						</tr>
					</tbody>
				</table>
			</div>
		</form>	
		</article>
	</div>
		

<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>    