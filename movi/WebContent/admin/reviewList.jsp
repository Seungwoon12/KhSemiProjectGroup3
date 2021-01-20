<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>      
    
<div class="outbox" style="width:100%">
   <aside>
   		<div class="row center">
       		<h2 style="color:deepskyblue;">리뷰 관리</h2>     
  	 	</div>
  	 	<div class="left">
  	 		<a href="#"> 리뷰리스트 </a><br><br>
  	 		<a href="#"> 리뷰 관리 </a><br><br>
  	 		<a href="#"> 리뷰 삭제 </a><br><br>
  	 	</div>
  	</aside>
	
  	<article>
  	
  	<!-- 이벤트 검색창 -->
  		<div>
  			<h1>리뷰리스트</h1>
  		</div>
  		<div>
  			<form action="#" method="post">
  				<label>리뷰 검색</label>
  				<input type="text" name="event_name">
  				<input type="submit" value="검색">
  			</form>
  		</div>
  		
  	<!--멤버 리스트 테이블  -->	
	<div class="row">
		<table class="table table-border table-pattern">
			<thead>
				<tr>
					<th>전체선택</th>
					<th>리뷰 번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>

				<tr>
					<td>
						<input type="checkbox">
					</td>
					<td>리뷰 번호</td>
					<td>제목</td>
					<td>작성일</td>
					<td>조회수</td>
					<td>
						<a href="#">상세보기</a>
						<a href="#">삭제</a>
						
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	</article>
	
</div>	



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>
