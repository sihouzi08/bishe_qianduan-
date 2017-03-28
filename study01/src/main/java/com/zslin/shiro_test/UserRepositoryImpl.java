package com.zslin.shiro_test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by Foreveross on 2017/3/2.
 */
@RestController
@RequestMapping(value = "/user")
@SpringBootApplication
public class UserRepositoryImpl {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public String createUser(@RequestBody User jsonObj) {
        User user = new User();
//        System.out.println("ooo" + currTime);
//        shop.setShopid(jsonObj.getShopid());

        List<User> userlist = userRepository.findByUsername(jsonObj.getUsername());
        if(userlist.size()==0) {
            user.setUsername(jsonObj.getUsername());
            user.setPassword(jsonObj.getPassword());
            System.out.print(jsonObj.getUsername() + "    " + jsonObj.getPassword() + "  <-->   ");

            User p = userRepository.save(user);

        }else{
            return "error";
        }
        return "success";
    }


}
