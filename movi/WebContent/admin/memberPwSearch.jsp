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

<!--회원 검색 -->
<%
	//type(분류):번호,아이디 	key:검색어
	String type= request.getParameter("type");
	String key = request.getParameter("key");
	
	boolean search = type != null && key != null;
%> 

<!--멤버 목록   -->
<%	
	MemberAdminDao memberDao = new MemberAdminDao();
	List<MemberDto> memberList ;
	if(search){
		 memberList = memberDao.page_admin(type, key, startRow, endRow);
	}else{
		 memberList = memberDao.page_admin(startRow, endRow);
	}
%>



<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<!-- 각종 기능 -->
<script>
	$(function(){
		//삭제시 알림창 보여주기
		$(".memDelete").click(function(e){
			e.preventDefault();
			
			var check = window.confirm("회원 삭제하시겠습니까?");
			if(check){
				location.href=$(this).attr("href");
				//location.href=this.href;//this에 있는 경로로 이동해서 보내세요
			}
		});
		
		//전체선택 체크박스
		$("#checkall").click(function(){
			//클릭O
			if($("#checkall").prop("checked")){
				//각 체크박스 체크해주기
				$("input[name=chk]").prop("checked",true);
			}else{
				$("input[name=chk]").prop("checked",false);
			}
		});
		
		
		
	});

</script>

<div class="outbox" style="width: 100%">
	<aside>
		<div class="row center">
			<h2 style="color: deepskyblue;">회원 관리</h2>
		</div>
		<div class="left">
			<a href="memberList.jsp">회원리스트 </a><br>
			<br> <a href="#"> 임시 비밀번호 발급 </a><br>
			<br> <a href="#"> 회원 쿠폰 관리 </a>
		</div>
	</aside>

	<article>

		<div>
			<h1>임시 비밀번호 발급</h1>
		</div>

		<div class="outbox center" style="width: 800px">

  	<!-- 회원 검색창 -->
  		<div>
  			<h1>회원 검색</h1>
  		</div>
  		<div>
  			<form action="memberList.jsp" method="post">
  				<select name="type">
					<option value="member_no">회원 번호</option>
					<option value="member_id">아이디</option>
  				</select>
  				<input type="text" name="key" placeholder="검색어를 입력하세요" required>
  				<input type="submit" value="검색">
  			</form>
  		</div>
  		
 <%if(memberList == null){ %>
<!-- 처음 들어온 경우 보여줄 화면 -->
	<div class="row center">
		<h4>쿠폰 관리할 회원을 선택하세요</h4>
	</div>		
 <%}else if(memberList.isEmpty()){ %> 
 <!-- 검색결과가 없는 경우 -->
		<div class="row center">
			<h1>검색결과가 없습니다.</h1>
		</div>
 <%}else { %>	
<!-- 검색결과가 있는 경우 --> 
  	<!--멤버 리스트 테이블  -->	
	<div class="row">
		<table class="table table-border">
			<thead>
				<tr>
					<th><input type="checkbox" id="checkall">전체선택</th>
					<th>회원번호</th>
					<th>회원 아이디</th>
					<th>가입일</th>
					<th>권한</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
			<%for(MemberDto memberDto : memberList){ %>
				<tr>
					<td>
						<form action="" method="post">
							<input type="checkbox" name="chk" value="<%=memberDto.getMember_no() %>">
						</form>
					</td>
					<td><%=memberDto.getMember_no() %></td>
					<td><%=memberDto.getMember_id() %></td>
					<td><%=memberDto.getMember_date() %></td>
					<td><%=memberDto.getMember_auth() %></td>
					<td>
						<a href="memberPwCheck.jsp">임시 비밀번호 발급</a>

					</td>
				</tr>
			<%} %> 
			</tbody>
		</table>
	</div>
 <%} %>
			
		</div>

	</article>
</div>




<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>