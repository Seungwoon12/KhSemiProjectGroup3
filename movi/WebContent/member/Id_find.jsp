<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>



 <div align="center" height="40" width="430"> 
    <h2>아이디 찾기</h2>
<form  action="Id_find.do" method="post">
         <p>닉네임:</p><input type="text"  name="member_nick"  placeholder="닉네임을 입력해주세요" required class="outbox" style="height:50px;
width:70%;"></input>    
       <p> 전화번호:</p><input type="tel"  name="member_phone" placeholder=" - 를 제외한 번호 전체를 입력해주세요." class="outbox" style="height:50px; width:70%;" ></input>
         <br><br>
         <input type="submit"  value="찾기"  class="outbox2"  style=" height:50px; width:430px;background-color:#3B83BD; color:white; font-size:15px; border-radius:1.5em;"></input>    
                           
 </form>
    
<jsp:include page="/template/footer.jsp"></jsp:include>