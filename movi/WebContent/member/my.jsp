<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="movi.beans.*"%>
<jsp:include page="/template/header.jsp"></jsp:include>	
    
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/swiper.css">
<script src="<%=request.getContextPath()%>/js/swiper.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mypage.css">
<style>
	main {
		height: 1350px;
	}
	.outbox{
		width: 66%;
		min-width: 500px;
	}
	.right-btn {
		display: inline-block;
		float: right;
	}
	.float-box::after {
        content:"";
        display:block;
    	clear:both;
	}
	.swiper-container {
      width: 100%;
      height: 100%;
    }
	div{
		border: none;
	}
	
	.coupon_box{
		display: table-cell;
		min-height: 200px;
		display: inline-block;
	}
	.title-img{
		height: 23px;
		width: 23px;
	}
	#member_nick{
		font-size: 36px;
	}
</style>

<%
	MemberDto memberDto = new MemberDto();
	MemberDao memberDao = new MemberDao();
	int member_no = (int)session.getAttribute("check");
	
	memberDto = memberDao.find(member_no);//로그인한 회원 정보
	
	//선호 장르 불러오기
	MygenreDao mygenreDao = new MygenreDao();
	List<MygenreDtoVO> mygenre_DtoVO_list = mygenreDao.find_no(member_no);
	GenreDao genreDao = new GenreDao();
	
	if(mygenre_DtoVO_list.size() >= 2) {
		Collections.shuffle(mygenre_DtoVO_list);
	}
	
	

	//좋아요 누른 영화 마이페이지에 뜰 수 있도록 하기
	LoveDao loveDao = new LoveDao();
	int start = 1, end = 10; //마이페이지 메인에서 좋아요한 영화는 최대 10개까지만 보여줌 -> 더보기를 누르면 전부 보여줌
	List<LoveDto> member_love_list = loveDao.select_love_movie(member_no, start, end);
	MovieAdminDao movieDao = new MovieAdminDao(); //영화 정보를 찾을 것이기 때문에 미리 도구 생성
	
	//쿠폰의 정보를 불러올 수 있도록
	MemberCouponDao memberCouponDao = new MemberCouponDao();
	CouponDao couponDao = new CouponDao();
	List<MemberCouponInfoVO> member_coupon_list = memberCouponDao.find_member(member_no);
	
	//영화 정보중에 장르 불러오는것 때문에 필요
	GenreDao genredao = new GenreDao();
%>

<script>
	$(document).ready(function(){
	    $("nav>a:nth-child(4)").addClass("navstyle");
	 });
	$(function(){
		$(".edit-btn").click(function(){
			location.href = "edit.jsp";
		});
		$(".myGenre-btn").click(function(){
			location.href = "mygenre.jsp";
		});
		$(".editPw-btn").click(function(){
			location.href = "editpw.jsp";
		});
		//.del-btn을 누르면 경고창이 나오고 확인을 누르면 멤버 삭제로 이동
		$(".del-btn").click(function(){
			if(window.confirm("정말로 탈퇴하시겠습니까?")){
				location.href = "delete.do";
			}
		});
	});
</script>

<script>
	<!-- 스와이퍼 관련된 것들은 여기에 전부 몰아넣기 -->
	window.onload = function(){
		var swiper1 = new Swiper('.swiper1', {
			loop: true,
			loopFillGroupWithBlank: true,
			
		    pagination: {
		    	el: '.swiper-pagination',
		    },
			navigation: {
				nextEl: '.swiper-button-next',
		    	prevEl: '.swiper-button-prev',
			},
			autoplay: {
		        delay: 2000,
		        disableOnInteraction: true,
		    }
		});
		
		var swiper2 = new Swiper('.swiper2', {
			navigation: {
				nextEl: '.swiper-button-next',
		    	prevEl: '.swiper-button-prev',
			},
		});
	};
</script>


<div class="outbox">
	<div class="row">
		<table class="table">
			<tbody>
				<tr>
					<!-- 프로필 파일 다운로드 경로 수정할 것.onerror 안은 그대로 둬도 됨 -->
					<td style="width: 30%">
						<img alt="user_profile" src="profile-download.do" 
						onerror="this.src='../image/profile/default_profile.png'" 
						style="height: 150px; width: 150px;">
					</td>
					<td rowspan="2" class="dotbox">
						<div>
							<h2 id="member_nick"><%=memberDto.getMember_nick()%>님</h2>
							<h5>방문해 주셔서 감사합니다.</h5>
							<h5>
								<%=memberDto.getMember_nick()%>님
								<%if(mygenre_DtoVO_list.isEmpty()) {%>
									은 아직 선호 장르를 선택하시지 않았습니다.<br>(선호하는 영화 장르를 선택해보세요)
								<%} else {%>
									의 선호 장르는 [ 
									<%
									for(MygenreDtoVO mygenreDtoVO : mygenre_DtoVO_list){
									%>	<a class="dotbox" href="../category/main.jsp?movie_genre_no=<%=mygenreDtoVO.getMygenre_genre_no()%>">
										&nbsp;<%=genreDao.find(mygenreDtoVO.getMygenre_genre_no())%>&nbsp;
										</a>
									<%} %>
									 ] 입니다.
								<%} %>
							</h5>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<form action="profile-enroll.do" method="post" enctype="multipart/form-data">
							<div class="filebox"> 
								<label for="pro_file">업로드</label> 
								<input id="pro_file" type="file" name="profile" accept=".jpg, .png, .gif">
							</div>
 							<input type="submit" class="btnmy" value="프로필 변경">
 						</form>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="row center">
		<input type="button" class="btnmy edit-btn" value="내 정보 수정">
		<input type="button" class="btnmy myGenre-btn" value="선호 장르 변경">
		<input type="button" class="btnmy editPw-btn" value="비밀 번호 변경">
		<input type="button" class="btnmy del-btn" value="회원 탈퇴">
	</div>
	
	<!-- 스와이퍼 다시 한번 생각해보기 -->
	<div class="row float-box">
		<img class="title-img" alt="heart-img" src="../img/heart_red.png">
		<span>좋아요 누른 영화</span>
		<div class="right-btn">
			<a href="mylovemovielist.jsp?p=1">더보기</a>
		</div>
	</div>
	<div class="row center">
		<div class="swiper-container swiper1">
	        <div class="swiper-wrapper">
	        	<%
	        	for(LoveDto loveDto : member_love_list) {
	        		MovieDto movieDto = movieDao.select_admin(loveDto.getLove_movie_no()); /*수정*/
	        	%>
	            <div class="swiper-slide dotbox">
	            	<div class="movie_box">
	            		<table>
	            		<tbody>
	            			<tr>
	            				<td rowspan="4">
	            					<a href="../category/detail.jsp?movie_no=<%=movieDto.getMovie_no()%>">
										<img class="movie_img" alt="movie_img" src="../poster-down.do?movie_no=<%=movieDto.getMovie_no()%>" 
										onerror="this.src='../image/movie/dummy.jpg'">
									</a>
								</td>
								<th style="min-width: 200px;">
									<a href="../category/detail.jsp?movie_no=<%=movieDto.getMovie_no()%>">
	            						<%=movieDto.getMovie_name()%>
	            					</a>
								</th>
							</tr>
	            			<tr>
	            				<td>
	            					<a href="../category/main.jsp?movie_genre_no=<%=movieDto.getMovie_genre_no()%>">
	            					장르 : <%=genreDao.find(movieDto.getMovie_genre_no())%>
	            					</a>
	            				</td>
	            			</tr>
	            			<tr>
	            				<td>
	            					평점 : <%=movieDto.getMovie_rate()%>
	            				</td>
	            			</tr>
	            			<tr>
	            				<td>
	            					좋아요 : <%=loveDao.love_count(movieDto.getMovie_no())%>
	            				</td>
	            			</tr>
	            		</tbody>
	            	</table>
	            	</div>
				</div>
				<%} if(member_love_list.isEmpty()) {%>
					<div class="swiper-slide dotbox">
						<div class="movie-box">
							<%if(mygenre_DtoVO_list.isEmpty()) {%>
								<div class="movie_box">
				            		<table>
				            			<tbody>
				            				<tr>
				            					<td>
				            						<a href="../category/main.jsp?movie_genre_no=1">
				            							<img alt="dummy movie_img" src="../image/movie/dummy.jpg">
				            						</a>
												</td>
												<td style="min-width: 200px;">
													<a href="../category/main.jsp?movie_genre_no=1">
					            						좋아하는 영화를 선택해 보세요
					            					</a>
												</td>
											</tr>
				            			</tbody>
				            		</table>
				            	</div>
							<%} else {%>
								<div class="movie_box">
				            		<table>
				            			<tbody>
				            				<tr>
				            					<td>
				            						<a href="../category/main.jsp?movie_genre_no=<%=mygenre_DtoVO_list.get(0).getMygenre_genre_no()%>">
				            							<img alt="dummy movie_img" src="../image/movie/dummy.jpg">
				            						</a>
												</td>
												<td style="min-width: 200px;">
													<a href="../category/main.jsp?movie_genre_no=<%=mygenre_DtoVO_list.get(0).getMygenre_genre_no()%>">
					            						좋아하는 영화를 선택해 보세요
					            					</a>
												</td>
											</tr>
				            			</tbody>
				            		</table>
				            	</div>
							<%} %>
						</div>
					</div>
				<%} %>
	        </div>
	        <div class="swiper-pagination"></div>
	        
	        <div class="swiper-button-prev"></div>
	        <div class="swiper-button-next"></div>
	    </div>
	</div>
	
	<!-- 이벤트 페이지 구성되면 만들 생각 -->
	<div class="row float-box">
		<img class="title-img" alt="heart-img" src="../img/gift-box.png">
		<span>보유중인 상품</span>
	</div>
	<div class="row center">
		<div class="swiper-container swiper2">
	        <div class="swiper-wrapper">
	        	<%for(MemberCouponInfoVO memberCouponInfoVO : member_coupon_list) {
	        		if(memberCouponInfoVO.getCoupon_name() != "꽝") {
	        	%>
	            <div class="swiper-slide dotbox">
					<div class="coupon_box">
						<table>
							<tbody>
								<tr>
									<td rowspan="3"><img src="https://chart.googleapis.com/chart?cht=qr&chl=<%=memberCouponInfoVO.getCoupon_name()%>&chs=180x180&choe=UTF-8&chld=L|2" alt="coupon_QR"></td>
									<td><%=memberCouponInfoVO.getEvent_name() %></td>
								</tr>
								<tr>
									<td><%=memberCouponInfoVO.getCoupon_name() %></td>
								</tr>
								<tr>
									<td><%=memberCouponInfoVO.getStart() %> ~ <%=memberCouponInfoVO.getEnd() %></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<%}} if (member_coupon_list.isEmpty()) {%>
					<div class="swiper-slide dotbox">
						<div class="coupon_box">
							<div><br><br><br><br></div>
							<a href="../event/main.jsp">
								~진행중인 이벤트를 확인하고 상품 받아가세요~
							</a>
						</div>
					</div>
				<%} %>
	        </div>
	        <div class="swiper-button-prev"></div>
	        <div class="swiper-button-next"></div>
	        <div class="swiper-pagination"></div>
	    </div>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>