package cn.zys.Springboot.controller;
import java.text.DateFormat;
import java.util.Date;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloController {

    @RequestMapping("/hello")
    public String hello(Model m){
       
        return "hello";  //视图重定向index.jsp
    }
    
    @RequestMapping("/NewFile1")
    public String NewFile1(Model m){
       
        return "NewFile1";  //视图重定向index.jsp
    }
}