<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="movi.beans.*"%>
	
<jsp:include page="/template/header.jsp"></jsp:include>

<script>
$(function(){
	//.cancel-btn을 누르면 마이 페이지로 이동
	$(".cancel-btn").click(function(){
		$(location).attr("href", "my.jsp");
	});
});
</script>

<%
	int member_no = (int)session.getAttribute("check"); //아직 없는 변수 수정 필요
	
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.find(member_no);
%>

<form action="edit.do" method="post">
	<div class="outbox center" style="width:600px">
		<div class="row center">
			<h1>회원 정보 수정</h1>
		</div>
		<%if(request.getParameter("error")!=null) {%>
		<div class="row center" style="color: red;">
			입력하신 정보가 올바르지 않습니다
		</div>
		<%} %>
		<div style="text-align:center" class="row">
			<label>아이디</label>
			<br>
			<!-- 아이디 받아서 넣을 것 -->
			<%=memberDto.getMember_id()%>
		<span class="error_next_box"></span>
		</div>
		<div style="text-align:center" class="row">
			<label>현재 비밀번호</label>
			<br>
			<input type="password" name="member_pw" required class="input" placeholder="정보 변경을 위해 현재 비밀번호를 입력해주세요">
		</div>
		<div style="text-align:center" class="row">
			<label>닉네임</label>
			<br>
			<input type="text" name="member_nick" class="input" placeholder="한글 2~10자" required 
			value="<%=memberDto.getMember_nick()%>">
		</div>
		<div style="text-align:center" class="row">
			<label>전화번호</label>
			<br>
			<input type="text" name="member_phone" class="input" required 
			value="<%=memberDto.getMember_phone()%>">
		</div>
		<div class="row right">
			<input class="input input-inline" type="submit" value="등록">
			<input class="input input-inline" type="button" value="취소">
		</div>
	</div>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>