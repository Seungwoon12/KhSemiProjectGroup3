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

<% 
 request.setCharacterEncoding("euc-kr"); 
 String member_id = request.getParameter("member_id"); //getParameter()값받기
%>


<font color="blue" ><%=member_id %></font> 님 가입을 환영합니다.
                      
</html>


<jsp:include page="/template/footer.jsp"></jsp:include>