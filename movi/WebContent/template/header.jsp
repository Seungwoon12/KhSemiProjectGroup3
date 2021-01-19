<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOVI</title>
<link rel="stylesheet" type="text/css" href="/home/css/common.css">

<style>

	main,header,nav,section,aside,article,footer,
	div, label, span, p{
		border : 1px dotted gray;
	}
	header
	main{
		width:100%;
		margin:auto;
		padding: 10px;
	}
	header,footer,nav,section{
		padding:1rem; 
	}
	section{
		min-height:500px;
		height: 100%; 
	}
	nav{
		padding-left:20%;
	}
</style>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
</script>
</head>

<body>
	<main>
		<header class="center">
			<p>movi</p>
		</header>
		<nav>
			
			<a href="#">홈</a>
			<a href="#">로그아웃</a>
			<a href="#">내정보</a>
			<a href="#">게시판</a>
					
		</nav>
	<section>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 화면 template</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
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
		width:100%;
		margin:auto;
	}
	
	header{
		width:100%;
		height: 40px;
	}
	
	section{
	height: 100%;
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
<script >

</script>
</head>
<body>
		<main>
		<header>
		<h2>MOVI</h2>
		</header>
		<nav>
		</nav>
>>>>>>> refs/remotes/origin/main
