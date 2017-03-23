package com.zslin.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

/**
 * Created by zslin.com on 2016/10/13.
 */
@RestController
public class IndexController {

    @RequestMapping(value = "index")
    public String index() {

        return "Hello World!!!";
    }

        @RequestMapping("/now")
    String hehe() {
        return "现在时间：" + (new Date()).toLocaleString();
    }
}
