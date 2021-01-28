<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 403에러페이지 -->

<jsp:include page="/template/header.jsp"></jsp:include>

<div class="outbox center" style="width:800px">
	<div class="row">
		<h2>이용 권한이 없습니다</h2>
	</div>
	<div class="row">
		<img alt="403에러이미지" src="../img/403error.png" width="100%" height="600">
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>