<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="movi.beans.*"%>

  
<jsp:include page="/template/header.jsp"></jsp:include>
	
	<style>
	</style>
	
<%
	int member_no = (int)session.getAttribute("check");
	
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.find(member_no);
	
	MygenreDao mygenreDao = new MygenreDao();
	
	GenreDao genreDao = new GenreDao();
	List<GenreDto> genreList = genreDao.view();
	
	List<MygenreDtoVO> mygenre_DtoVO_list = mygenreDao.find_no(member_no);
	
	//선호 장르를 바꾸기 전에 전에 선택했던 선호 장르들은 선택된 상태로 보여주는 구문
	for(MygenreDtoVO mygenreDtoVO : mygenre_DtoVO_list) {
		for(int i = 1; i <= 10; i++) { %>
			<script>
				$(function(){
					console.log($("input[value=<%=i%>]").attr("value"));
					console.log(<%=mygenreDtoVO.getMygenre_genre_no()%>);
					
					if($("input[value=<%=i%>]").attr("value") == <%=mygenreDtoVO.getMygenre_genre_no()%>){
						$("input[value=<%=i%>]").attr("checked", "checked");
					}
				});
			</script>
		<%}
	} %>
	
	
<form action="mygenre.do" method="get">
	<fieldset class="outbox">
		<legend><%=memberDto.getMember_nick()%> 님이 선호하는 장르</legend>
		<div class="row">
			
			<%for(GenreDto genreDto : genreList) {%>
			<input type="checkbox" name="genre" value="<%=genreDto.getGenre_no()%>" id="<%=genreDto.getGenre_no()%>">
			<label for="<%=genreDto.getGenre_no()%>"><%=genreDto.getGenre_name()%></label>
			<%} %>
						
		</div>
		<div class="row">
			<input type="submit" value="전송">
		</div>
	</fieldset>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>