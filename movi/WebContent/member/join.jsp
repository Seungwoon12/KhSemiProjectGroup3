<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>	
   
<script>
// 회원가입 유효성 검사
 $(function(){
            //각각의 창들에 대한 처리(blur)
             //this : 아이디입력창
            $("input[name=id]").blur(function(){
           
                var id = $(this).val();
                var regex = /[a-z][a-z0-9]{5,19}/;//정규표현식
                if(regex.member(id)){
                    $(this).next().text("올바른 형식입니다");
                    $(this).addClass("correct");
                }
                else{
                    $(this).next().text("아이디는 6~20자 이내로 작성하세요");
                    $(this).removeClass("correct");
                }
            });

            $("input[name=pw]").blur(function(){
                var pw = $(this).val();
                var regex = /^[a-zA-Z0-9!@#$]{8,20}$/;
                if(regex.member(pw)){
                    $(this).next().text("올바른 비밀번호 형식입니다");
                    $(this).addClass("correct");
                }
                else{
                    $(this).next().text("비밀번호는 8~20자 영문,숫자,!@#$로 작성하세요");
                    $(this).removeClass("correct");
                }
            });

            $("input[name=nick]").blur(function(){
                var nick = $(this).val();
                var regex = /[가-힣]{2,10}/;
                if(regex.member(nick)){
                    $(this).next().text("올바른 닉네임입니다");
                    $(this).addClass("correct");
                }
                else{
                    $(this).next().text("닉네임은 한글 2~10자만 가능합니다");
                    $(this).removeClass("correct");
                }
            });
            
            $(".form").submit(function(e){
                e.preventDefault();
                $(".row").blur();

</script>
</head>

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
 
<form action="join.do" method="post" >
	<div  class="outbox" align="center">
			<h1>회원 가입</h1>
	</div>
		<div align="center">
			<font>아이디</font>
			<br>
			<input type="text" name="id" required  class="row" placeholder="4~12자의 영문/ 대소문자/숫자 입력">
		<span class="error_next_box"></span>
		</div>
	        <br>
		<div align="center">
			<font>비밀번호</font>
		    <br>
			<input type="password" name="pw" required class="row" placeholder="4~20자의 영문/ 대소문자/숫자 입력">
		</div>
			<br>
		<div align="center">
			<font>비밀번호확인</font>
			<br>
			<input type="password" name="pw2" required class="row"  placeholder="4~20자의 영문/ 대소문자/숫자 입력">
		</div>
			<br>
		<div align="center">
			<font>닉네임</font>
			<br>
			<input type="text" name="nick" required class="row"   placeholder="한글 2~10자">
		</div>
		   <br>
		<div align="center">
			<font>전화번호</font>
			<br>
			<input type="text" name="member_phone" class="row" placeholder="선택사항/아이디 비밀번호 찾기시 사용될수 있습니다">
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
			<input type="submit" value="login"class="row-bottom" onclick="join2();">
		</div>
	
	<jsp:include page="/template/footer.jsp"></jsp:include>
</form>