<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="movi.beans.*"%>
	
<jsp:include page="/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mypage.css">

<script>
$(function(){
	//.cancel-btn을 누르면 마이 페이지로 이동
	$(".cancel-btn").click(function(){
		$(location).attr("href", "my.jsp");
	});
	
	//회원 정보 변경 유효성 검사
	$(".input[name=member_nick]").blur(function(){
		var nick = $(this).val();
		var regex = /^[가-힣]{2,10}$/;
		if(regex.test(nick)){
			$(this).next().text("올바른 닉네임입니다");
			$(this).next().removeClass("bad");
			$(this).next().addClass("good");
			$(this).addClass("correct");
		}
		else{
			$(this).next().text("닉네임은 한글 2~10자만 가능합니다.");
			$(this).removeClass("correct");
			$(this).next().removeClass("good");
			$(this).next().addClass("bad");
		}
	});
	
	$(".input[name=member_phone]").blur(function(){
		var phone = $(this).val();
		var regex = /^01[016-9]-[1-9][0-9]{3}-[0-9]{4}$/;
		if(regex.test(phone)){
			$(this).next().text("올바른 전화번호 형식입니다");
			$(this).next().removeClass("bad");
			$(this).next().addClass("good");
			$(this).addClass("correct");
		}
		else{
			$(this).next().text("xxx-xxxx-xxxx 형식에 맞게 작성해 주세요");
			$(this).next().removeClass("good");
			$(this).next().addClass("bad");
			$(this).removeClass("correct");
		}
	});
	
	$(".edit-form").submit(function(e){
        e.preventDefault();

        $(".input").blur();

        if($(".input.correct").length == 2){
            this.submit();
        }
    });
	
});
</script>

<%
	int member_no = (int)session.getAttribute("check"); //아직 없는 변수 수정 필요
	
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.find(member_no);
%>

<form class="edit-form" action="edit.do" method="post">
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
			<span>&nbsp;</span>
		</div>
		<div style="text-align:center" class="row">
			<label>전화번호</label>
			<br>
			<input type="text" name="member_phone" class="input" placeholder="xxx-xxxx-xxxx 형식에 맞게 작성해 주세요" required 
			value="<%=memberDto.getMember_phone()%>">
			<span>&nbsp;</span>
		</div>
		<div class="row right">
			<input class="input input-inline" type="submit" value="등록">
			<input class="input input-inline cancel-btn" type="button" value="취소">
		</div>
	</div>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>