<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>      
    
<div class="outbox" style="width:100%">
   <aside>
   		<div class="row center">
       		<h2 style="color:deepskyblue;">영화 관리</h2>     
  	 	</div>
  	 	<div class="left">
  	 		<a href="#"> 이벤트 목록 </a><br><br>
  	 		<a href="#"> 이벤트 수정 </a><br><br>
  	 		<a href="#"> 이벤트 삭제 </a><br><br>
  	 		<a href="#"> 기간 설정/수정 </a>
  	 	</div>
  	</aside>
	
  	<article>
  	
  	<!-- 이벤트 검색창 -->
  		<div>
  			<h1>이벤트 목록</h1>
  		</div>
  		<div>
  			<form action="#" method="post">
  				<label>이벤트 검색</label>
  				<input type="text" name="event_name">
  				<input type="submit" value="검색">
  			</form>
  		</div>
  		
  	<!--멤버 리스트 테이블  -->	
	<div class="row">
		<table class="table table-border table-pattern">
			<thead>
				<tr>
					<th><input type="checkbox">전체선택</th>
					<th>이벤트 번호</th>
					<th>이벤트 이름</th>
					<th>기간</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>

				<tr>
					<td>
						<input type="checkbox">
					</td>
					<td>이벤트 번호</td>
					<td>이벤트 이름</td>
					<td>기간</td>
					<td>
						<a href="#">상세보기</a>
						<a href="#">수정</a>
						<a href="#">삭제</a>

					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	</article>
	
</div>	



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>

