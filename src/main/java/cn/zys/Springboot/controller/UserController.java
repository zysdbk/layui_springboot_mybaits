package cn.zys.Springboot.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import cn.zys.Springboot.bean.RedisUtil;
import cn.zys.Springboot.bean.User;
import cn.zys.Springboot.service.UserService;



@Controller
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	RedisUtil redisUtil;
	
	@RequestMapping("/listUser")
	public String listUser(Model model) {
		return "mainSheet";
	}
	
    @ResponseBody
    @RequestMapping("/allUser")
    public Map<String, Object> getall() {
    	User userdemo = new User();
        
        Map<String, Object> map=new HashMap<String, Object>();
        List<User> users = userService.findAll();
        
        map.put("data", users);
        map.put("status", 0);
        map.put("message", "");
        map.put("total", users.size());
        return map;

    }
    
    @ResponseBody
    @RequestMapping("/searchUser")
    public Map<String, Object> searchUser(HttpServletRequest request) {
    	User user = new User();
    	
    	String name = request.getParameter("user[name]");
    	String password = request.getParameter("user[password]");
    	user.setName(name);
    	user.setPassword(password);
        Map<String, Object> map=new HashMap<String, Object>();
        List<User> users = userService.searchUser(user);
        
        
        
        map.put("data", users);
        map.put("status", 0);
        map.put("message", "");
        map.put("total", users.size());
        return map;

    }
    
    @ResponseBody
    @RequestMapping("/limitUser")
    public Map<String, Object> findUserBylimit(HttpServletRequest request) {
    	int limit = 0;
    	int page = 0;
    	User userdemo = new User();
    	limit = Integer.parseInt(request.getParameter("limit"));
    	page = Integer.parseInt(request.getParameter("page"));
    	page = (page-1)*limit;
    	Map<String, Object> map=new HashMap<String, Object>();
    	List<User> users = userService.findAll();
    	users.add(0, userdemo);
        List<User> user = userService.findUserBylimit(limit,page);
        user.add(0, userdemo);
       
        map.put("data", user);
        map.put("status", 0);
        map.put("message", "");
        map.put("total", users.size());
        
        return map;

    }

	
	
	
	@ResponseBody
	@RequestMapping("/add")
	public String addUser(User user){
	
			
			User user1 = (User)userService.cheakName(user);
			
			if(user1==null) {
				
				userService.addUser(user);
				return "success";
			}else {
				
					return "error";
			}


	}
	
	
	
	@RequestMapping("/toUpdate")
	public String toUpdate(Model model, int id) {
		User user = userService.findById(id);
		model.addAttribute("user", user);
		return "/updateUser";
	}
	
	@ResponseBody
	@RequestMapping("/update")
	public String updateUser(User user) {
		System.out.println(user.getName());
		userService.updateUser(user);
		return "success";
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	public String deleteUser(int id) {
		System.out.println(id);
		userService.deleteUser(id);
		return "success";
	}
	
	
	@RequestMapping("/logon")
	public String logon(User user,HttpServletRequest request,HttpServletResponse response) throws IOException  {
			String role = null;
			if(null != user.getName() || user.getId() == 0) {
				String key = user.getName();
				
				
				String value = (String) redisUtil.get(key);
				
				if("Logged" == value) {
					request.getSession().setAttribute("sessionId", user.getId());
					request.getSession().setAttribute("name", user.getName());
					request.getSession().setAttribute("status", "已登陆");
					redisUtil.expire(user.getName() , 600);
					role = userService.searchRole(user.getName());
					if(role == null) {
						
						request.getSession().setAttribute("role", null);
					}else {
						request.getSession().setAttribute("role", role);
						
					}
					System.out.println(key);
					
					return "mainSheet";
					
				}
				
			}
			
			if(userService.logon(user)!= null) {
				
				if(user.equals(userService.logon(user))) {
					request.getSession().setAttribute("sessionId", user.getId());
					request.getSession().setAttribute("name", user.getName());
					
					redisUtil.set(user.getName(),"Logged");
					redisUtil.expire(user.getName() , 600);
					role = userService.searchRole(user.getName());
					System.out.println(role);
					if(role == null) {
						
						request.getSession().setAttribute("role", null);
					}else {
						request.getSession().setAttribute("role", role);
						
					}
					
					return "mainSheet";
				}
				
			}
			return null;
											
	}
	

	
	@RequestMapping("/index")
	public String index() {
		return "/index";
	}
	
	@RequestMapping("/")
	public String mainIndex() {
		return "/index";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if(session==null){
			return null;
		}
		session.removeAttribute("sessionId");
		session.removeAttribute("name");
		session.removeAttribute("status");
		session.removeAttribute("role");
		return "redirect:/index";
	}
	
	@RequestMapping("/mainSheet")
	public String mainSheet() {
		return "/mainSheet";
	}
	
	@RequestMapping("/console")
	public String console() {
		return "/views/console";
	}
	
	@RequestMapping("/operaterule")
	public String operaterule() {
		return "/views/operaterule";
	}
	
	@RequestMapping("/form")
	public String form() {
		return "/views/form";
	}
	
	@RequestMapping("/users")
	public String users() {
		return "/views/users";
	}
	
	@RequestMapping("/login")
	public String login() {
		return "/login";
	}
	
	@RequestMapping("/register")
	public String register() {
		return "/register";
	}
	

	
}
