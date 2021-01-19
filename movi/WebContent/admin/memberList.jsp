<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>    

<!--목록   -->
<%
	MemberDao memberDao = new MemberDao();
	//List<MemberDto> memberList = memberDao.select(member_id);
%>


<div class="outbox" style="width:100%">
   <aside>
   		<div class="row center">
       		<h2 style="color:deepskyblue;">회원 관리</h2>     
  	 	</div>
  	 	<div class="left">
  	 		<a href="#">회원리스트 </a><br><br>
  	 		<a href="#"> 회원 탈퇴/삭제 </a><br><br>
  	 		<a href="#"> 임시 비밀번호 발급 </a><br><br>
  	 		<a href="#"> 회원 쿠폰 관리 </a>
  	 	</div>
  	</aside>
	
  	<article>
  	
  	<!-- 회원 검색창 -->
  		<div>
  			<h1>회원 리스트</h1>
  		</div>
  		<div>
  			<form action="#" method="post">
  				<label>회원검색</label>
  				<input type="text" name="member_id">
  				<input type="submit" value="검색">
  			</form>
  		</div>
  		
  	<!--멤버 리스트 테이블  -->	
	<div class="row">
		<table class="table table-border table-pattern">
			<thead>
				<tr>
					<th>전체선택</th>
					<th>회원번호</th>
					<th>회원 아이디</th>
					<th>가입일</th>
					<th>권한</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>

				<tr>
					<td>
						<input type="checkbox">
					</td>
					<td>1</td>
					<td>tester</td>
					<td>2021-01-18</td>
					<td>일반</td>
					<td>
						<a href="#">상세보기</a>
						<a href="#">수정</a>
						<a href="#">삭제</a>

					</td>
				</tr>
			</tbody>
		</table>
	</div>

		<!-- 페이지 네비게이션 -->
		<div class="row center">
			<ul class="pagination">
				<li><a href="#">&lt;</a></li>
				<li class="active"><a href="#">1</a></li>
				<li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">4</a></li>
				<li><a href="#">5</a></li>
				<li><a href="#">6</a></li>
				<li><a href="#">7</a></li>
				<li><a href="#">8</a></li>
				<li><a href="#">9</a></li>
				<li><a href="#">10</a></li>
				<li><a href="#">&gt;</a></li>
			</ul>
		</div>
	
	
  		
  	</article>
</div>


<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>


