<%@page import="movi.beans.RecommendDto"%>
<%@page import="java.util.List"%>
<%@page import="movi.beans.RecommendDtoVO"%>
<%@page import="movi.beans.RecomAdminDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<!-- 태그 이름 수정 -->
<%
	String recom_title = request.getParameter("recom_title");
	RecomAdminDao recomDao = new RecomAdminDao();
	List<RecommendDto> recomDto = recomDao.selectAll_admin(recom_title);
%> 
<script>
$(function(){
    //추가
        $(".add").click(function(){
                var a = $("#template").html();
                $(a).prev().addClass("dis");
                $(a).insertBefore(this);
            });
	//동적 삭제
        $(document).on("click",".delete",function(){
            $(this).parent().remove();
        });
    });	
</script>
<script id="template" type="text/template"> 
        <div>
			<input class="input" type="text" name="recom_movie_no">
			<input type="button" class="delete" value="삭제">
        </div>
</script>
<style>
	.input{
		width:46%;
	}
</style>
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
		<table class="table table-border" style="width:80%">
			<tr>
				<th>태그변경할 이름</th>
				<th>
					<input class="input" type="text" name="recom_title" value="<%=recom_title%>">
				</th>
			</tr>
			<tr>
				<th>영화 번호</th>
				<th>
				<div>
				<%for(RecommendDto dto : recomDto) {%>
					<div>
						<input class="input" type="text" name="recom_movie_no" value="<%=dto.getRecom_movie_no()%>">
						<input type="button" class="delete" value="삭제">
					</div>
				<%} %>
					<input type="button" class="add" style="display:block" value="추가">
				</div>	
				</th>
			</tr>
			 <tr>
			 	<td colspan="2">
			 		<input type="submit" class="adbtn green" value="수정">
			 		<input type="button" class="adbtn yellow" value="취소" onclick="location.href='recomList.jsp'">
			 	</td>
			 </tr>	
		</table>
	</article>
</div>	
</form>


<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>    