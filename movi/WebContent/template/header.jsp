<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<style>
	/* 화면 레이아웃 스타일 */
	
	/* 모든 영역은 점선으로 테두리가 표시되게 한다(테스트용) */
	main, header, nav, 
	footer
	 {
		border: 1px dotted #ccc;
	}
	/* 전체 화면의 폭은 100% 로 한다 */
	main {
		width:1200px;
		margin:auto;
	}
	/* 각각의 레이아웃 영역에 여백을 설정한다 */
	header, footer, nav, section {
		padding:1rem;
	}
	/* 본문에 내용이 없어도 최소높이를 설정하여 일정 크기만큼 표시되도록 한다 */
	section {
		min-height: 450px;
	}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>

</script>
</head>
<body>
	<main>
		<header>
			<h1 class="left">movi</h1>
			<a href="#" class="left">로그인</a>
			<a href="#" class="right">이벤트</a>
		</header>
		<nav>
			<a href="<%=request.getContextPath()%>">홈</a>
			<!-- 카테고리 처음 들어갔을 때 로맨스 영화로 설정-->
			<a href="/movi/category/main.jsp?movie_genre_no=1">카테고리</a>
			<a href="<%=request.getContextPath()%>/review/list.jsp">리뷰</a>
			<a href="<%=request.getContextPath()%>/member/my.jsp">마이페이지</a>
		</nav>
	<section>

