  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="movi.beans.MemberDao"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% //값불러오기
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("member_id");

MemberDao dao = new MemberDao();

boolean result = dao.confirm(id);
if(result){ 
	out.println("아이디중복"); 
 	}else{
	out.println("사용 가능한 아이디입니다"); 
	out.println("<a href='javascript:apply(\"" + id + "\")'>[사용하기]</a>"); }
%> 

<script> 
function apply(id){  
	opener.document.join.id.value=id; 
	window.close();
	}
</script> 
