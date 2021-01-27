<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.catalina.startup.SetContextPropertiesRule"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.List"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<%
	int event_no = Integer.parseInt(request.getParameter("event_no"));
	
	EventDao eventDao = new EventDao();
	List<EventDto> eventDto = eventDao.find(event_no);
	
	CouponDao couponDao = new CouponDao();
	List<CouponDto> couponDto = couponDao.goods(event_no);
	Collections.shuffle(couponDto);
	CouponDto[] arr = couponDto.toArray(new CouponDto[couponDto.size()]);
	
	 boolean isLogin = session.getAttribute("check") != null;
	 
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
%>
<style>
.box{
	 text-align: center;
}
.ppopgi{
	background-color: goldenrod;
    width: 186px;
    height: 43px;
    cursor: grab;
    border-radius: 17px;
}
}
</style>
<script>
	$(function(){
	});
</script>

<%for(EventDto dto : eventDto) {%>
	<div class="box">
		<h1><%=dto.getEvent_name() %></h1>
		<h4><%=dto.getEvent_content() %></h4>
		<%if(Integer.parseInt(sf.format(dto.getEvent_end()))<(Integer.parseInt(sf.format(now)))){%>
			<div class="end"> 종료된 이벤트입니다!</div>
		<%}else{%>
	</div>
	<%if(isLogin){%>

		<div class="box">
			<img src="../img/gift.gif" style="width:300px; height:250px;">
			<form action="event.do" method="post">
				<input type="hidden" name="coupon_no" value="<%=arr[0].getCoupon_no()%>">
				<input type="hidden" name="event_no" value="<%=event_no%>">
				<input type="submit" class="ppopgi" value="두근두근 뽑기!">
			</form>
	<%} else{%>
			<input type="button" onclick="alert('로그인 후에 참여가 가능합니다!')" class="ppopgi" value="뽑기 시작">
		    <%}%>
		</div>
	<%} %>
<%} %>
<jsp:include page="/template/footer.jsp"></jsp:include>

