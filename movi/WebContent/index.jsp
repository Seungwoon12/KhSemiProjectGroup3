<%@page import="movi.beans.MygenreDtoVO"%>
<%@page import="movi.beans.MovieDtoVO"%>
<%@page import="movi.beans.GenreDto"%>
<%@page import="movi.beans.GenreDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="movi.beans.MygenreDto"%>
<%@page import="movi.beans.MygenreDao"%>
<%@page import="movi.beans.MemberDto"%>
<%@page import="movi.beans.MemberDao"%>
<%@page import="movi.beans.LoveDao"%>
<%@page import="movi.beans.RecommendDto"%>
<%@page import="movi.beans.RecommendDao"%>
<%@page import="java.util.List"%>
<%@page import="movi.beans.MovieDao"%>
<%@page import="movi.beans.MovieDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

<jsp:include page="/template/header.jsp"></jsp:include>

<%
	//페이징
	int startPage=1;
	int endPage=10;

	
	//3조추천
	RecommendDao recomDao = new RecommendDao();
	List<RecommendDto> recomList = recomDao.select_title();
	
	
	//좋아요순
	MovieDao movieDao = new MovieDao();
	List<MovieDtoVO> movieLoveList = movieDao.select_love(startPage,endPage);
		
	//관객순
	List<MovieDto> movieAudList = movieDao.select_aud(startPage,endPage);
	
	//검색용 영화 이름 찾기
	List<MovieDto> searchList = movieDao.search_movie_name();
	//배열로 바꿔주기
	MovieDto[] arr = searchList.toArray(new MovieDto[searchList.size()]);
	
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.select(1);
	
	//세션 회원 맞춤순--로그인 화면 구현시 테스트
	//request.getSession().setAttribute("check", memberDto.getMember_no());
	//int genre = (int)session.getAttribute("check");
	
//아직 멤버 세션 못받아왔음
//만약 멤버 번호가 2일 때를 가정하고 보여주는거임
	int member_no=2;
	//장르별
	MygenreDao mygenreDao = new MygenreDao();
	List<MygenreDtoVO> mygenreList = mygenreDao.find(member_no);

//멤버가 선호하는 장르의 영화들을 나열
//만약 좋아하는 장르가 로맨스라고 가정했을 때
	String genre_name="로맨스";
	GenreDao genreDao = new GenreDao();
	List<GenreDto> genreList = genreDao.find_movie(genre_name); 
	
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
	    left: 10px;
	    
	}
	.hov:hover +.hov1{
		top:50px;
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
	  text-align: center;
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
		margin:5px;
		
	}
	.swiper-slide img {
	box-shadow:0 0 5px #555;
}
	.swiper-slide{
	width:141px !important;
	margin-left:8px;
	justify-content: center;
	}
	.swiper-container {
    width: 779px;
    }
    .ui-autocomplete {
	max-height: 100%;
	overflow-y: auto;
	overflow-x: hidden;
	width:150px;
}

.swiper-button-prev,.swiper-button-next{
	background-image: url("./img/pre.png") !important;
	opacity:100 !important;
	cursor: pointer !important;
	width:31px;
	height:40px;
	background-size: 43px;
	pointer-events: all !important;
	
}
.swiper-button-prev{
	background-image: url("./img/pre.png") !important;
}
.swiper-button-next{
	background-image: url("./img/next.png") !important;
}

.movie_recom{
	width : 388px !important;
}
.movie_detail{
	padding:17px;
	margin:10px;
}
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
		
		//스와이퍼1
		new Swiper('.swiper1', {
			slidesPerView : 2, // 동시에 보여줄 슬라이드 갯수
			spaceBetween : 4, // 슬라이드간 간격
			slidesPerGroup : 2, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음
			//loop
			
			pagination : { // 페이징 설정
				el : '.swiper-pagination',
				clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
			},
			navigation : { // 네비게이션 설정
				nextEl : '.swiper-button-next', // 다음 버튼 클래스명
				prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
			},
		});
		//스와이퍼1
		new Swiper('.swiper2', {
			slidesPerView : 5, // 동시에 보여줄 슬라이드 갯수
			spaceBetween : 4, // 슬라이드간 간격
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
		
		//검색기능
       var searchSource = [
       <%for(int i=0; i<arr.length; i++){%>
      	 "<%=arr[i].getMovie_name()%>",
    	<%}%>
       ]	
        $("#searchInput").autocomplete({  //오토 컴플릿트 시작
            source : searchSource,    // source 는 자동 완성 대상
            focus : function(event, ui) { 
                return false;//한글 에러 잡기용도로 사용됨
            },
            minLength: 1,// 최소 글자수
            autoFocus: true,
            classes: { 
                "ui-autocomplete": "highlight"//선택된거에 하이라이트
            },
            delay: 0,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
            position: { my : "left top", at: "left bottom"}//위치
        });
	});
</script>

<div class="outbox" style="width:100%">

	<div class="main" style="height:295px">
		<div class="name">
		
		<form action="/movi/category/detail.jsp" method="get">
			<div>	
<!--검색기능 -->
				<input name="movie_name" class="input input-hint unit slot id" 
						placeholder="영화명을 입력하세요" type="text" style="width:200px"
						id="searchInput">
				<input type="submit" value="검색">
			</div>
		</form>
			
			<div class="center" style="width:100%">
				<h1>MOVI</h1>
				<h5>모두의 비디오, 모비</h5>
			</div>
		</div>
		
<!-- @@@@@@@@@@ 3조 추천 영화 -->	
		<div>
		<div class="row swiper-container swiper1">
	
			<div class="row recom swiper-wrapper">
				<%for(RecommendDto recomdto : recomList){%>
					<div class="movie movie_recom swiper-slide">
						<img class="hov" src="http://placeimg.com/300/250/any">
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

	<div class="outbox" style="width:640px">
		<div class="row left">
			모비 좋아요 순위
		</div>
		
		
		<div class="row swiper-container swiper2">
	
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
		<div class="row swiper-container swiper2">
	
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
			<div class="row swiper-container swiper2">
	
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
<jsp:include page="/template/footer.jsp"></jsp:include>