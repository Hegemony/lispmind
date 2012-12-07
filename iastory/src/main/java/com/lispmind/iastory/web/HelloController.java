package com.lispmind.iastory.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 
 * @author zhangxi
 * @created 2012-7-30
 * 
 * @version 1.0
 */
@Controller
@RequestMapping("/")
public class HelloController {
    private static final Logger log = LoggerFactory.getLogger(HelloController.class);

    @RequestMapping(value = "hello", method = RequestMethod.GET)
    public String hello() {
        log.info("hello ok");
        return "hello";
    }

    @RequestMapping(value = "home", method = RequestMethod.GET)
    public String home() {
        log.info("home ok");
        return "home";
    }
}
