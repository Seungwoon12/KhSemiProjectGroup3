<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<script>
function check() {
 var nick = document.getElementById('nick').value;
          var regexnick = /^[가-힣]{2,10}$/;
    	  if(!regexnick.test(nick)){
        	  alert("닉네임은 한글 2~10자로 작성하세요");
              return false;
    	  }
    	  
    	  var phone = document.getElementById('phone').value;
    	  var regexphone =/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/;
    	  if(!regexphone.test(phone)){
        	  alert("전화번호형식이 틀립니다");
              return false;
    	  }
    	  return true;
}

</script>
<body>
<form  action="Id_find.do" method="post" onsubmit="return check();">
 <div align="center"> 
   <h2>아이디 찾기</h2></div>
   <div align="center"> 
  <p>닉네임</p><input type="text"  name="member_nick"  id="nick" placeholder="닉네임을 입력해주세요" required class="outbox" style="height:50px; width:430px;" ></input>
 <p>전화번호</p><input type="tel" name="member_phone" id="phone" placeholder=" - 를 제외한 번호 전체를 입력해주세요." required class="outbox" style="height:50px; width:430px;" ></input>
   </div>
  <br><br>
     <br><br>
    <div align="center"> 
        <input type="submit"   value="찾기"  class="outbox2"  style=" height:50px; width:430px;background-color:#3B83BD; color:white; font-size:15px; border-radius:1.5em;border:0;outline:0;"></input>                                     
</div> </form>
 
 </body>
<jsp:include page="/template/footer.jsp"></jsp:include>