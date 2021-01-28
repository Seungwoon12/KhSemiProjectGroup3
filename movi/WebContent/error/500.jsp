<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<!-- 500 에러페이지 -->
<div class="outbox center" style="width:800px">
	<div class="row">
		<h2>일시적인 서버 오류가 발생했습니다</h2>
	</div>
	<div class="row">
		<img alt="오류이미지" src="../img/500error.png" width="100%" height="600">
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>