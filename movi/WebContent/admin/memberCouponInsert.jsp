<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!-- 이벤트 참여 없이 관리자 권한으로 쿠폰을 지급할 수 있는 기능 -깜짝 쿠폰 -->



<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<form action="couponInsert.do" method="post">
	<div class="outbox" style="width: 100%">
	<aside>
		<div class="row center">
			<h2 style="color: deepskyblue;">회원 관리</h2>
		</div>
		<div class="left">
			<a href="memberList.jsp">회원리스트 </a><br>
			<br> <a href="memberPwSearch.jsp"> 임시 비밀번호 발급 </a><br>
			<br> <a href="#"> 회원 쿠폰 관리 </a>
			<br><br> <a href="memberCouponList.jsp">쿠폰 목록</a>
			<br><br> <a href="memberCouponInsert.jsp">쿠폰 등록</a>
		</div>
	</aside>

		<article>

			<div>
				<h1>회원 쿠폰  지급</h1>
			</div>

			<!--쿠폰 추가 테이블  -->
			<div class="row center">
				<table class="table table-border" style="width: 80%">
					<thead>
						<h4 class="left">등록 정보 입력</h4>
					</thead>
					<tbody>
						<tr>
							<th style="width:30%">회원 번호</th>
							<td>
								<input type="text" name="event_member_no" required>
							</td>
						</tr>
						<tr>
							<th>이벤트</th>
							<td>
								<input type="text" name="event_name" required> 
							</td>
						</tr>
						<tr>
							<th>이벤트 내용</th>
							<td>
								<input type="text" name="event_content" required>
							</td>
						</tr>
						<tr>
							<th>쿠폰</th>
							<td>
								<select name="event_coupon" required>
									<option>꽝</option>
									<option>영화예매권</option>
									<option>바나나우유</option>
									<option>비타500</option>
									<option>CGV10%할인</option>
									<option>abc초콜릿</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>쿠폰 기간</th>
							<td>
								<input type="date" name="event_start" required>~
								<input type="date" name="event_end" required>							
							</td>
						</tr>
						<tr>
							<th colspan="2">
								<div >
									<input type="submit" value="등록" >
									<input type="button" value="취소" onclick="location.href='memberCouponList.jsp'">
								</div>
							</th>
						</tr>

					</tbody>
				</table>
			</div>
		</article>
	</div>

</form>

<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>    