<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
	.dum{
		width: 100%;
		min-width: 300px;
	}
</style>

<jsp:include page="/template/header.jsp"></jsp:include>	

<div class="outbox">
	<div class="row">
		<table class="table table-border">
			<tbody>
				<tr>
					<td style="width: 30%">
						<img src="https://placeimg.com/150/150/people">
					</td>
					<td>
						<div>
							<h2>OOOOOO님</h2>
							<h5>방문해 주셔서 감사합니다.(멘트 추천좀)</h5>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="row center">
		<input type="button" class="input input-inline" value="내 정보 수정">
		<input type="button" class="input input-inline" value="선호 장르 변경">
		<input type="button" class="input input-inline" value="비밀 번호 변경">
		<input type="button" class="input input-inline" value="회원 탈퇴">
	</div>
	<div class="row float-box">
		<span>좋아요 누른 영화</span>
		<div class="right-btn">
			<a href="#">더보기</a>
		</div>
	</div>
	<div class="row center">
		<img class="dum" src="https://placeimg.com/600/350/any">
	</div>
	<div class="row float-box">
		<span>참여한 이벤트</span>
		<div class="right-btn">
			<a href="#">더보기</a>
		</div>
	</div>
	<div class="row center">
		<img class="dum" src="https://placeimg.com/600/350/people">
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>