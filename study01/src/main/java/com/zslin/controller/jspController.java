package com.zslin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Foreveross on 2016/12/22.
 */

@Controller
@RequestMapping
public class jspController {
    private static final Logger logger = LoggerFactory.getLogger(jspController.class);

    @RequestMapping("/dd1")
    public String dd1_jsp_test(){
        logger.info("dd1_jsptest");
        return "dd1";
    }

    @RequestMapping("/dd2")
    public String dd2_jsp_test(){
        logger.info("dd2_jsptest");
        return "dd2";
    }

    @RequestMapping("/dd3")
    public String dd3_jsp_test(){
        logger.info("dd3_jsptest");
        return "dd3";
    }

    @RequestMapping("/dd4")
    public String dd4_jsp_test(){
        logger.info("dd4_jsptest");
        return "dd4";
    }

    @RequestMapping("/dd5")
    public String dd5_jsp_test(){
        logger.info("dd5_jsptest");
        return "dd5";
    }

    @RequestMapping("/ddd")
    public String ddd_jsp_test(){
        logger.info("ddd_jsptest");
        return "ddd";
    }

    @RequestMapping("/indexmain")
    public String indexmain_jsp_test(){
        logger.info("indexmain_jsp_test");
        return "indexmain";
    }

    @RequestMapping("/topframe")
    public String topframe_jsp_test(){
        logger.info("topframe_jsp_test");
        return "topframe";
    }

    @RequestMapping("/leftframe")
    public String leftframe_jsp_test(){
        logger.info("leftframe_jsp_test");
        return "leftframe";
    }

    @RequestMapping("/switchframe")
    public String switchframe_jsp_test(){
        logger.info("switchframe_jsp_test");
        return "switchframe";
    }

    @RequestMapping("/mainframe")
    public String mainframe_jsp_test(){
        logger.info("mainframe_jsp_test");
        return "mainframe";
    }

    @RequestMapping("/manframe")
    public String manframe_jsp_test(){
        logger.info("manframe_jsp_test");
        return "manframe";
    }

    @RequestMapping("/changepass")
    public String changepass_jsp_test(){
        logger.info("changepass_jsp_test");
        return "changepass";
    }

    @RequestMapping("/checkliuyuan")
    public String checkliuyuan_jsp_test(){
        logger.info("checkliuyuan_jsp_test");
        return "checkliuyuan";
    }

    @RequestMapping("/dingdancheck")
    public String dingdancheck_jsp_test(){
        logger.info("dingdancheck_jsp_test");
        return "dingdancheck";
    }

    @RequestMapping("/huiyuantest")
    public String huiyuantest_jsp_test(){
        logger.info("huiyuantest_jsp_test");
        return "huiyuantest";
    }

    @RequestMapping("/profile")
    public String profile_jsp_test(){
        logger.info("profile_jsp_test");
        return "profile";
    }

    @RequestMapping("/putongyonghutest")
    public String putongyonghutest_jsp_test(){
        logger.info("putongyonghutest_jsp_test");
        return "putongyonghutest";
    }

    @RequestMapping("/syis")
    public String syis_jsp_test(){
        logger.info("syis_jsp_test");
        return "syis";
    }

    @RequestMapping("/yudingdan")
    public String yudingdan_jsp_test(){
        logger.info("yudingdan_jsp_test");
        return "yudingdan";
    }


}
