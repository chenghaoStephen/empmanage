package com.bsrl.controller;

import com.bsrl.common.Const;
import com.bsrl.common.ServerResponse;
import com.bsrl.po.UserInfo;
import com.bsrl.service.IUserRlnService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/userrln/")
public class UserRlnController {

    @Autowired
    private IUserRlnService iUserRlnService;

    @RequestMapping(value = "findByParUserId", method = RequestMethod.GET)
    @ResponseBody
    public ServerResponse<Map<String, Object>> findByParUserId(HttpSession session) {
        UserInfo userInfo = (UserInfo)session.getAttribute(Const.CURRENT_USER);
        if (userInfo == null) {
            return ServerResponse.createByErrorMessage("用户未登录，无法执行操作");
        }
        Map<String, Object> resultMap = iUserRlnService.findByParUserId(userInfo);
        return ServerResponse.createBySuccess(resultMap);
    }

}
