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
	
	//비밀번호 확인이 비밀번호와 같지 않으면 경고창
	$(".pw-change").submit(function(e){
        e.preventDefault();
		
        var pw = $("input[name=member_pw]").val();
        var pw2 = $("input[name=member_pw2]").val();
        if(pw && pw === pw2){//비밀번호가 있으며 비밀번호와 재확인이 같은 경우
            this.submit();
        }
        else {
        	alert("비밀번호 확인이 올바르지 않습니다.");
        }
    });
});
</script>

<%
	int member_no = (int)session.getAttribute("loginInfo"); //아직 없는 변수 수정 필요
	
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.find(member_no);
%>

<form class="pw-change" action="editpw.do" method="post">
	<div class="outbox center" style="width:600px">
		<div class="row center">
			<h1>비밀번호 변경</h1>
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
			<input type="password" name="original_pw" required class="input" placeholder="정보 변경을 위해 현재 비밀번호를 입력해주세요">
		</div>
		<div style="text-align:center" class="row">
			<label>비밀번호</label>
			<br>
			<input type="password" name="member_pw" required class="input" placeholder="8~20자 영문 소문자/대문자/특수문자/숫자">
		</div>
		<div style="text-align:center" class="row">
			<label>비밀번호 확인</label>
			<br>
			<input type="password" name="member_pw2" required class="input">
		</div>
		<div class="row right">
			<input class="input input-inline" type="submit" value="등록">
			<input class="input input-inline" type="button" value="취소">
		</div>
	</div>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>