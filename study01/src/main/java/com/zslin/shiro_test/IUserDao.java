package com.zslin.shiro_test;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

//import org.springboot.sample.entity.User;

public interface IUserDao extends CrudRepository<User, Integer> {

	@Query("select t from User t where t.username = :name")
	User findByName(@Param("name") String name);

	@Query("select t from User t ")
	List<User> getList();
}
