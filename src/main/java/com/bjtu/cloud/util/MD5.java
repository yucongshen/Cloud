package com.bjtu.cloud.util;

import java.math.BigInteger;
import java.security.MessageDigest;

public class MD5 {

	public static String getMD5Value(String value){
		try{
			//1.消息摘要算法
			MessageDigest messageDigest = MessageDigest.getInstance("MD5");
			//2.加密 获得10进制
			byte[] md5ByteArr = messageDigest.digest(value.getBytes());
			//3.将10进制 转换16进制
			BigInteger bigInteger = new BigInteger(1,md5ByteArr);
			
			return bigInteger.toString(16);
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}
	
}
