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
%>
<style>
.test{
    position: fixed;
    top: 35%;
    left: 32%;
    width: 17%;
    height: 18%;
    background-color: darkgray;
    display: inline-block;
    padding: 3%;
    font-weight: bolder;
    font-size: 24px;
    }
.a{
	display: none;
}
</style>
<script>
	$(function(){
		$(".ppopgi").click(function(){
			$(".a").show();
			$(".a").addClass("test");
		
			<%if(arr[0].getCoupon_name().equals("꽝")){%>
				$(".goods").text("꽝! 아쉽지만 다음 기회에 ㅠㅠ");
			<%}else{%>
				$(".goods").text("당첨 !  <%=arr[0].getCoupon_name()%>");
			<%}%>
		});
		$(".close").click(function(){
	    	 $(".loading-wrapper").hide();
	     });
	});
</script>

<%for(EventDto dto : eventDto) {%>
	<div class="box">
		<h1><%=dto.getEvent_name() %></h1>
		<h4><%=dto.getEvent_content() %></h4>
		<div class="date"> <%=dto.getEvent_start() %>~<%=dto.getEvent_end() %></div>
	</div>
<%} %>
<%if(isLogin){%>

<form action="event.do" method="post">
	<input type="hidden" name="coupon_no" value="<%=arr[0].getCoupon_no()%>">
	<input type="hidden" name="event_no" value="<%=event_no%>">
	<input type="submit" class="ppopgi" value="뽑기 시작">
</form>
<%} else{%>
	<input type="button" onclick="alert('로그인 후에 참여가 가능합니다!')" class="ppopgi" value="뽑기 시작">
<%}%>

<jsp:include page="/template/footer.jsp"></jsp:include>