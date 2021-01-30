<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 영화 기본정보 등록하기 -->

<jsp:include page="/adminTemplate/header.jsp"></jsp:include>
<%
	int movie_no = Integer.parseInt(request.getParameter("movie_no"));
%>
<script>
$(function(){
    //추가
        $(".add1").click(function(){
                var a = $("#template1").html();
                $(a).insertBefore(this);
            });
        $(".add2").click(function(){
            var a = $("#template2").html();
            $(a).insertBefore(this);
        });
	//동적 삭제
        $(document).on("click",".delete",function(){
                $(this).parent().remove();
            });
    });	
</script>
    <script id="template1" type="text/template"> 
        <div>
            <input class="input" type="text" name="main_actor">
			<input type="button" class="delete" value="삭제">
        </div>
    </script>
    <script id="template2" type="text/template"> 
        <div>
            <input class="input" type="text" name="sub_actor">
			<input type="button" class="delete" value="삭제">
        </div>
    </script>
<style>
	.input{
		width:46%;
	}
</style>
	<div class="outbox" style="width: 100%">
		<aside>
			<div class="row center">
				<h2 style="color: deepskyblue;">영화 관리</h2>
			</div>
			<div class="left">
			<a href="movieList.jsp"> 영화리스트 </a><br><br> 
			<a href="movieInsert.jsp"> 영화 등록 </a><br><br>
			<a href="actorList.jsp"> 배우 리스트 </a><br><br>
			<a href="actorInsert.jsp"> 배우 등록 </a><br><br>
			<a href="recomList.jsp"> 3조 추천 영화 리스트 </a><br><br>
			<a href="recomInsert.jsp"> 3조 추천 영화 등록 </a><br><br>
			</div>
		</aside>

		<article>
			<!--영화 추가 테이블  -->			

			
		<form action="actorConInsert1.do" method="post">
			<div class="row center">
				<table class="table table-border" style="width: 80%">
					<thead>
						<h1 class="left">영화 배우 추가하기(배우 고유번호로 입력하세요)</h1>
						<input type="hidden" name="movie_no" value="<%=movie_no%>">
					</thead>
					<tbody>
						<tr>
							<th style="width:30%">주연 배우</th>
							<td>
							<div>
								<div>
									<input class="input" type="text" name="main_actor">
									<input type="button" class="delete" value="삭제">
								</div>
								<input type="button" class="add1" style="display:block" value="추가">
							</div>
							</td>
						</tr>
						<tr>
							<th>조연 배우</th>
							<td>
								<div>
									<div>
										<input class="input" type="text" name="sub_actor">
										<input type="button" class="delete" value="삭제">
									</div>
									<input type="button" class="add2" style="display:block" value="추가">
								</div>
							</td>
						</tr>
						<tr >
							<td colspan="2">
								<input type="submit" class="adbtn green" value="등록">
								<input type="button" class="adbtn yellow" value="취소" onclick="location.href='movieList.jsp'">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>	
		</article>
	</div>



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>