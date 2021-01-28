<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <!-- 인코딩값 : UTF-8 -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 페이지 네비게이션 -->
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
 
 <!-- 배우 검색  -->
<%
	//type(분류):배우 번호, 배우이름 	key:검색어
	String type= request.getParameter("type");
	String key = request.getParameter("key");
	
	boolean search = type != null && key != null;
%>
<!-- 배우 목록  -->
<%
	ActorAdminDao actorDao = new ActorAdminDao();
	List<ActorDto> actorList;
	if(search){
		actorList = actorDao.page_admin(type, key, startRow, endRow);
	}else{
		actorList = actorDao.page_admin(startRow, endRow);
	}
	

%>	
    
    
 <!-- 페이지 블록  -->
<%
	//블록크기
	int blockSize = 10;
	int startBlock = (p-1)/blockSize * blockSize +1;
	int endBlock = startBlock + blockSize -1;
	
	int count;
	if(search){
		count= actorDao.count_admin(type, key);
	}else{
		count= actorDao.count_admin();
	}
	// 페이지 개수
	int countSize = (count + pageSize -1) / pageSize;
	
	if(endBlock > countSize){
		endBlock = countSize;
	}
%>   
    
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<!--배우 삭제시 알림 구현  -->
<script>
	$(function(){
		//삭제시 알림창 보여주기
		$(".delete").click(function(e){
			e.preventDefault();
			
			var check = window.confirm("배우를 삭제하시겠습니까?");
			if(check){
				location.href=$(this).attr("href");
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

<div class="outbox" style="width: 100%">
	<aside>
		<div class="row center">
			<h2 style="color: deepskyblue;">영화 관리</h2>
		</div>
		<div class="left">
			<a href="movieList.jsp"> 영화리스트 </a><br><br> 
			<a href="movieInsert.jsp"> 영화 등록 </a><br><br>
			<a href="actorList.jsp"> 배우 리스트 </a><br><br>
			<a href="#"> 배우 등록 </a><br><br>
			<a href="#"> 3조 추천 영화 리스트 </a><br><br>
			<a href="#"> 3조 추천 영화 등록 </a><br><br>
		</div>
	</aside>

	<article>
		<!-- 배우 검색창 -->
		<div>
			<h1>배우 리스트</h1>
		</div>
		<div>
			<form action="actorList.jsp" method="post">
				<label>배우 검색</label> 
				<select name="type">
					<option value="actor_no">배우 번호</option>
					<option value="actor_name">배우 이름</option>
				</select>
				<input type="text" name="key" placeholder="검색어를 입력하세요" required> 
				<input type="submit" value="검색">
			</form>
		</div>
		
 <% if(actorList.isEmpty()){ %> 
 <!-- 검색결과가 없는 경우 -->
		<div class="row center">
			<h1>검색결과가 없습니다.</h1>
		</div>
 <%}else{ %>	
<!-- 검색결과가 있는 경우 --> 
		<!--배우 리스트 테이블  -->
		<div class="row">
			<table class="table1" style="width: 1000px">
				<thead>
					<tr>
						<th><input type="checkbox" id="checkall">전체선택</th>
						<th>배우번호</th>
						<th>배우 이름</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<%for(ActorDto actorDto : actorList){ %>
					<tr>
						<td><input type="checkbox" name="chk"></td>
						<td><%=actorDto.getActor_no() %></td>
						<td><%=actorDto.getActor_name() %></td>
						<td>
							<a class="abtn purple" href="actorDetail.jsp?actor_no=<%=actorDto.getActor_no()%>">상세보기</a>
						 	<a class="abtn green" href="actorEdit.jsp?actor_no=<%=actorDto.getActor_no()%>">수정</a>
						 	 <a class="delete abtn red" href="actorDelete.do?actor_no=<%=actorDto.getActor_no() %>">삭제</a>
						</td>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>
 <%} %>		
		<!-- 선택된 배우 삭제버튼 -->
		<div class="right">
			<input type="button" value="선택된 배우 삭제" >
		</div>
		
		<!-- 페이지 네비게이션 -->
		<div class="row center">
			<ul class="pagination">
				

				<%if(search){ %>
				<li><a href="actorList?p=<%=startBlock-1%>&type=<%=type%>&key=<%=key%>">&lt;</a></li>
				<%}else{ %>
				<li><a href="actorList?p=<%=startBlock-1%>">&lt;</a></li>
				<%} %>
								

				<%for(int i=1; i<=endBlock;i++){ %>
					<li>
						<%if(search){ %>
						<!-- 검색용 링크 -->
						<a href="actorList.jsp?p=1&type=<%=i%>&key=<%=key%>"><%=i %></a>
						<%}else{ %>
						<!-- 목록용 링크 -->
						<a href="actorList.jsp?p=<%=i%>"><%=i%></a>
						<%} %>
					</li>	
				<%} %>

				<!-- 이후 -->
				<%if(search){ %>
				<li><a href="actorList.jsp?p=<%=endBlock+1%>&type=<%=type%>&key=<%=key%>">&gt;</a></li>
				<%}else{ %>
				<li><a href="actorList.jsp?p=<%=endBlock+1%>">&gt;</a></li>
				<%} %>
				
			</ul>
		</div>
	</article>
</div>



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>