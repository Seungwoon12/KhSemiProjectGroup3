<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<style>
	
	main, header, nav, 
	footer
	 {
		border: 1px dotted #ccc;
	}
	
	main {
		width:1200px;
		margin:auto;
	}
	
	header, footer, nav, section {
		padding:1rem;
	}
	
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
			<a href="#">카테고리</a>
			<a href="<%=request.getContextPath()%>/review/list.jsp">리뷰</a>
			<a href="#">마이페이지</a>
		</nav>
	<section>

