<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<jsp:include page="/template/header.jsp"></jsp:include>  

<body>
<div class="row center">
<h3><font color="#3B83BD" size="5"><%=session.getAttribute("id")%></font>님 반갑습니다 </h3>
</div>
<br>
<div class="row center">
<a href="Logout.jsp"><font color="#4E6FA6" size="3">로그아웃</font></a>
</div>
<br>
<div class="row center">
 <a href="my.jsp"><font color="#4E6FA6" size="3">마이페이지가기</font></a>
 </div>
    </body>
</html>
</html>
 <jsp:include page="/template/footer.jsp"></jsp:include>

