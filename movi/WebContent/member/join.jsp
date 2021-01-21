<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>	
<script>
function checkValue()
{
   
    // 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
    if(document.member_pw.value != document.membet_pwcheck.value ){
        alert("비밀번호를 동일하게 입력하세요.");
        return false;
    }
}
</script>


<form action="join.do" method="post" onsubmit="return checkValue()">
	<div class="outbox" style="width:600px">
		<div class="row center">
			<h1>회원 가입</h1>
		</div>
		<div style="text-align:center" class="row">
			<label>아이디</label>
			<br>
			<input type="text" name="member_id" required class="input" style="height:40px; width:430px"  placeholder="8~20자 영문 소문자/숫자">
		<span class="error_next_box"></span>
		</div>
		<div style="text-align:center" height="40" width="430" class="row">
			<label>비밀번호</label>
			<br>
			<input type="password" name="member_pw" required class="input" style="height:40px; width:430px" placeholder="8~20자 영문 소문자/대문자/특수문자/숫자">
		</div>
		<div style="text-align:center"height="40" width="430" class="row">
			<label>비밀번호확인</label>
			<br>
			<input type="password" name="member_pwcheck" required class="input"  style="height:40px; width:430px" placeholder="8~20자 영문 소문자/대문자/특수문자/숫자">
		</div>
		<div style="text-align:center" height="40" width="430" class="row">
			<label>닉네임</label>
			<br>
			<input type="text" name="member_nick" required class="input"  style="height:40px; width:430px" placeholder="한글 2~10자">
		</div>
		<div style="text-align:center" height="40" width="430" class="row">
			<label>전화번호</label>
			<br>
			<input type="text" name="member_phone" required class="input" style="height:40px; width:430px" placeholder="선택사항">
		</div>	
		<div style="text-align:center" class="row">
		<label>장르체크(선택사항)</label>
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
             
                
		<div class="row">
			<button type="submit"  name="login" value="회원가입" style="height:50px; width:430px;  background-color:deepskyblue; color:white; font-size:16px" onclick="login();">가입하기</button>
		</div>
	</div>
	
	<jsp:include page="/template/footer.jsp"></jsp:include>
</form>