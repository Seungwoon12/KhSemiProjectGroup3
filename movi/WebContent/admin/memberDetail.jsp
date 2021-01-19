<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>    


<!-- 상세보기 회원정보 -->
<%
	int member_no = Integer.parseInt(request.getParameter("member_no"));
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.select(member_no); 
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
  	
  		<div>
  			<h1>회원 상세목록</h1>
  		</div>

  		
  	<!--멤버 상세보기 테이블  -->	
		<div class="row center">
			<table class="table table-border" style="width:80%">

				<tbody>
				
					<tr>
						<th width="20%">회원번호</th>
						<td><%=memberDto.getMember_no()%></td>
					</tr>
					<tr>
						<th>회원아이디</th>
						<td><%=memberDto.getMember_id() %></td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td><%=memberDto.getMember_nick() %></td>
					</tr>
					<tr>
						<th>핸드폰 번호</th>
						<td><%=memberDto.getMember_phone() %></td>
					</tr>
					<tr>
						<th>가입일</th>
						<td><%=memberDto.getMember_date() %></td>
					</tr>
					<tr>
						<th>권한</th>
						<td><%=memberDto.getMember_auth() %></td>
					</tr>
					<tr>
						<th>선호 장르</th>
						<td></td>
					</tr>
					<tr>
						<th>이벤트 내역</th>
						<td></td>
					</tr>
					
					<tr>
						<td colspan="2">
							<input type="button" value="수정">
							<input type="button" value="삭제">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
			
			
			<!-- 회원리스트로 돌아가기 -->
		<div class="right">
			<a href="memberList.jsp">회원리스트로 돌아가기</a>
		</div>
		
			
	</article>
</div>  		



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>

