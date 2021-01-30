<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 인코딩값 : UTF-8 -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 패이지 네비게이션 -->
<%
	int pageSize = 10;
	int p ;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p<=0) throw new Exception();//페이지<=0일 때 강제예외
	}catch(Exception e){
		p=1;
	}
	
	//페이지 시작, 끝 번호 계산
	int endRow = p * pageSize;
	int startRow = endRow- pageSize+1;
%>

<!--회원 검색 -->
<%
	//type(분류):번호,아이디 	key:검색어
	String type= request.getParameter("type");
	String key = request.getParameter("key");
	
	boolean search = type != null && key != null;
%> 

<!--멤버 목록   -->
<%	
	CouponAdminDao eventDao = new CouponAdminDao();
	List<MemberAdminDtoVO> memberList ;
	if(search){
		 memberList = eventDao.coupage_admin(type, key, startRow, endRow);
	}else{
		 memberList = eventDao.coupage_admin(startRow, endRow);
	}
%>
 
 
<!-- 페이지 블록  -->
<%	
	//블록크기
	int blockSize = 10;
	int startBlock = (p-1)/blockSize * blockSize +1;
	int endBlock = startBlock + blockSize -1;
	
	int count;
	if(search){
		count= eventDao.count_admin(type, key); 
	}else{
		count= eventDao.count_admin(); 
	}
	//페이지 개수
	int countSize = (count + pageSize -1) / pageSize;
	
	if(endBlock > countSize){
		endBlock = countSize;
	}
%>

<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<!-- 각종 기능 -->
<script>
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




<div class="outbox" style="width: 100% ">
	<aside>
		<div class="row center">
			<h2 style="color: #4B89DC;">회원 관리</h2>
		</div>
		<div class="left">
				<a href="memberList.jsp">회원리스트 </a><br> <br>
				 <a href="memberPwSearch.jsp"> 임시 비밀번호 발급 </a><br><br> 
				 <a href="memberCouponList.jsp">회원 쿠폰 목록</a>
		</div>
	</aside>

	<article>

		<div>
			<h1>회원 쿠폰 목록</h1>
		</div>

<div class="outbox center" style="width: 900px ; margin-top:2rem;">

  	<!-- 회원 쿠폰 검색창 -->
  		<div>
  			<h1>회원 쿠폰 검색</h1>
  		</div>
  		<div>
  			<form action="memberCouponList.jsp" method="post">
  				<select name="type" class="padding">
					<option value="member_no">회원 번호</option>
					<option value="member_id">회원 아이디</option>
  				</select>
  				<input type="text" name="key" class="padding" placeholder="검색어를 입력하세요" required>
  				<input type="submit" value="검색"  class="padding1">
  			</form>
  		</div>
  		
 <%if(memberList == null){ %>
<!-- 처음 들어온 경우 보여줄 화면 -->
	<div class="row center">
		<h4>쿠폰을 받은 회원을 입력하세요</h4>
	</div>		
 <%}else if(memberList.isEmpty()){ %> 
 <!-- 검색결과가 없는 경우 -->
		<div class="row center">
			<h1>검색결과가 없습니다.</h1>
		</div>
 <%}else { %>	
<!-- 검색결과가 있는 경우 --> 
  	<!--쿠폰 리스트 테이블  -->	
	<div class="row"> 
		<table class="table1" style="width: 880px;  margin-top:2rem;">
			<thead>
				<tr>
					<th>회원번호</th>
					<th>회원 아이디</th>
					<th>참여이벤트</th>
					<th>쿠폰</th>
					<th>쿠폰기한</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
			<%for(MemberAdminDtoVO memberDto : memberList){ %>
				<tr>
					<td><%=memberDto.getMember_no() %></td>
					<td><%=memberDto.getMember_id() %></td>
					<td><%=memberDto.getEvent_name() %></td>
					<td><%=memberDto.getCoupon_name() %></td>
					<td><%=memberDto.getCoupon_start() %> ~ <%=memberDto.getCoupon_end() %></td>
					<td>
						<a class="abtn red delete" href="couponDelete.do?event_member_no=<%=memberDto.getMember_no()%>">삭제</a>
					</td>
				</tr>
			<%} %> 
			</tbody>
		</table>
	</div>
 <%} %>
			
</div>


		<!-- 페이지 네비게이션 -->
		<div class="row center">
			<ul class="pagination">
			
				<!-- 이전 -->
				<%if(search){ %>
				<li><a href="memberCouponList?p=<%=startBlock-1%>&type=<%=type%>&key=<%=key%>">&lt;</a></li>
				<%}else{ %>
				<li><a href="memberCouponList?p=<%=startBlock-1%>">&lt;</a></li>
				<%} %>
				
				<%for(int i= startBlock; i<=endBlock;i++){ %>
					<li>
						<%if(search){ %>
						<!-- 검색용 링크 -->
						<a href="memberCouponList.jsp?p=1&type=<%=i%>&key=<%=key%>"><%=i %></a>
						<%}else{ %>
						<!-- 목록용 링크 -->
						<a href="memberCouponList.jsp?p=<%=i%>"><%=i %></a>
						<%} %>
					</li>	
				<%} %>	
				
				<!-- 이후 -->
				<%if(search){ %>
				<li><a href="memberCouponList.jsp?p=<%=endBlock+1%>&type=<%=type%>&key=<%=key%>">&gt;</a></li>
				<%}else{ %>
				<li><a href="memberCouponList.jsp?p=<%=endBlock+1%>">&gt;</a></li>
				<%} %>

			</ul>
		</div>
	</article>
</div>


<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>