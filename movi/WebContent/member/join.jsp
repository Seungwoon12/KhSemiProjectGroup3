<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>	
   
<script>
	var FindPwFormSubmitted = false;
	function submitFindPwForm(form) {
		if (FindPwFormSubmitted) {
			alert('처리중입니다.');
			return;
		}
		if (form.loginId.value.indexOf(' ') != -1) {
			alert('아이디는 공백을 포함할 수 없습니다.');
			form.loginId.focus();
			return;
		} else {
			if (!CheckLoginId(form.loginId.value)) {
				alert('아이디는 영문 소문자와 숫자로만 입력 가능합니다. \n길이는 4자 이상, 15자 이하여야 합니다');
				form.loginId.focus();
				return;
			}
		}
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요.')
			form.loginId.focus();
			return;
		}
}
</script>

 <style>
 .row{
height:50px;
width:70%;
}

.row-bottom{
height:50px; 
width:35%;
background-color:#3B83BD; 
color:white; 
font-size:15px;
border-radius:1.5em;
}

 </style>
 
<form action="join.do" method="post" onsubmit="checkValue()">
	<div  class="outbox" align="center">
			<h1>회원 가입</h1>
	</div>
		<div align="center">
			<font>아이디</font>
			<br>
			<input type="text" name="member_id" required  class="row" placeholder="4~12자의 영문/ 대소문자/숫자 입력">
		<span class="error_next_box"></span>
		</div>
	        <br>
		<div align="center">
			<font>비밀번호</font>
		    <br>
			<input type="password" name="member_pw" required class="row" placeholder="4~12자의 영문/ 대소문자/숫자 입력">
		</div>
			<br>
		<div align="center">
			<font>비밀번호확인</font>
			<br>
			<input type="password" name="member_pwcheck" required class="row"   placeholder="4~12자의 영문/ 대소문자/숫자 입력">
		</div>
			<br>
		<div align="center">
			<font>닉네임</font>
			<br>
			<input type="text" name="member_nick" required class="row"   placeholder="한글 2~10자">
		</div>
		   <br>
		<div align="center">
			<font>전화번호</font>
			<br>
			<input type="text" name="member_phone" class="row" placeholder="선택사항">
		</div>
		<br>	
		<div align="center">
		<font>장르체크(선택사항)</font>
                <br>
                <input type="checkbox"  name="genre" value="로맨스">로맨스
                <input type="checkbox"  name="genre" value="뮤지컬">뮤지컬
                <input type="checkbox"  name="genre" value="판타지">판타지
                <br>
                <input type="checkbox"  name="genre" value="애니메이션">애니메이션
                <input type="checkbox"  name="genre" value="역사극">역사극
                <input type="checkbox"  name="genre" value="코미디">코미디
                <br>
                <input type="checkbox"  name="genre" value="범죄">범죄
                <input type="checkbox"  name="genre" value="액션">액션
                <input type="checkbox"  name="genre" value="전쟁">전쟁
                <input type="checkbox"  name="genre" value="SF">SF
       </div>
       <br>
	  <br>
		<div align="center">
		    <input type="button" value="Back" class="row-bottom" onclick="history.go(-1);">
		      >
			<input type="submit" value="login"class="row-bottom" onclick="login();">
		</div>
	
	<jsp:include page="/template/footer.jsp"></jsp:include>
</form>