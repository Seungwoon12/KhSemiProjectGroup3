<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <%
   //사용자가 로그인 상태인지 계산하는 코드
   //로그인 상태 : null이 아닌 경우
   //로그아웃 상태 : null인 경우
   boolean isLogin = session.getAttribute("check") != null;
   
   //사용자가 관리자인지 계산하는 코드
   String auth = (String)session.getAttribute("auth");
   boolean isAdmin = isLogin && auth.equals("관리자");
  
  //request.getSession().setAttribute("mode", value);
  String mode;
%>
    
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.css"> 
<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.min.css"> 
<script src="https://unpkg.com/swiper/js/swiper.js"></script> 
<script src="https://unpkg.com/swiper/js/swiper.min.js"></script>



<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<style>
   /* 화면 레이아웃 스타일 */
   
   /* 모든 영역은 점선으로 테두리가 표시되게 한다(테스트용) */
   main, header, nav, 
   footer
    {
      border: 1px dotted #ccc;
   }
   /* 전체 화면의 폭은 100% 로 한다 */
   main {
      width:1200px;
      margin:auto;
      height: 2000px;
   }
   /* 각각의 레이아웃 영역에 여백을 설정한다 */
   header, footer, nav, section {
      padding:1rem;
   }
   /* 본문에 내용이 없어도 최소높이를 설정하여 일정 크기만큼 표시되도록 한다 */
   section {
      height: 70%;
   }
   
   /*다크모드 버튼 (헤더에 해야됨)*/
.btn{
	position: fixed;
    top: 90%;
    left: 84%;
    height: 50px;
    width: 124px;
    z-index: 999;
    border-radius: 2rem;
    cursor: pointer;
}
.black{
	background-color: #202020;
	color: #d9d9d9;
}
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.1.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.5.1.js"></script> -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<script>
$(document).ready(function(){

	//다크 모드
	$(".black-btn").click(function(){	
		if($(".black-btn").val()=='어둡게하기'){
			$("html").css('background-color','#202020');
			$("html").css('color','#d9d9d9');
			$("li>a").css('color','#d9d9d9');
			saveColor('#202020','#d9d9d9');
			$(".black-btn").val('밝게하기');
			saveValue('밝게하기');
		}
		else{
			$("html").css('background-color','white');
			$("html").css('color','black');
			$("li>a").css('color','black');
			saveColor('white','black');
			$(".black-btn").val('어둡게하기');
			saveValue('어둡게하기');
			}
		});
	
	//localStorage를 이용해 색상,value를 저장
	function saveColor(color1,color2){
	    localStorage.setItem("selectedcolor1", color1);
	    localStorage.setItem("selectedcolor2", color2);
	}
	function saveValue(value){
	    localStorage.setItem("selectedvalue", value);
	}
	var clr = localStorage.getItem("selectedvalue");
	var clr1 = localStorage.getItem("selectedcolor1");
	var clr2 = localStorage.getItem("selectedcolor2");
	if(clr != '' && clr != null &&clr1 != '' && clr1 != null && clr2 != '' && clr2 != null)
	{
		$("html").css('background-color', clr1);
		$("html").css('color', clr2);
		$("li>a").css('color', clr2);
		$(".black-btn").val(clr);
	}
});
</script>
</head>
<body>
<!-- 다크 모드 -->
<!--<form action="" method="get">-->
<input type="button" class="btn black-btn">
   <main>
      <header>
         <h1 class="left">movi</h1>
         <%if(!isLogin){ %>
         <!--로그인아닐때---->
         <a href="<%=request.getContextPath()%>/member/loginpage.jsp" class="left">로그인</a>
         <%}
         else{ %><!--로그인했을때--->
         <a href="<%=request.getContextPath()%>/member/logout.do"class="left">로그아웃</a>
   <%} %>
         <a href="<%=request.getContextPath()%>/event/main.jsp" class="right">이벤트</a>
         <%if(isAdmin){ %>
         <!--권한부여---->
         <a href="<%=request.getContextPath()%>/admin/main.jsp">관리자 모드</a>
         <%} %>
      </header>
      <nav>
      <a href="<%=request.getContextPath()%>">홈</a>
      <!-- 카테고리 처음 들어갔을 때 로맨스 영화로 설정-->
      <a href="/movi/category/main.jsp?movie_genre_no=1">카테고리</a>
      <a href="<%=request.getContextPath()%>/review/list.jsp">리뷰</a>
      <%if(isLogin){ %>
      <!--로그인했을때---->
      <a href="<%=request.getContextPath()%>/member/my.jsp">마이페이지</a><%} %>
      </nav>
   <section>