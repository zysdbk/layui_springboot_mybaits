
package cn.zys.Springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
 
import cn.zys.Springboot.bean.User;
import cn.zys.Springboot.mapper.UserMapper;
 
@Service
public class UserService {
	@Autowired
	private UserMapper userMapper;
	
	/**
	 * 获取全部的用户
	 * @return
	 */
	public List<User> findAll() {
		return userMapper.findAll();
	}
	
	/**
	 * 分页获取用户
	 * @return
	 */
	public List<User> findUserBylimit(int limit,int page) {
		return userMapper.findUserBylimit(limit,page);
	}
	
	/**
	 * 模糊查询获取用户
	 * @return
	 */
	public List<User> searchUser(User user) {
		return userMapper.searchUser(user);
	}
	
	/**
	 * 查询用户角色
	 * @param user
	 */
	
	public String searchRole(String name) {
		return userMapper.searchRole(name);
	}
	/**
	 * 添加用户
	 * @param user
	 */
	@Transactional
	public void addUser(User user) {
		userMapper.addUser(user);
	}
	
	/**
	 * 修改用户
	 * @param user
	 */
	@Transactional
	public void updateUser(User user) {
		userMapper.updateUser(user);
	}
	
	/**
	 * 删除用户
	 * @param id
	 */
	@Transactional
	public void deleteUser(int id) {
		userMapper.deleteUser(id);
	}
	
	/**
	 * 查询指定用户
	 * @param id
	 * @return
	 */
	public User findById(int id) {
		
		return userMapper.findById(id);
	}
	
	@Transactional
	public User logon(User user) {
		
		return userMapper.logon(user);
	}
	
	@Transactional
	public User cheakName(User user) {
		
		return userMapper.cheakName(user);
	}

}

