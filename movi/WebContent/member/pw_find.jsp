<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<jsp:include page="/template/header.jsp"></jsp:include>

<script>
	function check() {
		var id = document.getElementById('id').value;
  	  var regexid = /^[a-z][a-z0-9]{6,19}$/;
  	  if(!regexid.test(id)){
      	  alert("아이디는 6~20자 이내로 작성하세요");
            return false;;
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

<div align="center"> 
   <h2>비밀번호 재설정</h2></div>
<form action="pw_find.do" method="get">
  <div align="center">
 <p><font color="#3B83BD" size="5">아이디</font></p><input type="text"  name="member_id"  id="nick" placeholder="아이디를 입력해주세요" required class="outbox" style="height:50px; width:430px; "></input>
<p><font color="#3B83BD" size="5">전화번호</font></p><input type="tel"  name="member_phone" id="phone" placeholder=" - 를 제외한 번호 전체를 입력해주세요." required class="outbox" style="height:50px; width:430px;"></input>
  </div>
  <br><br>
          <br><br>
           <div align="center">
        <input type="submit"  value="찾기"  class="outbox2"  style=" height:50px; width:430px;background-color:#3B83BD; color:white; font-size:15px; border-radius:1.5em;border:0;outline:0;"></input>   
         </div>                                  
 </form>
 
<jsp:include page="/template/footer.jsp"></jsp:include>