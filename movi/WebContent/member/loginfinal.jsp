<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:include page="/template/header.jsp"></jsp:include>  

<body>

<h2><%=session.getAttribute("id")%>님 반갑습니다 </h2>
<br>
<a href="/movi/member/Logout.jsp">로그아웃</a>
<br>
 <a href="../index.jsp">홈으로</a>
    </body>
</html>
</html>
 <jsp:include page="/template/footer.jsp"></jsp:include>

