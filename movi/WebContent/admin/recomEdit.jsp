<%@page import="movi.beans.RecommendDtoVO"%>
<%@page import="movi.beans.RecomAdminDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- 태그 이름 수정 -->
<%
	String recom_title = request.getParameter("recom_title");
	RecomAdminDao recomDao = new RecomAdminDao();
	RecommendDtoVO recomDto = recomDao.selectAll_admin(recom_title);
%>
    
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<form action="recomEdit.do" method="post">

<div class="outbox" style="width:100%">
	<aside>
		<div class="row center " >
			<h2 style="color: #4B89DC;" >영화 관리</h2>
		</div>
		<div class="left ">
			<a href="movieList.jsp"> 영화리스트 </a><br><br> 
			<a href="movieInsert.jsp"> 영화 등록 </a><br><br>
			<a href="actorList.jsp"> 배우 리스트 </a><br><br>
			<a href="actorInsert.jsp"> 배우 등록 </a><br><br>
			<a href="recomList.jsp"> 3조 추천 영화 리스트 </a><br><br>
			<a href="recomList.jsp"> 3조 추천 영화 등록 </a><br><br>
		</div>
	</aside>
	
  	<article>	
		<table>
			<tr>
				<th>태그변경할 이름</th>
				<th>
					<input type="text" name="recom_title" placeholder="<%=recom_title%>">
				</th>
			</tr>
			<tr>
				<th>태그 전 이름</th>
				<th>	
					<input type="hidden" name="recom_title" value="<%=recomDto.getRecom_title()%>">
					<%=recomDto.getRecom_title() %>
				<th>

				</th>
			 </tr>
			 <tr>
			 	<td colspan="2">
			 		<input type="submit" value="수정">
			 		<input type="button" value="취소" onclick="location.href='recomList.jsp'">
			 	</td>
			 </tr>
		
		
		</table>


	</article>
	
</div>	

</form>





<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>    