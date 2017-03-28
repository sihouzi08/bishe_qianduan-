package com.zslin.email;

import com.zslin.shiro_test.User;
import com.zslin.shiro_test.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.ws.rs.QueryParam;
import java.util.List;
import java.util.Random;

/**
 * Created by Foreveross on 2017/3/2.
 */
@ActiveProfiles("163")
@RestController
public class sentEmail {


    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private UserRepository userRepository;


    @Value("${spring.mail.username}")
    private String username;

    @RequestMapping(value ="/testemail", method = RequestMethod.GET)
    public String testSendSimple(@QueryParam("email") String email) {
        String _buffer = new String();
        _buffer = createCode();
        List<User> userlist = userRepository.findByUsername(email);
        if(userlist.size()==0) {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(username);
            message.setTo(email);
            message.setSubject("标题：测试标题");
            message.setText(_buffer);
            javaMailSender.send(message);
        }else {
            return "error";
        }
        return _buffer;
    }
    int CODE_LENGTH=6;
    /**
     * 所有产生验证码的字符
     */
    private static final char[] CHARS = {
            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
            'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
            'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    };

    /**
     * 随机得到验证码要显示的字符,个数为我们自己设置
     * @return 得到一个字符串
     */

//    @RequestMapping("/testemail1")
    private String createCode() {
        Random random = new Random();
        StringBuilder buffer = new StringBuilder();
        //根据传入验证码的长度来随机生成数组里面的字符
        for (int i = 0; i < CODE_LENGTH; i++) {
            buffer.append(CHARS[random.nextInt(CHARS.length)]);
        }
        System.out.print(buffer.toString());
        return buffer.toString();
    }


}
//
//
//
//public class My163MailTest {
//
//
//
//
//    @Test
//    public void testSendHtml() {
//        MimeMessage message = null;
//        try {
//            message = javaMailSender.createMimeMessage();
//            MimeMessageHelper helper = new MimeMessageHelper(message, true);
//            helper.setFrom(username);
//            helper.setTo("87406054@qq.com");
//            helper.setSubject("标题：发送Html内容");
//
//            StringBuffer sb = new StringBuffer();
//            sb.append("<h1>大标题-h1</h1>")
//                    .append("<p style='color:#F00'>红色字</p>")
//                    .append("<p style='text-align:right'>右对齐</p>");
//            helper.setText(sb.toString());
//        } catch (MessagingException e) {
//            e.printStackTrace();
//        }
//
//        javaMailSender.send(message);
//    }
//}
