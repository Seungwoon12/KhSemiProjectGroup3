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
<div class="find">
	<div class="form">
		<form action="doFindPw" method="POST" class="find"
			onsubmit="submitFindPwForm(this); return false;">
			<h1>비밀번호 찾기</h1>
			<input name="loginId" type="text" placeholder="아이디" /> <input
				name="name" type="text" placeholder="닉네임" /> <input name="email"
				type="email" placeholder="이메일" />
			<button type="submit">비밀번호 찾기</button>
			<p class="message">
				아이디를 찾기 <a href="findLoginId">아이디 찾기</a>
			</p>
			<p class="message">
				비밀번호를 찾기<a href="login">로그인</a>
			</p>
		</form>
	</div>
</div>