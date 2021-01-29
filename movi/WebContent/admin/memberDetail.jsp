<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>    


<!-- 상세보기 회원정보 -->
<%
	int member_no = Integer.parseInt(request.getParameter("member_no"));
	MemberAdminDao memberDao = new MemberAdminDao();
	MemberAdminDtoVO memberDto = memberDao.SelectAll_admin(member_no); 

	//선호 장르 불러오기
		MygenreDao mygenreDao = new MygenreDao();
		List<MygenreDtoVO> mygenre_DtoVO_list = mygenreDao.find_no(member_no);
		List<String> mygenre_list = new ArrayList<>();
		GenreDao genreDao = new GenreDao();
		for(MygenreDtoVO mygenreDtoVO : mygenre_DtoVO_list){
			mygenre_list.add(genreDao.find(mygenreDtoVO.getMygenre_genre_no()));
		}
	
%>

<!-- 각종 기능 -->
<script>
//리뷰 삭제시 alert확인
	window.onload= function(){
		document.querySelector(".member_delete").addEventListener("click", function(){
			
			var check = window.confirm("회원을 삭제하시겠습니까?");
			if(check){
				location.href="<%=request.getContextPath()%>/admin/memberDelete.do?member_no=<%=memberDto.getMember_no()%>" ;
			}else{
				location.href= "<%=request.getContextPath()%>/admin/memberList.jsp" ;
			}
		});
	}; 
//쿠폰 삭제시 alert 확인	
	$(function(){
		//삭제시 알림창 보여주기
		$(".delete").click(function(e){
			e.preventDefault();
			
			var check = window.confirm("쿠폰을 삭제하시겠습니까?");
			if(check){
				location.href=$(this).attr("href");
			}
		});
		
	});
	

</script>


<div class="outbox" style="width:100%">
   <aside>
   		<div class="row center">
       		<h2 style="color:deepskyblue;">회원 관리</h2>     
  	 	</div>
  	 	<div class="left">
				<a href="memberList.jsp">회원리스트 </a><br> <br>
				 <a href="memberPwSearch.jsp"> 임시 비밀번호 발급 </a><br><br> 
				 <a href="memberCouponList.jsp">회원 쿠폰 목록</a>
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
						<th>선호장르</th>
						<td><%for(String mygenre : mygenre_list){ %>
								<%=mygenre %>
							<%} %>
						</td>
					</tr>
					<tr>
						<th>이벤트명/ 쿠폰</th>
						<td>
						<%=memberDto.getEvent_name() %>/
						<%=memberDto.getCoupon_name() %>
						<a class="abtn red delete" href="couponDelete.do?event_member_no=<%=memberDto.getMember_no()%>">삭제</a>
						</td>
					</tr>
					
					<tr>
						<td colspan="2">
							<input type="button" value="수정" class="adbtn blue"  onclick="location.href='memberEdit.jsp?member_no=<%=memberDto.getMember_no()%>'">
							<input type="button" value="삭제" class="adbtn red member_delete">
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

