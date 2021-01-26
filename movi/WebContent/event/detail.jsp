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
	
	MemberCouponDao mcDao = new MemberCouponDao();
	//int member_id = 1;
	//mcDao.insert(member_id, arr[0].getCoupon_no(), event_no);
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
<input type="button" class="ppopgi" value="뽑기 시작">

<img >닫기</button>
<img src="./img/close.jpg" class="close">

<div class="a">
	<div class="goods"></div>
	<form action="" method="get">
		<input type="submit" value="마이페이지로 이동하기">
	</form>
</div>
<%} %>
<!--
	로그인을 한 사람만 누르기 가능!! is Login
	한 계정당 한번만 가능!! where member_id=session 일 때 
	뽑기 버튼 눌렀을 때?
	display absolute 해서 중간에
	coupon random값을 text로 출력하기!
	-> 닫기, 마이페이지로 링크 추가
	=> 마이페이지 쿠폰함에 text 값 넣어주기 

 -->

<jsp:include page="/template/footer.jsp"></jsp:include>