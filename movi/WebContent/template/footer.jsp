<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

		</section>
		<footer>
			<h5 class="center">footer</h5>
			
			<!-- 
				로그인 관련된 정보들을 출력
				-세션ID : 32글자의 16진수로 구성되어있으며, 접속 시 랜덤으로 발급되며 같으면 같은 사용자로 인식한다
				-check : 세션에 사용자의 번호를 저장하기 위한 값이며, 모든 페이지에서 유/무를 확인하여 로그인 처리 수행
			 -->
			<h5>세션 아이디 : <%=session.getId() %></h5>
			<h5>check : <%=session.getAttribute("check") %></h5>
		</footer>
	</main>	
</body>
</html>