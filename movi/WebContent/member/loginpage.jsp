<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<script>
	function submitLoginForm(form) {
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요.');
			form.loginId.focus();
			return;
		}
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요.');
			form.loginPw.focus();
			return;
		}
		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		form.submit();
	}
	function CheckLoginId(str) {
		var reg_loginId = /^[A-Za-z0-9+]{4,15}$/;
		if (!reg_loginId.test(str)) {
			return false;
		} else {
			return true;
		}
	}
</script>
<form action="doLogin" method="POST" class="login-page"
			onsubmit="submitLoginForm(this); return false;">
			<input type="hidden" name="redirectUri" value="${param.afterLoginRedirectUri}" />
			<input type="hidden" name="loginPwReal" /> 
			<h1 align="center" style="padding: 0 0 30px 0;">MOVI 로그인</h1>
	<table align="center" height="40" width="430">  
         <tr>
              <td><input type="text" name="id" value="" style="height:40px; width:430px"  placeholder="아이디" ></td>
         </tr> 
  </table>


 <table align="center" height="40" width="430"> 
          <tr>
              <td><input type="password" name="pw" value="" style="height:40px; width:430px"  placeholder="비밀번호" ></td>
         </tr>  
 </table>
	
			<table align="center" height="50"  class="message">
  <tr>
   <td><a href="/kh3/member/join.jsp">회원가입 | </td> 
   <td><a href="주소">아이디 찾기 | </td>
   <td><a href="주소">비밀번호 재설정</td>
  </tr>
			<table align="center" height="40" style="margin-top:1%">
       <tr>
             <td><input type="submit" name="login" value="로그인" style="height:50px; width:430px;  background-color:skyblue; color:white; font-size:16px; "></td>
      </tr>
 </table>