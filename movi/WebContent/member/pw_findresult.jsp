<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%String member_pw = request.getParameter("member_pw"); %>
<%if(member_pw!=null){ %>
임시비밀번호는 입니다
<a href="joinpage.jsp"><h3>로그인 하시겠습니까?</h3></a>
<%}

else {%>
해당하는 회원이 없습니다
<a href="join.jsp"><h3>회원가입을 하시겠습니까?</h3></a>
<%} %>
