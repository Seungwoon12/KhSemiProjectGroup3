<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 인코딩값 : UTF-8 -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 패이지 네비게이션 -->
<%
	int pageSize = 10;
	int p ;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p<=0) throw new Exception();//페이지<=0일 때 강제예외
	}catch(Exception e){
		p=1;
	}
	
	//페이지 시작, 끝 번호 계산
	int endRow = p * pageSize;
	int startRow = endRow- pageSize+1;
%>

<!--회원 검색 -->
<%
	//type(분류):번호,아이디 	key:검색어
	String type= request.getParameter("type");
	String key = request.getParameter("key");
	
	boolean search = type != null && key != null;
%> 

<!--멤버 목록   -->
<%	
	ReviewAdminDao reviewDao = new ReviewAdminDao();
	List<ReviewDto> reviewList ;
	if(search){
		 reviewList = reviewDao.page_admin(type, key, startRow, endRow);
	}else{
		 reviewList = reviewDao.page_admin(startRow, endRow);
	}
%>

<!-- 페이지 블록  -->
<%
	
	//블록크기
	int blockSize = 10;
	int startBlock = (p-1)/blockSize * blockSize +1;
	int endBlock = startBlock + blockSize -1;
	
	//int count;
	//if(search){
	//	count= memberDao.count_admin(type, key); 
	//}else{
	//	count= memberDao.count_admin(); 
	//}
	//페이지 개수
	//int countSize = (count + pageSize -1) / pageSize;
	
	//if(endBlock > countSize){
	//	endBlock = countSize;
	//}
%>    
    
    
    
    
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>      
 
 <script>
	$(function(){
		//삭제시 알림창 보여주기
		$(".Delete").click(function(e){
			e.preventDefault();
			
			var check = window.confirm("회원 삭제하시겠습니까?");
			if(check){
				location.href=$(this).attr("href");
				//location.href=this.href;//this에 있는 경로로 이동해서 보내세요
			}
		});
		
		//전체선택 체크박스
		$("#checkall").click(function(){
			//클릭O
			if($("#checkall").prop("checked")){
				//각 체크박스 체크해주기
				$("input[name=chk]").prop("checked",true);
			}else{
				$("input[name=chk]").prop("checked",false);
			}
		});
		
		
		
	});

</script>
 
 
    
<div class="outbox" style="width:100%">
   <aside>
   		<div class="row center">
       		<h2 style="color:deepskyblue;">리뷰 관리</h2>     
  	 	</div>
  	 	<div class="left">
  	 		<a href="reviewList.jsp"> 리뷰리스트 </a><br><br>
  	 		<a href="#"> 리뷰 관리 </a><br><br>
  	 		<a href="#"> 리뷰 삭제 </a><br><br>
  	 	</div>
  	</aside>
	
  	<article>
  	
  	<!-- 이벤트 검색창 -->
  		<div>
  			<h1>리뷰리스트</h1>
  		</div>
  		<div>
  			<form action="reviewList.jsp" method="post">
  				<label>리뷰 검색</label>
  				<select name="type">
  					<option value="">리뷰 번호</option>
  					<option value="">리뷰 작성자</option>
  					<option value=" ">제목</option>
  				</select>
  				<input type="text" name="key" placeholder="검색어를 입력하세요" required> 
  				<input type="submit" value="검색">
  			</form>
  		</div>
 <%if(reviewList.isEmpty()){ %> 
 <!-- 검색결과가 없는 경우 -->
		<div class="row center">
			<h1>검색결과가 없습니다.</h1>
		</div>  	
 <%}else{ %>	
<!-- 검색결과가 있는 경우 -->			
  	<!--리뷰 리스트 테이블  -->	
	<div class="row">
		<table class="table table-border table-pattern">
			<thead>
				<tr>
					<th><input type="checkbox" id="checkall">전체선택</th>
					<th>리뷰 번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>

				<tr>
					<td>
						<input type="checkbox" name="chk" value="">
					</td>
					<td>리뷰 번호</td>
					<td>제목</td>
					<th>작성자</th>
					<td>작성일</td>
					<td>조회수</td>
					<td>
						<a href="#">상세보기</a>
						<a href="#">삭제</a>
						
					</td>
				</tr>
			</tbody>
			<%} %> 
		</table>
	</div>
	
	</article>
	
</div>	



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>
