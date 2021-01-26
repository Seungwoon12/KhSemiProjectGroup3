<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<jsp:include page="/template/header.jsp"></jsp:include>
	


 <div align="center" height="40" width="430"> 
    <h2>비밀번호 재설정 </h2>
<form action="pw_find.do" method="post">

<label for="id"> 아이디:</label>
<input type="text"  name="name" placeholder="아이디를 입력해주세요" required></input>
<br>
<label for="phone"> 전화번호:</label>            
<input type="tel"  name="phone"  placeholder=" - 를 제외하고 번호 전체를 입력해주세요." required></input>

        
<input type="submit"  value="찾기" ></input>  
		
		</form>
	</div>
<jsp:include page="/template/footer.jsp"></jsp:include>