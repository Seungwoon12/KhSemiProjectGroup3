<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<h1>전송화면</h1>
 
 <form action="poster-up.do" method="post" enctype="multipart/form-data">
 
 	<input type="file" name="poster" accept=".jpg, .png, .gif">
 
 	<input type="submit" value="업로드">
 	
 </form>