package com.bjtu.cloud.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

public class HttpTest {
	public static void main(String[] args){
//		String jsonStr = "{id:2}";
//		JSONObject jsonObject = JSONObject.fromObject(jsonStr);
//		int id = jsonObject.getInt("id");
		
		
//		String data="{\"container_info\":[{\"sql\":\"select\",\"col\":\"containerId\"}]}";
//		JsonParser paser=new JsonParser();
//		JsonElement element=paser.parse(data);
//		JsonObject object=element.getAsJsonObject();
//	    JsonArray array=paser.parse(object.get("container_info").toString()).getAsJsonArray();
//	    if(array.size()>0){
//	    	for(JsonElement  obj:array){
//		    	String date=obj.getAsJsonObject().get("sql").toString();
//		    	String forecast	=obj.getAsJsonObject().get("col").toString();
//		    	System.out.println(date);
//		    	System.out.println(forecast);
//	    	}
//	    }
		List<Map<String, String>> listmap=new ArrayList<Map<String, String>>();
		Gson gson = new Gson();
		//把map换成对象就行了
		Map<String,String> m1=new HashMap<String,String>();
		Map<String,String> m2=new HashMap<String,String>();
		m1.put("1", "ww");
		m2.put("2", "rr");
		listmap.add(m1);
		listmap.add(m2);
		String s2 = gson.toJson(listmap);
		System.out.println(s2);
		
		List<Map<String,String>> retList = gson.fromJson(s2,  
                new TypeToken<List<Map<String,String>>>() {  
                }.getType());  
        for (Map<String,String> stu : retList) {  
            System.out.println(stu);  
        }  
	}
}
