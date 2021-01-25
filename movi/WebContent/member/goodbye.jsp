<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>	

<div class="outbox">
	<div class="row center">
		<h1>회원 탈퇴가 완료되었습니다</h1>
		<h5>이용해 주셔서 감사합니다</h5>
		<h5>다음에 다시 만나요</h5>
	</div>
	<div class="row center">
		<img class="dum" src="https://placeimg.com/600/350/any">
		<br>
		<a href="<%=request.getContextPath()%>">
			메인으로 돌아가기
		</a>
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>