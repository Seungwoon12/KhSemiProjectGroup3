
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<!-- 관리자: 회원정보 수정   -->
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
				 <a href="memberCouponList.jsp">회원 쿠폰 목록</a>
			</div>
		</aside>

		<article>

			<div>
				<h1>회원 정보 수정</h1>
			</div>


			<!--멤버 상세보기 테이블에서 정보 수정  -->
			<div class="row center">
				<table class="table table-border" style="width: 80%">

					<tbody>

						<tr>
							<th width="20%">회원번호</th>
							<td>
							<input type="hidden" name="member_no" value="<%=memberDto.getMember_no()%>">
							<%=memberDto.getMember_no()%>
							</td>
						</tr>
						<tr>
							<th>회원아이디</th>
							<td><%=memberDto.getMember_id()%>
							<input type="button" value="임시 비밀번호 발급" onclick="location.href='memberPwCheck.jsp?member_no=<%=memberDto.getMember_no()%>'">
							 </td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td>
							<input type="text" name="member_nick" placeholder="<%=memberDto.getMember_nick()%>" required>
							</td>
						</tr>
						<tr>
							<th>핸드폰 번호</th>
							<td><%=memberDto.getMember_phone()%></td>
						</tr>
						<tr>
							<th>가입일</th>
							<td><%=memberDto.getMember_date()%></td>
						</tr>
						<tr>
							<th>권한</th>
							<td>
							<select name="member_auth">
								<option <%if(memberDto.is("일반")){%>selected<%}%>>일반</option>
								<option <%if(memberDto.is("관리자")){%>selected<%}%>>관리자</option>
							</select>
							</td>
						</tr>
						<tr>
							<th>선호 장르</th>
							<td><%=memberDto.getGenre_name() %></td>
						</tr>
						<tr>
							<th>이벤트 내역</th>
							<td>
							이벤트명: <%=memberDto.getEvent_name() %>/
							쿠폰 :<%=memberDto.getCoupon_name() %>
							</td>
						</tr>

						<tr>
							<td colspan="2">
							<input type="submit" value="등록" class="adbtn green"> 
							<input type="button" value="취소" class="adbtn yellow" onclick="location.href='memberDetail.jsp?member_no=<%=memberDto.getMember_no()%>'">
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- 회원리스트로 돌아가기 -->
			<div class="right">
				<a href="memberDetail.jsp?member_no=<%=memberDto.getMember_no()%>">회원상세보기로 돌아가기</a>
			</div>
		</article>
	</div>
</form>




<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>