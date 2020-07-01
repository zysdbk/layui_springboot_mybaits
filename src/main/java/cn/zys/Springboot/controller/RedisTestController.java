package cn.zys.Springboot.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.zys.Springboot.bean.RedisUtil;
 
 
/**
*@Description: redis 测试
*@Author: zyj 2018/5/26 8:12
*/
@Controller
@RequestMapping("/redisTest")
public class RedisTestController {
 
    @Autowired
    RedisUtil redisUtil;
 
    /**
    *@Description: 测试redis
    *@param key, value
    *@return Object
    *@Author: zyj 2018/5/26 8:46
    */
    @RequestMapping("/testRedisAdd")
    @ResponseBody
    Object testRedisAdd(String key,String value){
    	
        redisUtil.set(key,value);
        System.out.println(redisUtil.get(key));
        return redisUtil.get(key);
    }
 
}
