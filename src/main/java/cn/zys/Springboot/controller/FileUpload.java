package cn.zys.Springboot.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


@Controller
public class FileUpload {
	


    @ResponseBody
    @RequestMapping("/fileUpload")
    public Map<String, Object> fileUpload(@RequestParam(value = "file", required = false) MultipartFile file,
    	 HttpServletRequest request, HttpSession session) throws IllegalStateException, IOException{
    	
    	String filePath = request.getSession().getServletContext().getRealPath("")+"fileUpload"+File.separator;
        Map<String, Object> map=new HashMap<String, Object>();
        String myFileName = "";
        File fileDir = null;
		if (null != file) {
			myFileName = file.getOriginalFilename();// 文件原名称
			
			
			System.out.println(myFileName);
			fileDir = new File(filePath, myFileName);
				
			if (!fileDir.getParentFile().exists()) { // 如果不存在 则创建
				fileDir.getParentFile().mkdirs();
			}
			try {

				file.transferTo(fileDir);

			} catch (Exception e) {

			}
	        map.put("code", 0);
	        map.put("msg", "上传成功");
	        map.put("data", myFileName);
		} else {
			map.put("code", 500);

		}


        
        return map;

    }
    
	@RequestMapping("/filesUpload")
	public String listUser(Model model) {
		return "views/fileUpload";
	}
	

	
}
