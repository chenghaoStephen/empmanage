package com.bsrl.controller;

import com.bsrl.common.BaseConverter;
import com.bsrl.common.Const;
import com.bsrl.common.ResponseCode;
import com.bsrl.common.ServerResponse;
import com.bsrl.po.UserInfo;
import com.bsrl.service.IUserRlnService;
import com.bsrl.service.IUserService;
import com.bsrl.vo.UserInfoVO;
import org.apache.commons.lang3.StringUtils;
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
    private IUserService iUserService;

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

    /**
     * 新增用户，且新增用户关系
     * @param userInfo
     * @return
     */
    @RequestMapping(value = "insertUserAndUserRln", method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<UserInfoVO> insertUserAndUserRln(UserInfo userInfo) {
        // 注册新用户
        ServerResponse<String> response = iUserService.register(userInfo);
        if (ResponseCode.SUCCESS.getCode() != response.getStatus()) {
            return ServerResponse.createByErrorMessage(response.getMsg());
        }
        // 为用户绑定关系
        response = iUserRlnService.insertUserRln(userInfo, userInfo.getParUserId());
        if (ResponseCode.SUCCESS.getCode() != response.getStatus()) {
            return ServerResponse.createByErrorMessage(response.getMsg());
        }
        // 返回子节点信息
        UserInfoVO userInfoVO = new BaseConverter<UserInfo, UserInfoVO>().convert(userInfo, UserInfoVO.class);
        userInfoVO.setSexCn(Const.SEX_MAP.get(userInfoVO.getSex()));
        userInfoVO.setCategoryCn(Const.ROLE_MAP.get(userInfoVO.getCategory()));
        userInfoVO.setPassword(StringUtils.EMPTY);
        return ServerResponse.createBySuccess(userInfoVO);
    }

    /**
     * 新增用户关系（返回子用户信息）
     * @param userId
     * @return
     */
    @RequestMapping(value = "insertUserRln", method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<UserInfoVO> insertUserRln(String userId, String parUserId) {
        UserInfo userInfo = iUserService.selectByPrimaryKey(userId);
        if (userInfo == null) {
            return ServerResponse.createByErrorMessage("未查找到用户信息");
        }
        ServerResponse<String> response = iUserRlnService.insertUserRln(userInfo, parUserId);
        if (ResponseCode.SUCCESS.getCode() != response.getStatus()) {
            return ServerResponse.createByErrorMessage(response.getMsg());
        }
        // 返回子节点信息
        UserInfoVO userInfoVO = new BaseConverter<UserInfo, UserInfoVO>().convert(userInfo, UserInfoVO.class);
        userInfoVO.setSexCn(Const.SEX_MAP.get(userInfoVO.getSex()));
        userInfoVO.setCategoryCn(Const.ROLE_MAP.get(userInfoVO.getCategory()));
        userInfoVO.setPassword(StringUtils.EMPTY);
        return ServerResponse.createBySuccess(userInfoVO);
    }

    /**
     * 根据用户id删除用户关系
     * @param userId
     * @return
     */
    @RequestMapping(value = "deleteByUserId", method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> deleteByUserId(String userId) {
        return iUserRlnService.deleteByUserId(userId);
    }

}
