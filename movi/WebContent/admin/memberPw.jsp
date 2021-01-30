<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	String pw = (String)request.getAttribute("pw");
%>


<jsp:include page="/adminTemplate/header.jsp"></jsp:include>    

<style>
		.table2{
			border-radius: 10px;
			padding:1rem;
            font-size:18px;
            width:500px; 
            border:1px solid gray;
            margin:auto;
            padding:1rem;			
		}
		.back{
			background-color: orange;
			padding: 1rem;		
		}

</style>

<div class="outbox" style="width:100%">
   <aside>
   		<div class="row center">
       		<h2 style="color:deepskyblue;">회원 관리</h2>     
  	 	</div>
  	 	<div class="left">
				<a href="memberList.jsp">회원리스트 </a><br> <br>
				 <a href="memberPwSearch.jsp"> 임시 비밀번호 발급 </a><br><br> 
				 <a href="memberCouponList.jsp">회원 쿠폰 목록</a>
  	 	</div>
  	</aside>
	
  	<article>
  	
  		<div>
  			<h1>임시 비밀번호 발급 현황</h1>
  		</div>
  		
		<div class="table2 center" style="">
			<div class="row left">
				<h3>임시 비밀번호 발급 완료</h3>
			</div>
			<div class="row left">
				<h4>임시 비밀번호가 전송되었습니다</h4>
			</div>
			<!-- 비밀번호 확인용 -->
			<div class="row back">
				발급된 비밀번호 : <%=pw %>
			</div>
			
			<div class="center" style="margin: 20px">
				<input type="button" value="확인" class="adbtn gray" onclick="location.href='memberList.jsp'">
			</div>
		</div>	

  		
  	</article>
</div>


<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>
    