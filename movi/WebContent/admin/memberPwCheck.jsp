<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<%
	int member_no = Integer.parseInt(request.getParameter("member_no"));
	MemberAdminDao memberDao = new MemberAdminDao();
	MemberDto memberDto = memberDao.select_admin(member_no);
%>

<!--체크시 임시비번 전송 -->
<script>
	function pass(){
		var check = document.getElementById("check");
		
		if(check.checked == true){
			location.href="<%=request.getContextPath()%>/admin/memberPw.jsp";
			
		}else{
			alert("전송 방식을 체크해주세요");
			return false;
		}

	}
</script>
	<form action="/admin/memberPw.do">
		<input type="hidden" name="member_no" value="<%=memberDto.getMember_no()%>">
		<input type="hidden" name="member_id" value="<%=memberDto.getMember_id()%>">
		<input type="hidden" name="member_nick" value="<%=memberDto.getMember_phone()%>">
		<input type="hidden" name="member_phone" value="<%=memberDto.getMember_date()%>">
		<input type="hidden" name="member_auth" value="<%=memberDto.getMember_auth()%>">
	</form>


<div class="outbox" style="width: 100%">
	<aside>
		<div class="row center">
			<h2 style="color: deepskyblue;">회원 관리</h2>
		</div>
		<div class="left">
			<a href="memberList.jsp">회원리스트 </a><br>
			<br> <a href="memberPwSearch.jsp"> 임시 비밀번호 발급 </a><br>
			<br> <a href="#"> 회원 쿠폰 관리 </a>
			<br><br> <a href="memberCouponList.jsp">쿠폰 목록</a>
			<br><br> <a>쿠폰 등록</a>
		</div>
	</aside>

	<article>

		<div>
			<h1>임시 비밀번호 발급</h1>
		</div>

		<div class="outbox center" style="width: 500px">

			<div class="row">
				<h2>임시 비밀번호 생성</h2>
			</div>

			<table>
				<tr>
					<td style="height:100px">선택한 전송방식으로 회원에게 임시 비밀번호를 전송합니다.</td>
				</tr>
				<tr>
					<td style="height:150px">
					<label>전송방식</label> 
					<input id="check" type="checkbox" >
					<label>전화번호로 발송 </label>
					</td>
				</tr>
				<tr>
					<td style="height:100px">
					<input type="button" value="확인" id="pass-btn" onclick="pass();">
					 <input type="button" value="취소" onclick="location.href='memberList.jsp'">
					 </td>
				</tr>

			</table>

		</div>

	</article>
</div>




<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>
