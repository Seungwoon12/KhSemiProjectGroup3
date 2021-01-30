<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인 화면 template</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/yeon.css">
<style>
	/* 화면 레이아웃 스타일 */
	

   /* 각각의 레이아웃 영역에 여백을 설정한다 */
   header, footer, nav {
      padding:1rem;
   }
   	
	/* 전체 화면의 폭은 100% 로 한다 */
	main {
		width:1250px;
		margin:auto;
		min-height:1100px;
	}
	
        section::after {
            content: "";
            display: block;
            clear: both;
            height:100%;
        }
	
	
        aside {
            float: left;
            width: 17%;
            min-height:1000px;
            border-right: 3px solid lightblue;
        }

        article {
        	padding-left:15px;
            float: left;
            width: 83%;
            min-height: 400px;
        }
        
	/* 네비게이션 화면  */        
		nav{
     		font-size: larger;
     		position: sticky;
     		top: 0px;
     		background-color: white;
			}
		nav>a{
	 		padding: 1rem;
	 		text-decoration: none;
	 		color:#2f3542 ;
		}
		nav>a:hover,
		nav>a:active{
			 font-weight: bolder;
	 		color : #4E6FA6 !important;
			 text-decoration: underline;
		}        
        
	/* 본문에 내용이 없어도 최소높이를 설정하여 일정 크기만큼 표시되도록 한다 */
	section {
		min-height: 450px;
	}
	/* 메인로고 index와 비슷하게 */
	.title{
		margin-top: 4%;
		margin-bottom: 1%;
		margin-left: 2%;
	}
	.big_name{
		font-size: 49px;
	    font-family: sans-serif;
	    color: #4E6FA6;
	    font-weight: bolder;
	}
	.name{
	  float: left;
	  text-align: center;
	}
	
	/*검색창 디자인*/
	.search{
		padding :30px;
	}
	
	/*a태그 스타일 */
	.astyle{
	 		padding: 0.5rem;
	 		text-decoration: none;
	 		color:#2f3542 ;		
	}
	.astyle:hover
	.astyle:active{
			color: #4E6FA6 !important;
			font-size: 49px;
			font-weight: bolder;
	}
	/*간격*/
	.margin{
		margin:30px;
	}
	
	.padding{
		padding : 10px;
	}
	.padding1{
		padding : 7px;
	}
	.line{
		border-bottom:3px solid  lightblue;
	 	width: 1250px ;
	}
	/*항목 디자인*/
	div>a{
		padding: 1rem;
	 	text-decoration: none;
	 	color : #42444F;
	}
	div>a:hover{
		color: lightblue;
		font-weight: bolder;
	}
	
     /*통계*/
     .static {
         background-color: white;
         border: 2px solid lightblue;
         border-radius: 10px;
         color: black;
         width: 150px;
         text-align: center;
     }
	
</style>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script >

</script>
</head>
<body>
		<main>
		<header>
		<div class="right">
			<a class="astyle" href="<%=request.getContextPath()%>/member/logout.do">로그아웃</a>
			<a class="astyle" href="<%=request.getContextPath()%>">회원모드</a>		
		</div>
		
			<div class="title">
				<div class="big_name">MOVI</div>
				<div class="small_name">모두의 비디오, 모비</div>
			</div>
			
		</header>
		<nav class="line">
		<!-- 관리자 모드 메뉴 -->
			<a href="<%=request.getContextPath()%>/admin/main.jsp">관리자 페이지</a>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원 관리</a>
			<a href="<%=request.getContextPath()%>/admin/movieList.jsp">영화 관리</a>
			<a href="<%=request.getContextPath()%>/admin/eventList.jsp">이벤트 관리</a>
		</nav>
		<section >