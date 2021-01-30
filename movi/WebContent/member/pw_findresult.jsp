<%@page import="movi.beans.MemberFindDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
    
   
   <%
           String member_phone = request.getParameter("member_phone");
           
             MemberFindDao dao =new MemberFindDao();
           
           String member_pw = dao.changePw(member_phone);
           
   %>
   
   
    <h1>임시 비밀번호 </h1>
    <h2><%=member_pw %></h2>
    
    
