<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/template/header.jsp"></jsp:include>


<%String member_id = request.getParameter("member_id"); %>

<%if(member_id !=null){ %>
<h3>찾으신 결과 아이디는 <font color="red"> <%=member_id %></font></h3> 입니다.


<a href="pw_find.jsp"><font color="#4E6FA6" size="3">비밀번호를 재설정하시겠습니까?</font></a>
<%}

else {%>
<div class="row center">
<h3><font color="red">해당하는 회원이 없습니다</font></h3>
	</div>
	<div class="row center">
<a href="<%=request.getContextPath()%>/member/Id_find.jsp"><font color="#4E6FA6" size="3">다시 하시겠습니까?</font></a>
</div>
<br>

<%} %>

<jsp:include page="/template/footer.jsp"></jsp:include>