
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>


 <div align="center">
    <h2>비밀번호 재설정</h2>
<form action="Id_find.do" method="post">
         <p>아이디:</p><input type="text"  name="name" placeholder="아이디를 입력해주세요" required></input>    
         <p>전화번호:</p><input type="tel"  name="phone" placeholder=" - 를 제외하고 번호 전체를 입력해주세요." required></input>
         <p>임시비밀번호 받기:</p><input type="submit" name="password" vlaue= "임시비밀번호받기"></input>

                           
 </form>

<jsp:include page="/template/footer.jsp"></jsp:include>