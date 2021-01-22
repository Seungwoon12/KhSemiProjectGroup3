<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<% %>

    
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>    


<div class="outbox" style="width:100%">
   <aside>
   		<div class="row center">
       		<h2 style="color:deepskyblue;">관리자 페이지</h2>     
  	 	</div>
  	 	<div class="left">
  	 		<a href="#">-   통계 </a>
  	 	</div>
  	</aside>
	
  	<article>
  		<div>
  			<h1>통계</h1>
  		</div>
  		<table>
  			<tr>
  				<th colspan="2">
  				  	<div>
  						<h1>방문자 수</h1>
  					<img src="https://placehold.it/600x300?text=IMAGE">
  					</div>
  				</th>
  			</tr>
  			<tr>
  				<th>
  				 	<div>
  						<h1>장르별 좋아요 현황</h1>
  						<img src="https://placehold.it/300x300?text=IMAGE">
  					</div>
  				</th>
  				<th>
  				  	<div>
  						<h1>인기 검색어</h1>
  						<img src="https://placehold.it/300x300?text=IMAGE">
  					</div>
  				</th>
  			</tr>
  		</table>
  	</article>
</div>



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>