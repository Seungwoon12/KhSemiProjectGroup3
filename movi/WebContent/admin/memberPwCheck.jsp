<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/adminTemplate/header.jsp"></jsp:include>


<div class="outbox" style="width: 100%">
	<aside>
		<div class="row center">
			<h2 style="color: deepskyblue;">회원 관리</h2>
		</div>
		<div class="left">
			<a href="memberList.jsp">회원리스트 </a><br>
			<br> <a href="#"> 임시 비밀번호 발급 </a><br>
			<br> <a href="#"> 회원 쿠폰 관리 </a>
		</div>
	</aside>

	<article>

		<div>
			<h1>임시 비밀번호 발급</h1>
		</div>

		<div class="outbox center" style="width: 500px">

			<div class="row">
				<h2>임시 비밀번호 생성</h2>
			</div>

			<table>
				<tr>
					<td style="height:100px">선택한 전송방식으로 회원에게 임시 비밀번호를 전송합니다.</td>
				</tr>
				<tr>
					<td style="height:150px">
					<label>전송방식</label> 
					<input class="" type="checkbox">
					<label>전화번호로 발송 </label>
					</td>
				</tr>
				<tr>
					<td style="height:100px">
					<input type="button" value="확인" onclick="location.href='memberPw.jsp'">
					 <input type="button" value="취소" onclick="location.href='memberList.jsp'">
					 </td>
				</tr>

			</table>

		</div>

	</article>
</div>




<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>
