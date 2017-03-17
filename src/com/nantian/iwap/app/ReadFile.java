package com.nantian.iwap.app;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.FileInputStream;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.Reader;
import java.io.UnsupportedEncodingException;

import com.nantian.iwap.app.util.PasswordEncrypt;

public class ReadFile {
	private static String encryptClazz="com.nantian.iwap.app.util.DefaultEncrypt";//默认加密方式
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		String encoding = "GBK";//txt默认为GBK类型
		String filePath = "D:\\dept_level.txt";
		try {
			FileInputStream file = new FileInputStream(filePath);

			InputStreamReader read = new InputStreamReader(file, encoding);
			BufferedReader bufferedReader = new BufferedReader(read);
			String lineTxt = null;
			while ((lineTxt = bufferedReader.readLine()) != null) {
				//加密密码
				/*PasswordEncrypt encrypt=(PasswordEncrypt)Class.forName(encryptClazz).newInstance();
				String pwd=encrypt.encryptPassword(lineTxt, "123456");
				System.out.println(pwd);*/
				//部门名称
				/*String[] org_nm = lineTxt.split("/");
				System.out.println(org_nm[org_nm.length-2]);*/
				//部门级别
				String[] org_nm = lineTxt.split("/");
				System.out.println(org_nm.length-1);
			}
			read.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("读取文件内容出错");
			e.printStackTrace();
		}
	}

}
