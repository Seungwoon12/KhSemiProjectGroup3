     <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
      <div>
         
      
         <h5 class="center">Session ID : <%=session.getId()%></h5>
         <h5 class="center">check : <%=session.getAttribute("check")%></h5>
         <h5 class="center">auth : <%=session.getAttribute("auth")%></h5>
      </div>
      

<html>   
<body>
        <h1> <small>반갑습니다.</small></h1>
        <a href="logout.jsp">로그아웃</a>
        <a href="../index.jsp">홈으로</a>
    </body>
</html>
</html>