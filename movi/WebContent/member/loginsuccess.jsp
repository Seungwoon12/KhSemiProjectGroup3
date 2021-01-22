<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>
<html>
<head>
<div class="outbox">
	<div class="row center">
		<h3>회원가입 완료</h3>
	</div>
</div>
</head>

	
			<h5 class="center">Session ID : <%=session.getId()%></h5>
			<h5 class="center">check : <%=session.getAttribute("check")%></h5>
			<h5 class="center">auth : <%=session.getAttribute("auth")%></h5>
	 
	</main>
</body>
</html>

 가입을 환영합니다.
                      
</html>


<jsp:include page="/template/footer.jsp"></jsp:include>