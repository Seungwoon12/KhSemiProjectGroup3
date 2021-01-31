<%@page import="movi.beans.MemberFindDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="/template/header.jsp"></jsp:include>


<%
String member_id = request.getParameter("member_id");
String member_phone = request.getParameter("member_phone");
MemberFindDao dao = new MemberFindDao();
String pw = dao.changePw(member_id,member_phone);

%>

<h3>임시 비밀번호는<font color="red"> <%=pw%></font>입니다</h3>



<jsp:include page="/template/footer.jsp"></jsp:include>
    