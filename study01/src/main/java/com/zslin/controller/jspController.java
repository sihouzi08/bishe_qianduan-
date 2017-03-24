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

    @RequestMapping("/shopmain")
    public String shopmain_jsp_test(){
        logger.info("shopmain_jsptest");
        return "shopmain";
    }

    @RequestMapping("/usermain")
    public String usermain_jsp_test(){
        logger.info("usermain_jsptest");
        return "usermain";
    }

    @RequestMapping("/ordermain")
    public String ordermain_jsp_test(){
        logger.info("ordermain_jsptest");
        return "ordermain";
    }

    @RequestMapping("/dd5")
    public String dd5_jsp_test(){
        logger.info("dd5_jsptest");
        return "dd5";
    }

    @RequestMapping("/messagesmain")
    public String messagesmain_jsp_test(){
        logger.info("messagesmain_jsptest");
        return "messagesmain";
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

    @RequestMapping("/thisuser")
    public String thisuser_jsp_test(){
        logger.info("thisuser_jsp_test");
        return "thisuser";
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

    @RequestMapping("/testtubiao")
    public String testtubiao_jsp_test(){
        logger.info("testtubiao_jsp_test");
        return "testtubiao";
    }

    @RequestMapping("/testdata")
    public String testdata_jsp_test(){
        logger.info("testdata_jsp_test");
        return "testdata";
    }

    @RequestMapping("/testshop")
    public String testshop_jsp_test(){
        logger.info("testshop_jsp_test");
        return "testshop";
    }

    @RequestMapping("/testuser")
    public String testuser_jsp_test(){
        logger.info("testuser_jsp_test");
        return "testuser";
    }
    @RequestMapping("/testorder")
    public String testorder_jsp_test(){
        logger.info("testorder_jsp_test");
        return "testorder";
    }
    @RequestMapping("/testmessages")
    public String testmessages_jsp_test(){
        logger.info("testmessages_jsp_test");
        return "testmessages";
    }

    @RequestMapping("/index")
    public String index_jsp_test(){
        logger.info("index_jsp_test");
        return "index";
    }

    @RequestMapping("/help")
    public String help_jsp_test(){
        logger.info("help_jsp_test");
        return "help";
    }

    @RequestMapping("/time")
    public String time_jsp_test(){
        logger.info("time_jsp_test");
        return "time";
    }

}
