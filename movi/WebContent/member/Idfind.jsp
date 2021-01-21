
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<script>
	function submitFindLoginIdForm(form) {
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();
			return;
		}

alert("존재하지 않은 계정입니다");

</script>

<form action="Idfind.jsp" method="post">
                             <input type="text" size="20" name="userName" placeholder="닉네임을 입력해주세요">
                               <br class="clear">
                            <p>전화번호:</p>
                              <input type="text" size="20" name="userNumber" placeholder=" - 를 제외하고 번호 전체를 입력해주세요.">
                               <br class="clear">
                           
 </form>

<jsp:include page="/template/footer.jsp"></jsp:include>