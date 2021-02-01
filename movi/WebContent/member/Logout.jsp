<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta http-equiv="refresh" content="6;url=../index.jsp">
<%@page import="movi.beans.*"%>

 <% request.getSession().invalidate();
 %>

  
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
<jsp:include page="/template/header.jsp"></jsp:include>
</head>
<body> 
  
<div align="center"><font color="#3B83BD" size="5"> 로그아웃 되었습니다</font></div>

<br><br>
<div align="center"><font size=3>안녕히가세요</font></div>
<div align="center"><font size=3>잠시후 메인페이지로 돌아갑니다</font></div>



</body>
</html>
<jsp:include page="/template/footer.jsp"></jsp:include>