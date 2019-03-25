package com.dadiyang.springws;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 进入主页的controller
 *
 * @author huangxuyang
 * @date 2018/11/4
 */
@Controller
public class HomeController {

    @RequestMapping({"/", "sockjs"})
    public String home() {
        return "sockjs";
    }
    @RequestMapping("websocket")
    public String websocket() {
        return "websocket";
    }

}
