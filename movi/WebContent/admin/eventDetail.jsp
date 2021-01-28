<%@page import="movi.beans.EventAdminDao"%>
<%@page import="movi.beans.EventAdminDtoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/adminTemplate/header.jsp"></jsp:include> 
<%
	int event_no = Integer.parseInt(request.getParameter("event_no"));
	EventAdminDao eventDao = new EventAdminDao();
	EventAdminDtoVO eventDto = eventDao.SelectAll_admin(event_no); 
%>

<!-- 각종 기능 -->
<script>
//이벤트 삭제시 alert확인
	window.onload= function(){
		document.querySelector(".event_delete").addEventListener("click", function(){
			
			var check = window.confirm("이벤트를 삭제하시겠습니까?");
			if(check){
				location.href="<%=request.getContextPath()%>/admin/eventDelete.do?event_no=<%=eventDto.getEvent_no()%>" ;
			}else{
				location.href= "<%=request.getContextPath()%>/admin/eventList.jsp" ;
			}
		});
	}; 
</script>



<div class="outbox" style="width:100%">
    <aside>
   		<div class="row center">
       		<h2 style="color:deepskyblue;">이벤트 관리</h2>     
  	 	</div>
  	 	<div class="left">
  	 		<a href="eventList.jsp"> 이벤트 목록 </a><br><br>
  	 	</div>
  	</aside>
	
  	<article>
  	
  		<div>
  			<h1>이벤트 상세목록</h1>
  		</div>

  		
  	<!--이벤트ㅡ상세보기 테이블  -->	
		<div class="row center">
			<table class="table table-border" style="width:80%">

				<tbody>
				
					<tr>
						<th width="20%">이벤트 번호</th>
						<td><%=eventDto.getEvent_no()%></td>
					</tr>
					<tr>
						<th>이벤트 이름</th>
						<td><%=eventDto.getEvent_name()%></td>
					</tr>
					<tr>
						<th>이벤트 기간</th>
						<td><%=eventDto.getEvent_start() %>
						~ <%=eventDto.getEvent_end() %>
						</td>
					</tr>
					<tr>
						<th>이벤트 내용</th>
						<td><%=eventDto.getEvent_content()%></td>
					</tr>
					<tr>
						<th>쿠폰종류</th>
						<td><%=eventDto.getCoupon_name() %></td>
					</tr>					
					<tr>
						<td colspan="2">
							<input type="button" value="수정" onclick="location.href='eventEdit.jsp?event_no=<%=eventDto.getEvent_no()%>'">
							<input type="button" value="삭제" class="event_delete">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
			
			
			<!-- 이벤트리스트로 돌아가기 -->
		<div class="right">
			<a href="eventList.jsp">이벤트리스트로 돌아가기</a>
		</div>
		
			
	</article>
</div>  	



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>    