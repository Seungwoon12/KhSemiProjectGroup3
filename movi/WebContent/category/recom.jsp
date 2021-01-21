<%@page import="movi.beans.RecommendDtoVO"%>
<%@page import="java.util.List"%>
<%@page import="movi.beans.RecommendDao"%>
<%@page import="movi.beans.RecommendDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<%
	String recom_title = request.getParameter("recom_title");
	RecommendDao recomDao = new RecommendDao();
	List<RecommendDtoVO> recomDto = recomDao.select(recom_title);
%>

<div>
	<h3>#<%=recom_title %></h3>
</div>
<div>
	<%for(RecommendDtoVO dto : recomDto) {%>
		<p><%=dto.getRecom_movie_name() %></p>
	<%} %>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>