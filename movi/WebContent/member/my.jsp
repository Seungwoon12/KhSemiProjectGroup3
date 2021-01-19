<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>	
    
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/swiper.css">
<script src="<%=request.getContextPath()%>/js/swiper.js"></script>
 
<style>
	.outbox{
		width: 66%;
		min-width: 500px;
	}
	.right-btn {
		display: inline-block;
		float: right;
	}
	.float-box::after {
        content:"";
        display:block;
    	clear:both;
	}
	
	div{
		border: none;
	}
</style>

<script>
	$(function(){
		$(".edit-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/member/edit.jsp";
		});
		$(".myGenre-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/member/mygenre.jsp";
		});
		$(".editPw-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/member/editpw.jsp";
		});
		//.del-btn을 누르면 경고창이 나오고 확인을 누르면 멤버 삭제로 이동
		$(".del-btn").click(function(){
			if(window.confirm("정말로 탈퇴하시겠습니까?")){
				location.href = "<%=request.getContextPath()%>/member/delete.do";
			}
		});
	});
</script>

<div class="outbox">
	<div class="row">
		<table class="table table-border">
			<tbody>
				<tr>
					<td style="width: 30%">
						<img src="https://placeimg.com/150/150/people">
					</td>
					<td rowspan="2">
						<div>
							<h2>OOOOOO님</h2>
							<h5>방문해 주셔서 감사합니다.(멘트 추천좀)</h5>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<input type="button" class="input input-inline" value="프로필 변경">
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="row center">
		<input type="button" class="input input-inline edit-btn" value="내 정보 수정">
		<input type="button" class="input input-inline myGenre-btn" value="선호 장르 변경">
		<input type="button" class="input input-inline editPw-btn" value="비밀 번호 변경">
		<input type="button" class="input input-inline del-btn" value="회원 탈퇴">
	</div>
	<div class="row float-box">
		<span>좋아요 누른 영화</span>
		<div class="right-btn">
			<a href="#">더보기</a>
		</div>
	</div>
	<div class="row center">
		<div class="swiper-container swiper1">
	        <div class="swiper-wrapper">
	            <div class="swiper-slide">
					<img class="dum" src="https://placeimg.com/600/350/any">
				</div>
	            <div class="swiper-slide">
					<img class="dum" src="https://placeimg.com/600/350/tech">
				</div>
	            <div class="swiper-slide">
					<img class="dum" src="https://placeimg.com/600/350/animals">
				</div>
	            <div class="swiper-slide">
	            	<img class="dum" src="https://placeimg.com/600/350/nature">
	            </div>
	            <div class="swiper-slide">
	            	<img class="dum" src="https://placeimg.com/600/350/architecture">
	            </div>
	        </div>
	        <div class="swiper-button-prev"></div>
	        <div class="swiper-button-next"></div>
	        <div class="swiper-pagination"></div>
	    </div>
	</div>
	<div class="row float-box">
		<span>참여한 이벤트</span>
		<div class="right-btn">
			<a href="#">더보기</a>
		</div>
	</div>
	<div class="row center">
		<div class="swiper-container swiper2">
	        <div class="swiper-wrapper">
	            <div class="swiper-slide">
					<img class="dum" src="https://placeimg.com/600/350/any">
				</div>
	            <div class="swiper-slide">
					<img class="dum" src="https://placeimg.com/600/350/tech">
				</div>
	            <div class="swiper-slide">
					<img class="dum" src="https://placeimg.com/600/350/animals">
				</div>
	            <div class="swiper-slide">
	            	<img class="dum" src="https://placeimg.com/600/350/nature">
	            </div>
	            <div class="swiper-slide">
	            	<img class="dum" src="https://placeimg.com/600/350/architecture">
	            </div>
	        </div>
	        <div class="swiper-button-prev"></div>
	        <div class="swiper-button-next"></div>
	        <div class="swiper-pagination"></div>
	    </div>
	</div>
	
	<script>
	var swiper = new Swiper('.swiper-container', {
	    pagination: '.swiper-pagination',
	    paginationClickable: true,
	    spaceBetween: 30
	});
	var swiper = new Swiper('.swiper1', {
		nextButton: '.swiper-button-next',
	    prevButton: '.swiper-button-prev',
	});
	var swiper = new Swiper('.swiper2', {
		nextButton: '.swiper-button-next',
	    prevButton: '.swiper-button-prev',
	});
</script>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>