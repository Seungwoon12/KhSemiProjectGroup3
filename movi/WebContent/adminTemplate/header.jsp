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
	
	/* 모든 영역은 점선으로 테두리가 표시되게 한다(테스트용) */
	main, header, nav, section, 
	aside, article, footer, div,
	label, span, p {
		border: 1px dotted #ccc;
	}
	
	/* 전체 화면의 폭은 100% 로 한다 */
	main {
		width:1200px;
		margin:auto;
	}
	
        section::after {
            content: "";
            display: block;
            clear: both;
            height:100%;
        }
	
	/* 각각의 레이아웃 영역에 여백을 설정한다 */
	header, footer, nav {
		padding:1rem;
	}
	
        aside {
            float: left;
            width: 15%;
            min-height: 400px;
        }

        article {
            float: left;
            width: 85%;
            min-height: 400px;
        }
        
        
	/* 본문에 내용이 없어도 최소높이를 설정하여 일정 크기만큼 표시되도록 한다 */
	section {
		min-height: 450px;
	}
	/*로고 만들기*/
	.logo{
            padding-left: 2rem;
            color: deepskyblue;
            font-size: 40px;
	 		
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
			<a href="#">로그아웃</a>
			<a href="<%=request.getContextPath()%>">회원모드</a>		
		</div>
		
		<h2 class="logo">MOVI</h2>
		<h4 style="color:deepskyblue;">모두의 비디오, 모비</h4>
		</header>
		<nav>
		<!-- 관리자 모드 메뉴 -->
			<a href="<%=request.getContextPath()%>/admin/main.jsp">관리자 페이지</a>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원 관리</a>
			<a href="<%=request.getContextPath()%>/admin/movieList.jsp">영화 관리</a>
			<a href="<%=request.getContextPath()%>/admin/eventList.jsp">이벤트 관리</a>
		</nav>

		<section>