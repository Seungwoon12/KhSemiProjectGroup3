<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	int event_no = Integer.parseInt(request.getParameter("event_no"));
	EventAdminDao eventDao = new EventAdminDao();
	EventAdminDtoVO eventDto = eventDao.SelectAll_admin(event_no); 
%>

<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<form action="eventEdit.do" method="post">
	<!-- 옆에 사이드 -->
	<div class="outbox" style="width: 100%">
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
				<h1>이벤트 정보 수정</h1>
			</div>


			<!--이벤트 상세보기 테이블에서 정보 수정  -->
			<div class="row center">
				<table class="table table-border" style="width: 80%">

					<tbody>

						<tr>
							<th width="20%">이벤트번호</th>
							<td>
							<input type="hidden" name="event_no" value="<%=eventDto.getEvent_no()%>">
							<%=eventDto.getEvent_no()%>
							</td>
						</tr>
						<tr>
							<th>이벤트명</th>
							<td>
							<input type="text" name="event_name" placeholder="<%=eventDto.getEvent_name()%>" required>
							 </td>
						</tr>
						<tr>
							<th>이벤트 기간</th>
							<td>
							<input type="date" name="event_start" placeholder="<%=eventDto.getEvent_start()%>" required>
							~
							<input type="date" name="event_end" placeholder="<%=eventDto.getEvent_end()%>" required>
							</td>
						</tr>
						<tr>
							<th>이벤트 내용</th>
							<td>
								<textarea name="event_content" placeholder="<%=eventDto.getEvent_content()%>" required></textarea>
							</td>
						</tr>
						<tr>
							<td colspan="2">
							<input type="submit" class="adbtn green" value="등록"> 
							<input type="button" class="adbtn yellow" value="취소" onclick="location.href='eventDetail.jsp?event_no=<%=eventDto.getEvent_no()%>'">
							</td>
						</tr>
					</tbody>
				</table>
			</div>

		</article>
	</div>
</form>

<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>       