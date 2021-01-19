<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movi.beans.*" %>
<%@ page import="java.util.*" %>

<%
	int review_no = Integer.parseInt(request.getParameter("review_no"));
	
	ReviewDao reviewDao = new ReviewDao();
	ReviewDto reviewDto = reviewDao.find(review_no);
	
	


%>



 <jsp:include page="/template/header.jsp"></jsp:include>
 <script>
 
 
 </script>
 
 <div class="outbox">
 	<div class="row">
 		<button>수정</button>
 		<button>삭제</button>
 	</div>
 	<hr>
 	<div class="row">
 		<h2><%=reviewDto.get %></h2>
 	</div>
 </div>
 
 
 
 <jsp:include page="/template/footer.jsp"></jsp:include>