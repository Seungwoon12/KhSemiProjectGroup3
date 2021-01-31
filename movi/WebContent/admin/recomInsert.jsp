<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 3조 태그 생성 및 기존태그에 영화 추가하기 -->


<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<script>
	$(function() {
		//추가
		$(".add").click(function() {
			var a = $("#template").html();
			$(a).insertBefore(this);
		});
		//동적 삭제
		$(document).on("click", ".delete", function() {
			$(this).parent().remove();
		});
	});
</script>
<script id="template" type="text/template"> 
        <div>
			<input class=" row1 " type="text " name="recom_movie_no">
			<input type="button" class="delete adbtn red " value="X">
        </div>
</script>
<style>
.input {
	width: 50%;
}
</style>
<div class="outbox" style="width: 100%">
	<aside>
		<div class="row center ">
			<h2 style="color: #4B89DC;">영화 관리</h2>
		</div>
		<div class="left ">
			<a href="movieList.jsp"> 영화리스트 </a><br>
			<br> <a href="movieInsert.jsp"> 영화 등록 </a><br>
			<br> <a href="actorList.jsp"> 배우 리스트 </a><br>
			<br> <a href="actorInsert.jsp"> 배우 등록 </a><br>
			<br> <a href="recomList.jsp"> 3조 추천 영화 리스트 </a><br>
			<br> <a href="recomInsert.jsp"> 3조 추천 영화 등록 </a><br>
			<br>
		</div>
	</aside>

	<form action="recomInsert.do" method="post">
		<article>
			<div>
				<h1>3조 추천태그 생성</h1>
			</div>

			<div>
				<table class="table2  table" style="width: 80%; margin: 10%">
					<tbody>
						<tr>
							<th class="left">태그 이름</th>
						</tr>
						<tr>
							<td><input type="text" class="row1" name="recom_title"
								required></td>
								
						</tr>
						<tr><th class="left">추가할 영화 번호</th></tr>
						<tr>		
							<td>
								
								<div>
									<div>
										<input class=" row1 " type="text" name="recom_movie_no">
										<input type="button" class="delete adbtn red" value="x">
									</div>
									<input type="button" class="add adbtn gray"
										style="display: block" value="추가">
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<hr> <input type="submit" class="adbtn green" value="등록">
								<input type="button" class="adbtn yellow" value="취소"
								onclick="location.href='recomList.jsp'">
							</td>
						</tr>
					</tbody>
				</table>
			</div>

		</article>



	</form>

</div>

<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>
