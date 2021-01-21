package movi.util;

import java.util.Random;

//임시 비밀번호 문자열  합성
public class PwUtil {
	public static String generaterandonString(int size) {
		String pwString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*";
		StringBuffer buffer = new StringBuffer();
		Random r = new Random();
		
		for(int i=0; i<size; i++) {
			int index = r.nextInt(pwString.length());
			buffer.append(pwString.charAt(index));
		}
		
		String pw = buffer.toString();
		return pw;
	
	}
}
