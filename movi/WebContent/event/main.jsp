<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="movi.beans.EventDto"%>
<%@page import="java.util.List"%>
<%@page import="movi.beans.EventDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<%
	EventDao eventDao = new EventDao();
	List<EventDto> eventDto = eventDao.select();
	
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
%>
<style>
	.box{
		border: 1px solid lightgray;
		width:100%;
		height:10%;
		display: inline-block;
	}
	img{
		width: 28%;
	    height: 100%;
	    float: left;
	    padding: 1rem;
	    margin-right: 15px;
	}
	img:hover{
		opacity: 0.8;
		border: 2px solid gray;
	}
	.hid{
		opacity:0.4;
		pointer-events: none;
	}
</style>
<script>
	$(function(){
		
		$(".event1").click(function(e){
			e.preventDefault();
			location.href="<%=request.getContextPath()%>/event/detail.jsp?event_no="+$(this).next().val();
		});
	});
</script>
	<%for(EventDto dto : eventDto) {%>
		<!-- 종료 시점이 오늘보다 이전이면 클릭 금지 -->
		<%if(Integer.parseInt(sf.format(dto.getEvent_end()))<(Integer.parseInt(sf.format(now)))){%>
				<div class="box hid">
					<img class="event1" src="../img/event2.png">
					<input type="hidden" value="<%=dto.getEvent_no()%>">
					<h2><%=dto.getEvent_name() %></h2>
					<h4><%=dto.getEvent_content() %></h4>
					<div class="date"> <%=dto.getEvent_start() %>~<%=dto.getEvent_end() %>(종료)</div>
					</div>
		<!-- 정상 진행중인 이벤트 -->
			<%}else{%>
				<div class="box">
					<img class="event1" src="../img/event2.png">
					<input class="no" type="hidden" value="<%=dto.getEvent_no()%>">
					<h2><%=dto.getEvent_name() %></h2>
					<h4><%=dto.getEvent_content() %></h4>
					<div class="date"> <%=dto.getEvent_start() %>~<%=dto.getEvent_end() %></div>
				</div>
			<%} %>
	<%} %>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>