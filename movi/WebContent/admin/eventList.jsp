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

<!--이벤트 검색 -->
<%
	//type(분류):번호,아이디 	key:검색어
	String type= request.getParameter("type");
	String key = request.getParameter("key");
	
	boolean search = type != null && key != null;
%> 

<!--이벤트 목록   -->
<%	
	EventAdminDao eventDao = new EventAdminDao();
	List<EventAdminDtoVO> eventList ;
	if(search){
		 eventList = eventDao.page_admin(type, key, startRow, endRow);
	}else{
		 eventList = eventDao.page_admin(startRow, endRow);
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
		count= eventDao.count_admin(type, key); 
	}else{
		count= eventDao.count_admin(); 
	}
	//페이지 개수
	int countSize = (count + pageSize -1) / pageSize;
	
	if(endBlock > countSize){
		endBlock = countSize;
	}
%>    
    
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>      
 
 <!--이벤트  삭제시 알림 구현  -->
<script>
	$(function(){
		//삭제시 알림창 보여주기
		$(".delete").click(function(e){
			e.preventDefault();
			
			var check = window.confirm("이벤트를 삭제하시겠습니까?");
			if(check){
				location.href=$(this).attr("href");
			}
		});
		
	});
</script>
    
<div class="outbox" style="width:100%">
   <aside>
   		<div class="row center">
       		<h2 style="color:#4B89DC;">이벤트 관리</h2>     
  	 	</div>
  	 	<div class="left">
  	 		<a href="eventList.jsp"> 이벤트 목록 </a><br><br>
  	 	</div>
  	</aside>
	
  	<article>
  	
  	<!-- 이벤트 검색창 -->
  		<div>
  			<h1>이벤트 목록</h1>
  		</div>
  		<div class="search">
  			<form action="eventList.jsp" method="post">
  				<label>이벤트 검색</label>
  				<select name="type" class="padding">
  					<option value="event_no">이벤트 번호</option>
  					<option value="event_name">이벤트 이름</option>
  				</select>
  				<input type="text" name="key" class="padding" placeholder="검색어를 입력하세요" required>
  				<input type="submit" value="검색" class="padding1">
  			</form>
  		</div>


	
 <%if(eventList.isEmpty()){ %> 
 <!-- 검색결과가 없는 경우 -->
		<div class="row center">
			<h1>검색결과가 없습니다.</h1>
		</div>
 <%}else{ %>	
<!-- 검색결과가 있는 경우 -->   		
  	<!--이벤트 리스트 테이블  -->	
	<div class="row">
		<table class="table1" style="width: 1000px">
			<thead>
				<tr>
					<th><input type="checkbox" id="checkall">전체선택</th>
					<th>이벤트 번호</th>
					<th>이벤트 이름</th>
					<th>기간</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
			<%for(EventAdminDtoVO eventDto : eventList){ %>
				<tr>
					<td>
						<input type="checkbox">
					</td>
					<td><%=eventDto.getEvent_no() %></td>
					<td><%=eventDto.getEvent_name() %></td>
					<td>
					<%=eventDto.getEvent_start() %>~
					<%=eventDto.getEvent_end() %>
					</td>
					<td>
						<a class="abtn purple" href="eventDetail.jsp?event_no=<%=eventDto.getEvent_no()%>">상세보기</a>
						<a class="abtn green" href="eventEdit.jsp?event_no=<%=eventDto.getEvent_no()%>">수정</a>
						<a class="abtn red delete" href="eventDelete.do?event_no=<%=eventDto.getEvent_no()%>">삭제</a>

					</td>
				</tr>
			<%} %>
			</tbody>
		</table>
	</div>
 <%} %>	
			<!-- 페이지 네비게이션 -->
		<div class="row center">
			<ul class="pagination">
			
				<!-- 이전 -->
				<%if(search){ %>
				<li><a href="eventList?p=<%=startBlock-1%>&type=<%=type%>&key=<%=key%>">&lt;</a></li>
				<%}else{ %>
				<li><a href="eventList?p=<%=startBlock-1%>">&lt;</a></li>
				<%} %>
				
				<%for(int i= startBlock; i<=endBlock;i++){ %>
					<li>
						<%if(search){ %>
						<!-- 검색용 링크 -->
						<a href="eventList.jsp?p=1&type=<%=i%>&key=<%=key%>"><%=i %></a>
						<%}else{ %>
						<!-- 목록용 링크 -->
						<a href="eventList.jsp?p=<%=i%>"><%=i %></a>
						<%} %>
					</li>	
				<%} %>	
				
				<!-- 이후 -->
				<%if(search){ %>
				<li><a href="eventList.jsp?p=<%=endBlock+1%>&type=<%=type%>&key=<%=key%>">&gt;</a></li>
				<%}else{ %>
				<li><a href="eventList.jsp?p=<%=endBlock+1%>">&gt;</a></li>
				<%} %>

			</ul>
		</div>
	</article>
	
</div>	



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>

