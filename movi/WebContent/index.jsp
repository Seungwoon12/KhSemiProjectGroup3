<%@page import="javax.swing.JOptionPane"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.util.Collections"%>
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
	List<MovieDtoVO> movieAudList = movieDao.select_aud(startPage,endPage);
	
	//검색용 영화 이름 찾기
	List<MovieDto> searchList = movieDao.search_movie_name();
	//배열로 바꿔주기
	MovieDto[] arr = searchList.toArray(new MovieDto[searchList.size()]);

	
	boolean isLogin = session.getAttribute("check") != null;
	

%>
<!-- 이거 jquery css로 만들기! -->
<style>
.hov{
	transform: scale(1);
  	transition: all 0.3s ease-in-out;   /* 부드러운 모션을 위해 추가*/
}
	.hov:hover{
		opacity: 0.5;
		 transform: scale(1.2);
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
     
    .box{
    	    margin-left: 15%;
    }   
   .name{
	  float: left;
	  width:27%;
	  text-align: center;
   }
   .recom{
	   float:left
	   width:70%;
   }
   .name,.recom{
	   	height:300px;
	   	padding: 0.5rem;
   }
	
	.main{
		width:100%;
		height: 500px;
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
    
 <!--검색-->   
    .ui-autocomplete {
	max-height: 100%;
	overflow-y: auto;
	overflow-x: hidden;
}

.swiper-button-prev,.swiper-button-next{
	opacity:100 !important;
	cursor: pointer !important;
	pointer-events: all !important;	
}

.n1,.p1{
	width:50px;
	height:50px;
	background-size: 55px;
}
.n1{
	background-image: url("./img/next1.png") !important;
}
.p1{
	background-image: url("./img/prev1.jpg") !important;
}

.n2,.p2{
	width:31px;
	height:40px;
	background-size: 43px;
}
.n2{
	background-image: url("./img/next.png") !important;
}
.p2{
	background-image: url("./img/pre.png") !important;
}

.movie_recom{
	width : 395px !important;
}
.movie_detail{
	padding:17px;
	margin:10px;
}
.rank{
	position: absolute;
    top: 5px;
    left: 10px;
    z-index: 999;
    background-color: cornflowerblue;
    width: 25px;
    height: 26px;
    font-size: larger;
    text-align: -webkit-center;
    border-radius: 35%;
}

/*팝업창*/
.loading-wrapper{
    background-color: rgba(0,0,0,0.5);
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index:9999;
    display:none;
    
}
.loading-wrapper>a{
	width:500px;
	height:600px;
	z-index:9999;
    position: fixed;
    left: 37%;
    top:20%
}
.close{
	width: 39px;
    position: fixed;
    top: 21%;
    left: 62%;
    z-index: 999999999;
    cursor: pointer;
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
			location.href="/movi/category/detail.jsp?movie_no="+$(this).children('.no').text();
		})
		
		//스와이퍼1
		new Swiper('.swiper1', {
			slidesPerView: 2,
		    slidesPerGroup: 2,
	        loopFillGroupWithBlank : true,

			loop : true,
			autoplay:{
			      delay:3000,
			      disableOnInteraction: false,
			    },
			
			pagination : { // 페이징 설정
				el : '.swiper-pagination',
				clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
			},
			navigation : { // 네비게이션 설정
				nextEl : '.n1', // 다음 버튼 클래스명
				prevEl : '.p1', // 이번 버튼 클래스명
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
				nextEl : '.n2', // 다음 버튼 클래스명
				prevEl : '.p2', // 이번 버튼 클래스명
			},
		});

//******************************검색기능
	
    var searchSource = [
    <%for(int i=0; i<arr.length; i++){%>
    		"<%=arr[i].getMovie_name()%>",
 	<%}%>
    ];
	
     $("#searchInput").autocomplete({  //오토 컴플릿트 시작
         source : searchSource,    // source 는 자동 완성 대상
         open: function(event, ui) {
             $(this).autocomplete("widget").css({
                 "width": 180
             });
         },
         autoFocus: true,
         classes: { 
             "ui-autocomplete": "highlight"//선택된거에 하이라이트
         },
         delay: 0,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
         position: { my : "left top", at: "left bottom"}//위치
     });
     
     $(".close").click(function(){
    	 $(".loading-wrapper").hide();
     });
     
});
     $(document).ready(function(){
    	 $(".loading-wrapper").show();
     });
	
</script>


<!-- 팝업창 -->
<div class="loading-wrapper">
	<img src="./img/close.jpg" class="close">
	<a href="/movi/event/main.jsp">
		<img src="https://img.pooq.co.kr/service30/crm/3m66upgrade_layerpopup_pc.jpg">
	</a>
</div>


<div class="outbox" style="width:100%">

	<div class="main" style="height:295px">
		<div class="name">
		
		<!-- 영화 이름으로 검색하고 , 같은 이름이 있을수도 있으니 한번더 걸러주는 작업을 한다!! -->
		<form action="/movi/category/search.jsp" method="get">
			<div>	
			
<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@검색기능 -->

				<input name="movie_name" class="input input-hint unit slot id" 
						placeholder="영화명을 입력하세요" type="text" style="width:180px"
						id="searchInput">
				<input type="submit" value="검색">
			</div>
		</form>
			
			<div class="center" style="width:100%">
				<h1>MOVI</h1>
				<h5>모두의 비디오, 모비</h5>
			</div>
		</div>
		
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 3조 추천 영화 -->	
		<div>
		<div class="row swiper-container swiper1" style="width:800px">
	
			<div class="row recom swiper-wrapper">
				<%for(RecommendDto recomdto : recomList){%>
					<div class="movie movie_recom swiper-slide">
						<img class="hov" src="https://placehold.it/300X250?text=IMAGE">
						<h1 class="h hov1">
								<%=recomdto.getRecom_title()%>
						</h1>
					</div>
				<%} %>
			</div>	
			<!-- 네비게이션 버튼 -->
			<div class="swiper-button-next n1"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
			<div class="swiper-button-prev p1"></div><!-- 이전 버튼 -->
		
			<!-- 페이징 -->
			<div class="swiper-pagination"></div>
		</div>
	</div>

<hr>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 좋아요 순위 -->

	<div class="outbox box">
		<div class="row left">
			모비 좋아요 순위
		</div>
		
		
		<div class="row swiper-container swiper2">
	
			<div class="swiper-wrapper">
				<%for(MovieDtoVO lovedto : movieLoveList){ %>
					<div class="movie movie_detail swiper-slide">
					<div class="rank"><%=lovedto.getRank() %></div>
						<div class="no" hidden="true"><%=lovedto.getMovie_no() %></div><!-- 영화번호 -->
						<img class="hov" src="https://placehold.it/100X200?text=IMAGE">
						<h1 class="h hov2">
								<%=lovedto.getMovie_name()%>
						</h1>
					</div>
				<%} %>
			</div>
		
			<!-- 네비게이션 버튼 -->
			<div class="swiper-button-next n2"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
			<div class="swiper-button-prev p2"></div><!-- 이전 버튼 -->
		
			<!-- 페이징 -->
			<div class="swiper-pagination"></div>
		</div>	
	</div>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 관객수 순위 -->

	<div class="outbox box">
		<div class="row left">
			모비 관객수 순위
		</div>
		<div class="row swiper-container swiper2">
	
			<div class="swiper-wrapper">
				<%for(MovieDtoVO moviedto : movieAudList){ %>
					<div class="movie movie_detail swiper-slide">
					<div class="rank"><%=moviedto.getRank() %></div>
						<div class="no" hidden="true"><%=moviedto.getMovie_no()%></div><!-- 영화번호 -->
						<img class="hov" src="https://placehold.it/100X200?text=IMAGE">
						<h1 class="h hov3">
								<%=moviedto.getMovie_name()%>
						</h1>
					</div>
				<%} %>
			</div>
			<!-- 네비게이션 버튼 -->
			<div class="swiper-button-next n2"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
			<div class="swiper-button-prev p2"></div><!-- 이전 버튼 -->
		
			<!-- 페이징 -->
			<div class="swiper-pagination"></div>
	</div>
</div>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 맞춤 추천 -->

<!-- 로그인 했을 경우엔 맞춤 영화를 보여준다! -->
<%	if(isLogin){
	//null값을 처리해주기 위해 자료형은 Integer로 설정
	Integer member_check = (Integer)session.getAttribute("check");
	
	//내가 좋아하는 장르의 영화 리스트
	List<MovieDto> favgenre_movieList =movieDao.find_movie(member_check);
	//랜덤으로 섞어주기
	Collections.shuffle(favgenre_movieList);
	
	if(!(favgenre_movieList.isEmpty())) {%>

	<div class="outbox box">
		<div class="row left">
			맞춤 영화
		</div>
			<div class="row swiper-container swiper2">
	
			<div class="swiper-wrapper">
		
				<%for(MovieDto mydto : favgenre_movieList){ %>
					<div class="movie movie_detail swiper-slide">
					<div class="no" hidden="true"><%=mydto.getMovie_no()%></div><!-- 영화번호 -->
					<img class="hov" src="https://placehold.it/100X200?text=IMAGE">
					<h1 class="h hov4">
							<%=mydto.getMovie_name()%>
					</h1>
					</div>
				<%} %>
			</div>
			<!-- 네비게이션 버튼 -->
			<div class="swiper-button-next n2"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
			<div class="swiper-button-prev p2"></div><!-- 이전 버튼 -->
		
			<!-- 페이징 -->
			<div class="swiper-pagination"></div>
		</div>
	</div>
<%} } %>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>