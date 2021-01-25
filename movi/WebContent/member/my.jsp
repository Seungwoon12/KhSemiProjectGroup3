<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="movi.beans.*"%>
<jsp:include page="/template/header.jsp"></jsp:include>	
    
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/swiper.css">
<script src="<%=request.getContextPath()%>/js/swiper.js"></script>
 
<style>
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
</style>

<%
	MemberDto memberDto = new MemberDto();
	MemberDao memberDao = new MemberDao();
	int member_no = (int)session.getAttribute("check");
	
	memberDto = memberDao.find(member_no);//로그인한 회원 정보
	
	//선호 장르 불러오기
	MygenreDao mygenreDao = new MygenreDao();
	List<MygenreDtoVO> mygenre_DtoVO_list = mygenreDao.find_no(member_no);
	List<String> mygenre_list = new ArrayList<>();
	GenreDao genreDao = new GenreDao();
	for(MygenreDtoVO mygenreDtoVO : mygenre_DtoVO_list){
		mygenre_list.add(genreDao.find(mygenreDtoVO.getMygenre_genre_no()));
	}

	//좋아요 누른 영화 마이페이지에 뜰 수 있도록 하기
	LoveDao loveDao = new LoveDao();
	int start = 1, end = 10; //end의 값은 최신 좋아요 순으로 최대 10장만 나오고 최소로도 10장이 나오도록 한다는 뜻 나머지는 빈칸 으로 만들어 둠(자리 차지)
	List<LoveDto> member_love_list = loveDao.select_love_movie(member_no, start, end);
	MovieAdminDao movieDao = new MovieAdminDao(); //영화 정보를 찾을 것이기 때문에 미리 도구 생성

%>

<script>
	$(function(){
		$(".edit-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/member/edit.jsp";
		});
		$(".myGenre-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/member/mygenre.jsp";
		});
		$(".editPw-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/member/editpw.jsp";
		});
		//.del-btn을 누르면 경고창이 나오고 확인을 누르면 멤버 삭제로 이동
		$(".del-btn").click(function(){
			if(window.confirm("정말로 탈퇴하시겠습니까?")){
				location.href = "<%=request.getContextPath()%>/member/delete.do";
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
		        disableOnInteraction: false,
		    }
		});
		
		var swiper2 = new Swiper('.swiper2', {
		    pagination: {
		    	el: '.swiper-pagination',
		    },
			navigation: {
				nextEl: '.swiper-button-next',
		    	prevEl: '.swiper-button-prev',
			},
		});
	};
</script>


<div class="outbox">
	<div class="row">
		<table class="table table-border">
			<tbody>
				<tr>
					<td style="width: 30%">
						<img alt="profile" src="https://placeimg.com/150/150/people"> <!-- 프로필 사진이 나오도록 수정 -->
					</td>
					<td rowspan="2">
						<div>
							<h2><%=memberDto.getMember_id()%>님</h2>
							<h5>방문해 주셔서 감사합니다.</h5>
							<h5>
								<%=memberDto.getMember_id()%>님
								<%if(mygenre_list.isEmpty()) {%>
									은 아직 선호 장르를 선택하시지 않았습니다.(선호하는 영화 장르를 선택해보세요)
								<%} else {%>
									의 선호 장르는
									<%for (String mygenre : mygenre_list) {%>
										<%=mygenre %>
									<%} %>
									입니다.
								<%} %>
							</h5>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<form action="profile-enroll.do" method="post" enctype="multipart/form-data">
 							<input type="file" name="profile" accept=".jpg, .png, .gif">
 							<input type="submit" class="input input-inline" value="프로필 변경">
 						</form>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="row center">
		<input type="button" class="input input-inline edit-btn" value="내 정보 수정">
		<input type="button" class="input input-inline myGenre-btn" value="선호 장르 변경">
		<input type="button" class="input input-inline editPw-btn" value="비밀 번호 변경">
		<input type="button" class="input input-inline del-btn" value="회원 탈퇴">
	</div>
	
	<!-- 스와이퍼 다시 한번 생각해보기 -->
	<div class="row float-box">
		<span>좋아요 누른 영화</span>
		<div class="right-btn">
			<a href="#">더보기</a>
		</div>
	</div>
	<div class="row center">
		<div class="swiper-container swiper1">
	        <div class="swiper-wrapper">
	        	<%
	        	for(LoveDto loveDto : member_love_list) {
	        		MovieDto movieDto = movieDao.select_admin(loveDto.getLove_movie_no()); /*수정*/
	        		end--;
	        	%>
	            <div class="swiper-slide">
	            	<div class="row">
						<a href="<%=request.getContextPath()%>/category/detail.jsp?movie_no=<%=movieDto.getMovie_no()%>">
							<img alt="movie_img" src="<%=request.getContextPath()%>/image/movie/
							<%try{ %>
							<%=movieDto.getMovie_no()%>
							<%}
							catch(NullPointerException ne){%>
							<%="dummy"%>
							<%} %>.jpg">
							<%=movieDto.getMovie_name()%>
						</a>
	            	</div>
				</div>
				<%} for(int i = 0; i < end; end--){%>
					<div class="swiper-slide">
					<img alt="dummy" src="<%=request.getContextPath()%>/image/movie/dummy.jpg">
					<%="자리채우기 테스트용 더미입니다"%>
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
		<span>참여한 이벤트</span>
		<div class="right-btn">
			<a href="#">더보기</a>
		</div>
	</div>
	<div class="row center">
		<div class="swiper-container swiper2">
	        <div class="swiper-wrapper">
	            <div class="swiper-slide">
					<img class="dum" src="https://placeimg.com/600/350/any">
				</div>
	            <div class="swiper-slide">
					<img class="dum" src="https://placeimg.com/600/350/tech">
				</div>
	            <div class="swiper-slide">
					<img class="dum" src="https://placeimg.com/600/350/animals">
				</div>
	            <div class="swiper-slide">
	            	<img class="dum" src="https://placeimg.com/600/350/nature">
	            </div>
	            <div class="swiper-slide">
	            	<img class="dum" src="https://placeimg.com/600/350/architecture">
	            </div>
	        </div>
	        <div class="swiper-button-prev"></div>
	        <div class="swiper-button-next"></div>
	        <div class="swiper-pagination"></div>
	    </div>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>