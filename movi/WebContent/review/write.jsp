<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="movi.beans.*"%>   
    
<jsp:include page="/template/header.jsp"></jsp:include>

<%
	String movie_name = request.getParameter("movie_name");
	MovieDao movieDao = new MovieDao();
	List<MovieDto> movieList = movieDao.select_movie(movie_name);
	
%>

<style>
	/*검색창 왼쪽 여백 주기*/	
	.search{
	      background-image: url(../img/search.jpg);
	      background-size: contain;
	      background-repeat: no-repeat; 
	      border:1px solid lightgray;
	}
	
		.main,
        .main ul{
            list-style: none;
            margin: 0;
            padding: 30px;
        }
        .main{
        	width :100%;
        }
        .main a{
            color: black;
            text-decoration: none;
        }
   			
        .list{
        	width:215px;
        	padding :0.5rem;
        	display: none;
        	
        }
        
        .search-btn{
        	cursor:pointer;
        	border-radius:4px;
			padding: 9px 16px;
			font-size: 18px;
			/*padding:0.5rem;*/
			background-color: #4E6FA6;
			color:white;
			border:none;
        }
        #regist-btn{
        	cursor:pointer;
        	border-radius:4px;
			font-size: 18px;
			width:100px;
			padding:0.5rem;
			background-color: #4E6FA6;
			color:white;
			border:none;
        }
        textarea{
			resize: none;        
        }
        img{
        	width:200px;
        	height:300px;
        }
       
      

</style>

<script>
	$(document).ready(function(){
	
		$(".list").slideDown(500);
		$(".list").css("display","inline-block");
		
		
		
		//영화 제목 및 내용 작성란 기본 숨김처리
		$(".write-form").hide();
		
		$("input[name=movie_no]").click(function(){
			var movie_selected = "";
			var confirm = window.confirm("선택하신 영화의 리뷰를 작성하시겠습니까?");
			
			if(confirm){
				movie_selected = $(this).val();
				console.log(movie_selected);
				document.getElementById("movie_selected_no").value = movie_selected;
				$(".write-form").show();
			}
			else {
					$(this).removeProp("checked");
					document.getElementById("movie_selected_no").value = "";
			}
		
		});
		
		//게시글 등록버튼 이벤트
		$("#regist-btn").click(function(e){
			var movie_selected_no = document.querySelector("input[name=movie_selected_no]");
			var review_title = document.querySelector("input[name=review_title]");
			var review_content = document.querySelector("textarea[name=review_content]");
			
			if(!movie_selected_no.value) {
				e.preventDefault();
				window.alert("영화를 선택하세요.");
			}
			
			else if(!review_title.value) {
				e.preventDefault();
				window.alert("제목을 입력하세요.");
			}
			
			else if(!review_content.value) {
				e.preventDefault();
				window.alert("내용을 입력하세요.");
			}
			
			
		});
		
	});
	
</script>


<div class="outbox" style="width:1100px;">
	<div class="row center">
		<h2>영화명을 입력한 후 해당하는 영화를 선택해주세요.</h2>
	</div>
	
	<div class="row center">
		<form action="write.jsp" method="get">
			<input type="text" name="movie_name" class="input input-hint search" placeholder="영화명을 입력하세요." style="width:350px; height:40px">
			<input type="submit" value="검색" class="input input-inline search-btn">
		</form>
	</div>
	
		

<ul class="main movie_list">
	
<%for(MovieDto dto : movieList){ %>
 	<li class="list">
		<a href="../category/detail.jsp?movie_no=<%=dto.getMovie_no()%>">
			<img src ="../poster-down.do?movie_no=<%=dto.getMovie_no()%>">
		</a>
		
		<label for="movie_no<%=dto.getMovie_no()%>" style="white-space: nowrap;"><%=dto.getMovie_name() %></label>
		<input id="movie_no<%=dto.getMovie_no()%>" type="radio" name="movie_no" value="<%=dto.getMovie_no()%>" required>
		<%
			String genre = movieDao.getGenre(dto.getMovie_genre_no());
		%>
		<div>
			<span>개요:</span>
			<label><%=genre%> |</label>
			<label><%=dto.getMovie_country()%> |</label>
			<label><%=dto.getMovie_time()%>분</label>
		</div>
		<div>
			<span>개봉:</span>
			<label><%=dto.getMovie_date()%></label>
		</div>
		<div>
			<span>감독:</span>
			<label><%=dto.getMovie_director()%></label>
		</div>
 	</li>
<%}%>

</ul>

		
<form action="write.do" method="post">
	<div class="outbox write-form">	
		<input id="movie_selected_no" type="hidden" name="movie_selected_no">
		<div class="row">
			<input type="text" name="review_title" class="input" placeholder="제목을 입력하세요." style="border:1px solid lightgray;">
		</div>
		<div class="row">
			<textarea name="review_content" rows="20" class="input" placeholder="내용을 입력하세요." style="border:1px solid lightgray;"></textarea>
		</div>
		<div class="row center">
			<input id="regist-btn" type="submit" value="등록하기" class="input input-inline">	
		</div>
	</div>
</form>

</div>



<jsp:include page="/template/footer.jsp"></jsp:include> 