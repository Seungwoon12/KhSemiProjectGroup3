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


<style>
 		.main,
        .main ul{
            list-style: none;
            margin: 0;
            padding: 30px;
        }
        .main{
        	width :100%;
        }
        .list{
        	display:none;
        	width:215px;
        	padding :0.5rem;
        }
</style>

<div>
	<h1>#<%=recom_title %></h1>
</div>

<script>
	$(document).ready(function(){
		$(".list").slideDown(500);
		$(".list").css("display","inline-block");
	});
</script>

<ul class="main movie_list">
		<%for(RecommendDtoVO dto : recomDto) {%>
       <li class="list">
			<a href="detail.jsp?movie_no=<%=dto.getRecom_movie_no()%>">
			<img src ="https://placehold.it/200X300?text=IMAGE">
				<%=dto.getRecom_movie_name() %>
			</a>
       </li>
		<%}%>
</ul>

<jsp:include page="/template/footer.jsp"></jsp:include>