<%@page import="movi.beans.MygenreDtoVO"%>
<%@page import="movi.beans.MygenreDto"%>
<%@page import="movi.beans.MygenreDao"%>
<%@page import="movi.beans.MemberDto"%>
<%@page import="movi.beans.MemberDao"%>
<%@page import="movi.beans.LoveDao"%>
<%@page import="movi.beans.MovieDtoVO"%>
<%@page import="movi.beans.RecommendDto"%>
<%@page import="movi.beans.RecommendDao"%>
<%@page import="java.util.List"%>
<%@page import="movi.beans.MovieDao"%>
<%@page import="movi.beans.MovieDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

<jsp:include page="/template/header.jsp"></jsp:include>
<%
	//페이징
	int startPage=1;
	int endPage=10;

	MovieDto dto = new MovieDto();
	//3조추천
	RecommendDao recomDao = new RecommendDao();
	List<RecommendDto> recomList = recomDao.select_title();
	
	
	//좋아요순
		MovieDao movieDao = new MovieDao();
		List<MovieDtoVO> movieLoveList = movieDao.select_love(startPage,endPage);
		
	//관객순
	List<MovieDto> movieAudList = movieDao.select_aud(startPage,endPage);
	
	
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.select(1);
	
	//세션 회원 맞춤순
	request.getSession().setAttribute("check", memberDto.getMember_no());
	int genre = (int)session.getAttribute("check");
	
	int a = 2;
	//장르별
	MygenreDao mygenreDao = new MygenreDao();
	List<MygenreDtoVO> mygenreList = mygenreDao.find(a);

	
%>
<!-- 이거 jquery css로 만들기! -->
<style>
	.hov{
		border: 1px solid red;
	}
	
	.hov:hover{
		opacity: 0.5;
	}
	
	.hov:hover +.h{
		display:inline-block;
	 	z-index: 999;
	    position: absolute;
	    left: 5px;
	    left:20px
	    
	}
	
	.h{
	   display:none;
	}
	
	.unit.slot.id{
       background-image: url(./img/search.jpg);
       background-size: contain;
       background-repeat: no-repeat; 
        }
        
   .name{
	  float: left;
	  width:27%;
   }
   .recom{
	   float:left
	   width:70%;
	   display: flex;
   }
   .name,.recom{
	   	height:300px;
	   	padding: 0.5rem;
   }
	
	.main{
		width:100%;
		height: 500px;
	}
	.row{
		display:flex;
		}
		
	.movie{
		padding: 0.2rem;
	}
	li{
		list-style:none;
		display: inline-block;
	}
	li>img{
	width:30px;
	}
	.swiper-wrapper{
		display: flex;
		margin:23px;
	}
	.swiper-slide img {
	box-shadow:0 0 5px #555;
	max-width:100%; /* 이미지 최대너비를 제한, 슬라이드에 이미지가 여러개가 보여질때 필요 */
}
.swiper-slide{
width:118px !important;
margin:20px;
}
	.prev>img, .next>img{
		width: 30px;
    	position: relative;
    	top: 40%;
		margin: 10px;
		cursor: pointer;
	}
	.prev>img{
	    position: absolute;
    left: 22%;
    top: 68%;
	}
	.next>img{
	    position: absolute;
    left: 74%;
    top: 69%;
	}
	.swiper-container {
    width: 779px;
</style>

<script>
	$(function(){
		//추천영화 목록으로 가기
		$(".movie_recom").click(function(){
			location.href="/movi/category/recom.jsp?recom_title="+$(this).text();
		});
		//영화 세부 페이지로 가기
		$(".movie_detail").click(function(){
			location.href="/movi/category/detail.jsp?movie_name="+$(this).text();
		})
		
		
		new Swiper('.swiper-container', {
			slidesPerView : 5, // 동시에 보여줄 슬라이드 갯수
			spaceBetween : 10, // 슬라이드간 간격
			slidesPerGroup : 5, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음
			loopFillGroupWithBlank : true,
			
			pagination : { // 페이징 설정
				el : '.swiper-pagination',
				clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
			},
			navigation : { // 네비게이션 설정
				nextEl : '.swiper-button-next', // 다음 버튼 클래스명
				prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
			},
		});
		
	});
</script>
<%

%>
<div class="outbox" style="width:100%">

	<div class="main" style="height:295px">
		<div class="name">
		
		<form action="/movi/category/detail.jsp" method="get">
			<div>	
<!-- 비동기 검색을 알아보자! -->
				<input name="movie_name" class="input input-hint unit slot id" 
						placeholder="영화명을 입력하세요" type="text" style="width:200px">
				<input type="submit" value="검색">
			</div>
		</form>
			
			<div class="center" style="width:200px">
				<h1>MOVI</h1>
				<h5>모두의 비디오, 모비</h5>
			</div>
			<div class="right" style="width:200px">
				<ul>
					<li>
						<img src="./img/pre.png" alt="이전">
					</li>
					<li>
						<img src="./img/next.png" alt="다음">
					</li>
				</ul>
			</div>
		</div>
<!-- @@@@@@@@@@ 3조 추천 영화 -->	
		<div>
		<div class="row swiper-container">
	
			<div class="row recom swiper-wrapper">
				<%for(RecommendDto recomdto : recomList){%>
					<div class="movie movie_recom swiper-slide">
						<img class="hov" src="http://placeimg.com/150/200/any">
						<h1 class="h hov1">
								<%=recomdto.getRecom_title()%>
						</h1>
					</div>
				<%} %>
			</div>	
			<!-- 네비게이션 버튼 -->
			<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
			<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
		
			<!-- 페이징 -->
			<div class="swiper-pagination"></div>
		</div>
	</div>

<hr>
<!-- @@@@@@@@@@ 좋아요 순위 -->

	<div class="outbox" style="width:590px">
		<div class="row left">
			모비 좋아요 순위
		</div>
		
		
		<div class="row swiper-container">
	
			<div class="swiper-wrapper">
				<%for(MovieDtoVO lovedto : movieLoveList){ %>
					<div class="movie movie_detail swiper-slide">
						<img class="hov" src="http://placeimg.com/100/200/any">
						<h1 class="h hov2">
								<%=lovedto.getMovie_name()%>
						</h1>
					</div>
				<%} %>
			</div>
		
			<!-- 네비게이션 버튼 -->
			<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
			<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
		
			<!-- 페이징 -->
			<div class="swiper-pagination"></div>
		</div>	
	</div>

<!-- @@@@@@@@@@ 관객수 순위 -->

	<div class="outbox" style="width:640px">
		<div class="row left">
			모비 관객수 순위
		</div>
		<div class="row swiper-container">
	
			<div class="swiper-wrapper">
				<%for(MovieDto moviedto : movieAudList){ %>
					<div class="movie movie_detail swiper-slide">
						<img class="hov" src="http://placeimg.com/100/200/any">
						<h1 class="h hov3">
								<%=moviedto.getMovie_name()%>
						</h1>
					</div>
				<%} %>
			</div>
			<!-- 네비게이션 버튼 -->
			<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
			<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
		
			<!-- 페이징 -->
			<div class="swiper-pagination"></div>
	</div>
</div>

<!-- @@@@@@@@@@ 맞춤 추천 -->
	<div class="outbox" style="width:640px">
		<div class="row left">
			맞춤 영화
		</div>
			<div class="row swiper-container">
	
			<div class="swiper-wrapper">
				<%for(MygenreDtoVO mydto : mygenreList){ %>
					<div class="movie movie_detail swiper-slide">
					<img class="hov" src="http://placeimg.com/100/200/any">
					<h1 class="h hov4">
							<%=mydto.getGenre_name()%>
					</h1>
					</div>
				<%} %>
			</div>
			<!-- 네비게이션 버튼 -->
			<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
			<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
		
			<!-- 페이징 -->
			<div class="swiper-pagination"></div>
		</div>
	</div>
	
	
</div>
