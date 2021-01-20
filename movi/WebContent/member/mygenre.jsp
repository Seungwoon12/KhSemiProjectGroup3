<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<jsp:include page="/template/header.jsp"></jsp:include>
	
	<style>
	</style>

	<script>
	</script>
	
<%

%>
	
<form action="mygenre.do" method="get">
	<fieldset class="outbox">
		<legend>ooo 님이 선호하는 장르</legend>
		<div class="row">
			<input type="checkbox" name="genre" value="1"><label>로맨스</label>
			<input type="checkbox" name="genre" value="2"><label>범죄</label>
			<input type="checkbox" name="genre" value="3"><label>뮤지컬</label>
			<input type="checkbox" name="genre" value="4"><label>애니</label>
			<input type="checkbox" name="genre" value="5"><label>액션</label>
			<input type="checkbox" name="genre" value="6"><label>판타지</label>				
			<input type="checkbox" name="genre" value="7"><label>역사극</label>
			<input type="checkbox" name="genre" value="8"><label>전쟁</label>
			<input type="checkbox" name="genre" value="9"><label>코미디</label>
			<input type="checkbox" name="genre" value="10"><label>SF</label>
		</div>
		<div class="row">
			<input type="submit" value="전송">
		</div>
	</fieldset>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>