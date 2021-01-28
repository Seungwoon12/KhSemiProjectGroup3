<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>	
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

 <script>
// 회원가입 유효성 검사
      function check() {
    	  var id = document.getElementById('id').value;
    	  var regexid = /^[a-z][a-z0-9]{6,19}$/;
    	  if(!regexid.test(id)){
        	  alert("아이디는 6~20자 이내로 작성하세요");
              return false;
            }
    
    	 var pw1 = document.getElementById( 'pw1' ).value;
    	 var pw2 = document.getElementById( 'pw2' ).value;
         if ( pw1 != pw2 ) {
              alert( "비밀번호가 일치하지않습니다" );
              return false;
         }
          var regexpw = /^[a-zA-Z0-9!@#$]{8,16}$/;
          if(!regexid.test(pw1)){
        	 alert("비밀번호는 8~20자 영문,숫자,특수문자조합으로 작성하세요");
              return false;
            }
          
          var nick = document.getElementById('nick').value;
          var regexnick = /^[가-힣]{2,10}$/;
    	  if(!regexnick.test(nick)){
        	  alert("닉네임은 한글 2~10자로 작성하세요");
              return false;
    	  }
    	  
    	  var phone = document.getElementById('phone').value;
    	  var regexphone =/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/;
    	  if(!regexphone.test(phone)){
        	  alert("전화번호를 알맞게 입력하세요");
              return false;
    	  }
          return true;
      }
</script>

<form action="join.do" method="post" onsubmit="return check();">

	<div  class="outbox" align="center">
			<h1>회원 가입</h1>
	</div>
		<div align="center">
			<font>아이디</font>
			<br>
			<input type="text" name="member_id" id="id" required  class="row" placeholder="4~12자의 영문/ 대소문자/숫자 입력">
		</div>
	        <br>
		<div align="center">
			<font>비밀번호</font>
		    <br>
			<input type="password"  name="member_pw" id="pw1" required class="row" placeholder="4~20자의 영문/ 대소문자/숫자 입력">
		</div>
			<br>
		<div align="center">
			<font>비밀번호확인</font>
			<br>
			<input type="password"  name="member_pw2" id="pw2" required class="row"  placeholder="4~20자의 영문/ 대소문자/숫자 입력">
		</div>
			<br>
		<div align="center">
			<font>닉네임</font>
			<br>
			<input type="text" name="member_nick" id="nick" required class="row"   placeholder="한글 2~10자">
		</div>
		   <br>
		<div align="center">
			<font>전화번호</font>
			<br>
			<input type="tel" name="member_phone" id="phone" class="row" placeholder="선택사항/'-' 빼고 입력해주세요.아이디 비밀번호 찾기시 사용될 수 있습니다">
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
			<input type="submit" value="가입" class="row-bottom">
		</div>
	
	<jsp:include page="/template/footer.jsp"></jsp:include>
</form>