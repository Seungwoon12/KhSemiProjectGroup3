<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>	
<!DOCTYPE html>
<script>
function Login() {
	form.member_pw.value = form.member_pw.value.trim();
	if (form.member_pw.value.length == 0) {
		alert('아이디를 입력해주세요.');
		form.member_id.focus();
		return;
	}
	form.loginPw.value = form.loginPw.value.trim();
	if (form.member_pw.value.length == 0) {
		alert('비밀번호를 입력해주세요.');
		form.member_pw.focus();
		return;
	}
	form.action="../index.jsp";
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
<form action="login.do" method="post">
<div class="outbox" height="40" width="430">
			<h1 align="center" style="padding: 0 0 30px 0;">MOVI 로그인</h1></div>
	<table align="center" height="40" width="430">  
         <tr>
              <td><input type="text" name="id" value=""  style="height:40px; width:430px" placeholder="아이디" ></td>
         </tr> 
  </table>


 <table align="center" height="40" width="430"> 
          <tr>
              <td><input type="password" name="pw" value="" style="height:40px; width:430px" placeholder="비밀번호" ></td>
         </tr>  
 </table>
<table align="center" height="50"  class="message">
  <tr>
   <td><a href="/movi/member/join.jsp"> </a>회원가입 | </td> 
   <td><a href="/movi/member/Idfind.jsp"> </a>아이디 찾기 |</td>
   <td><a href="/movi/member/PWfind.jsp"> </a>비밀번호 재설정</td>
  </tr>
  </table>
  
  <table align="center" height="40">
       <tr>
             <td><input type="submit" name="login" value="로그인" style="height:50px; width:430px;  background-color:skyblue; color:white; font-size:16px; "></td>
      </tr>
 </table>
</form>
 <jsp:include page="/template/footer.jsp"></jsp:include>	