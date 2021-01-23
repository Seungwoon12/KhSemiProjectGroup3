<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>   
<!DOCTYPE html>
<script>

</script>
<form action="login.do" method="post">
<div class="outbox" height="40" width="430">
         <h1 align="center" style="padding: 0 0 30px 0;">MOVI 로그인</h1></div>
   <table align="center" height="40" width="430">  
         <tr>
              <td><input type="text" name="member_id" class="input" style="height:40px; width:430px" placeholder="아이디"  required></td>
         </tr> 
  </table>

 <table align="center" height="40" width="430"> 
          <tr>
              <td><input type="password" name="member_pw" class="input" style="height:40px; width:430px" placeholder="비밀번호" required ></td>
         </tr>  
 </table>
 
 <%if(request.getParameter("error")!=null){ %>
   <!-- 오류 메세지 -->
   <div align="center" style="color:red;" >
              아이디 또는 비밀번호가 맞지않습니다.
   </div>
   <%} %>
   
<table align="center" height="40">
       <tr>
             <td><input type="submit" value="로그인" class="input" style="height:50px; width:430px;  background-color:skyblue; color:white; font-size:16px; "></td>
      </tr>
 </table>
 
<table align="center" height="50"  class="message">
  <tr>
   <td><a href="/movi/member/join.jsp"> 회원가입 | </a></td> 
   <td><a href="/movi/member/Idfind.jsp"> 아이디 찾기 |</a></td>
   <td><a href="/movi/member/pwfind.jsp"> 비밀번호 재설정</a></td>
  </tr>
  </table>
             
</form>
 <jsp:include page="/template/footer.jsp"></jsp:include>
