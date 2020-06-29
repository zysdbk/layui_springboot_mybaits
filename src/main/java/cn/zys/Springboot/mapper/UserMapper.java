
package cn.zys.Springboot.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;


import cn.zys.Springboot.bean.User;
 
@Mapper
public interface UserMapper {
	/**
	 * 全部用户查询
	 * @return
	 */
	@Select("SELECT ID,NAME,PASSWORD FROM S_USER")
	List<User> findAll();
	
	/**
	 * 分页用户查询
	 * @return
	 */
	@Select("SELECT ID,NAME,PASSWORD FROM S_USER limit #{page},#{limit}")
	List<User> findUserBylimit(int limit,int page);
	
	/**
	 * 模糊用户查询
	 * @return
	 */
	@Select("SELECT ID,NAME,PASSWORD FROM S_USER WHERE "
			+ "NAME LIKE CONCAT('%',#{name},'%') AND PASSWORD LIKE CONCAT('%',#{password},'%')")
	List<User> searchUser(User user);
	
	/**
	 * 新增用户
	 */
	@Insert("INSERT INTO S_USER(NAME,PASSWORD)VALUES(#{name}, #{password})")
	void addUser(User user);
	
	/**
	 * 修改用户
	 */
	@Update("UPDATE S_USER SET NAME=#{name}, PASSWORD=#{password} WHERE ID=#{id}  ")
	void updateUser(User user);
	
	/**
	 * 删除用户
	 */
	@Delete("DELETE FROM S_USER WHERE ID=#{id} ")
	void deleteUser(int id);
	
	/**
	 * 根据ID查询单个用户
	 */
	@Select("SELECT ID,NAME,PASSWORD FROM S_USER WHERE ID=#{id}")
	User findById(@Param("id")int id);
	
	/**
	 * 用户登录查询
	 */
	@Select("SELECT ID,NAME,PASSWORD FROM S_USER WHERE NAME=#{name} AND PASSWORD=#{password}"  )
	User logon(User user);
	
	/**
	 * 用户名是否重复查询
	 */
	@Select("SELECT ID,NAME,PASSWORD FROM S_USER WHERE NAME=#{name} ")
	User cheakName(User user);
}
