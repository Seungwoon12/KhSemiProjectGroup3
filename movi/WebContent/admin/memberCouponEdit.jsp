<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!-- 관리자:쿠폰정보 수정  -->
<%
	//관리자는 회원정보를 수정하므로 파라미터로 전달받아 출력한다.(세션X)
	int member_no = Integer.parseInt(request.getParameter("member_no"));
	MemberAdminDao memberDao = new MemberAdminDao();
	MemberAdminDtoVO memberDto = memberDao.SelectAll_admin(member_no);
%>

<jsp:include page="/adminTemplate/header.jsp"></jsp:include>




<form action="memberEdit.do" method="post">
	<!-- 옆에 사이드 -->
	<div class="outbox" style="width: 100%">
		<aside>
			<div class="row center">
				<h2 style="color: deepskyblue;">회원 관리</h2>
			</div>
			<div class="left">
				<a href="memberList.jsp">회원리스트 </a><br> <br>
				 <a href="memberPwSearch.jsp"> 임시 비밀번호 발급 </a><br><br> 
				 <a href="#"> 회원 쿠폰 관리 </a>
			<br><br> <a href="memberCouponList.jsp">쿠폰 목록</a>
			<br><br> <a hre="memberCouponInsert.jsp">쿠폰 등록</a>
			</div>
		</aside>

		<article>

			<div>
				<h1>회원 정보 수정</h1>
			</div>

			<!--쿠폰 수정 테이블에서 정보 수정  -->
			<div class="row center">
				<table class="table table-border" style="width: 80%">

					<tbody>

						<tr>
							<th width="20%">회원 번호</th>
							<td>
							<input type="hidden" name="event_member_no" value="<%=memberDto.getMember_no()%>">
							<%=memberDto.getMember_no()%>
							</td>
						</tr>
						<tr>
							<th>회원아이디</th>
							<td><%=memberDto.getMember_id()%>
							 </td>
						</tr>
						<tr>
							<th>회원전화번호</th>
							<td><%=memberDto.getMember_phone()%>
							 </td>
						</tr>
						<tr>
							<th>이벤트 내역</th>
							<td>
							<%=memberDto.getEvent_name()%>/<%=memberDto.getEvent_coupon() %>
							 </td>
						</tr>						
						<tr>
							<th>이벤트</th>
							<td>
							<input type="text" name="event_name" placeholder="<%=memberDto.getEvent_name()%>" required>
							</td>
						</tr>
						<tr>
							<th>쿠폰 종류</th>
							<td>
							<select name="event_coupon">
								<option <%if(memberDto.coupon("꽝")){%>selected<%}%>>꽝</option>
								<option <%if(memberDto.coupon("영화예매권")){%>selected<%}%>>영화예매권</option>
								<option <%if(memberDto.coupon("CGV10%할인")){%>selected<%}%>>CGV10%할인</option>
								<option <%if(memberDto.coupon("바나나우유")){%>selected<%}%>>바나나우유</option>
								<option <%if(memberDto.coupon("비타500")){%>selected<%}%>>비타500</option>
								<option <%if(memberDto.coupon("abc초콜릿")){%>selected<%}%>>abc초콜릿</option>
							</select>
							</td>
						</tr>
						<tr>
							<th>쿠폰기한</th>
							<td>
							<input type="date" name="event_start" placeholder="<%=memberDto.getEvent_start()%>" required>
							~<input type="date" name="event_end" placeholder="<%=memberDto.getEvent_start()%>" required>
							</td>
						</tr>
						<tr>
							<td colspan="2">
							<input type="submit" value="쿠폰 수정"> 
							<input type="button" value="취소" onclick="location.href='memberCouponList.jsp'">
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- 쿠폰 목록으로 돌아가기 -->
			<div class="right">
				<a href="memberCouponList.jsp">회원 쿠폰 목록으로 돌아가기</a>
			</div>
		</article>
	</div>
</form>




<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>    