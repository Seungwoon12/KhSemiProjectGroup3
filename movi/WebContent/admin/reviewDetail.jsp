<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>    


<!-- 상세보기 회원정보 -->
<%
	int review_no = Integer.parseInt(request.getParameter("review_no"));
	ReviewAdminDao reviewDao = new ReviewAdminDao();
	ReviewDto reviewDto = reviewDao.select_admin(review_no);
%>



<div class="outbox" style="width:100%">
   <aside>
   		<div class="row center">
       		<h2 style="color:deepskyblue;">리뷰 관리</h2>     
  	 	</div>
  	 	<div class="left">
  	 		<a href="reviewList.jsp"> 리뷰리스트 </a><br><br>
  	 		<a href="#"> 공지 등록 </a><br><br>
  	 	</div>
  	</aside>
	
  	<article>
  	
  		<div>
  			<h1>리뷰 상세보기</h1>
  		</div>

  		
  	<!--멤버 상세보기 테이블  -->	
		<div class="row center">
			<table class="table table-border" style="width:80%">
					<tr>
						<th>
							<div class="left">
								<h1>
									<%=reviewDto.getReview_title() %>							
								</h1>
							</div>
						</th>						
					</tr>
					<tr>
						<th>
							<div class="left">
								<%=reviewDto.getReview_movie_no() %>
							</div>
						</th>
					</tr>
					<tr>
						<th>
							<div class="left">
								<span><%=reviewDto.getReview_date() %></span>
							</div>
							<div class="right">
								<span><%=reviewDto.getReview_read() %></span>
							</div>
						</th>
					</tr>
					<tr style="height:500px">
						<th><%=reviewDto.getReview_content() %></th>
					</tr>
					<tr>
						<th>댓글</th>
					</tr>
					<tr>
						<td>
							<input type="button" value="댓글추가" id="editBtn" onclick="location.href='reviewDetail.jsp?review_no=<%=reviewDto.getReview_no()%>'">
							<input type="button" value="댓글삭제" id="deleteBtn" onclick="location.href=''">
						</td>
					</tr>
					<tr>
						<td><input type="button" value="리뷰삭제" id="deleteBtn" onclick="location.href='reviewDelete.do?review_no=<%=reviewDto.getReview_no()%>'"></td>
					</tr>
				</tbody>
			</table>
		</div>
			
			
			<!-- 리뷰목록으로 돌아가기 -->
		<div class="right">
			<a href="reviewList.jsp">리뷰목록으로 돌아가기</a>
		</div>
		
			
	</article>
</div>  



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>
    