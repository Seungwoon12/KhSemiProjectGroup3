<%@page import="javax.swing.JOptionPane"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.util.Collections"%>
<%@page import="movi.beans.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

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
<style>

/*영화 이미지 hover시 효과*/
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
	
/*검색창 왼쪽 여백 주기*/	
	.unit.slot.id{
	      background-image: url(./img/search.jpg);
	      background-size: contain;
	      background-repeat: no-repeat; 
	}
	
/*검색 아래로 내려오는 창*/  
    .ui-autocomplete {
	max-height: 100%;
	overflow-y: auto;
	overflow-x: hidden;
}

/*상단 제목과 추천영화 스타일*/
	.title{
		margin-top: 20%
	}
	.big_name{
		font-size: 49px;
	    font-family: sans-serif;
	    color: #4E6FA6;
	    font-weight: bolder;
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
	
/*상단화면*/	
	.main{
		width:100%;
		height: 500px;
	}
/*하단화면*/	
	.body{
		width:100%;
		height:100%;
	}     
/*아래 영화 리스트들 왼쪽 간격*/     
	.box{
	   margin-left: 20%;
	}   

/*swiper 속성*/	
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
	/*아래 container만 적용*/
	.swiper-container {
	    width: 779px;
	    height:19%;
    }
    .swiper1{
    	height:100%;
    }
    /*이미지 사이 간격*/
   	.movie{
	padding: 0.2rem;
	}
  
/*이전, 다음 버튼 전체 속성*/
.swiper-button-prev,.swiper-button-next{
	opacity:100 !important;
	cursor: pointer !important;
	pointer-events: all !important;	
}
/*이전, 다음 버튼 각각의 속성, 이미지*/
.n1,.p1{
    width: 49px;
    height: 56px;
    background-size: 50px;
}
.n1{background-image: url("./img/nnext.png") !important;}
.p1{background-image: url("./img/prev1.png") !important;}

.n2,.p2{
	width:31px;
	height:40px;
	background-size: 43px;
}
.n2{background-image: url("./img/next.png") !important;}
.p2{background-image: url("./img/pre.png") !important;}



/*영화 리스트들 너비나 속성들*/
.movie_recom{
	width : 395px !important;
}
.movie_detail{
	padding:17px;
	margin:10px;
}
/*아이콘*/
.icon{
	width:60px;
	float:left;
}
.icon+h4{
	display:inline-block;
}

/*좋아요, 관객수 순위 숫자 모양*/
.rank{
    opacity: 0.8;
	position: absolute;
    top: 5px;
    left: 10px;
    z-index: 999;
    background-color: #4E6FA6;
    color:white;
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
    left: 33%;
    top:20%
}
/*팝업창 닫기*/
.close{
	width: 39px;
    position: inherit;
    top: 21%;
    left: 60%;
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
		    spaceBetween : 50,
		    slidesPerGroup: 2,
	        loopFillGroupWithBlank : false,

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
     
//팝업창!!!!!!!!!!
     $(".close").click(function(){
    	 $(".loading-wrapper").hide();
     });
       
     $(document).ready(function(){
    	 $(".loading-wrapper").show();
     });
 
});
	
	
</script>

<!-- 팝업창 -->
<div class="loading-wrapper">
	<img src="./img/close.jpg" class="close">
	<a href="/movi/event/detail.jsp?event_no=41">
		<img src="./img/event.PNG">
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
			
			<div class="title">
				<div class="big_name">MOVI</div>
				<div class="small_name">모두의 비디오, 모비</div>
			</div>
		</div>
		
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 3조 추천 영화 -->	
		<div>
		<div class="row swiper-container swiper1" style="width:840px; height:100%">
	
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
	</div>
<hr>
	<div class="body">
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 좋아요 순위 -->

		<div class="outbox box">
			<div class="row left">
			<img src="./img/like.png" class="icon">
				<h4>모비 좋아요 순위</h4>
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
			<img src="./img/view.png" class="icon">
				<h4>모비 관객수 순위</h4>
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
		<img src="./img/recom.png" class="icon">
			<h4>맞춤 영화</h4>
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
<%} } %>
</div>
</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>