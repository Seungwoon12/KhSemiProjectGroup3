<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/template/header.jsp"></jsp:include>

<%String member_id = request.getParameter("member_id"); %>
<%if(member_id !=null){ %>
찾으신 결과 아이디는 <%=member_id %> 입니다.
<a href="loginpage.jsp"><h3>로그인 하시겠습니까?</h3></a>
<%}

else {%>
해당하는 회원이 없습니다
<a href="join.jsp"><h3>회원가입을 하시겠습니까?</h3></a>
<%} %>

<jsp:include page="/template/footer.jsp"></jsp:include>
