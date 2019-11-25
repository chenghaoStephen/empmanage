package com.bsrl.controller;

import com.bsrl.common.BaseConverter;
import com.bsrl.common.Const;
import com.bsrl.common.ResponseCode;
import com.bsrl.common.ServerResponse;
import com.bsrl.po.UserInfo;
import com.bsrl.query.UserInfoQuery;
import com.bsrl.service.IUserService;
import com.bsrl.vo.UserInfoPageVO;
import com.bsrl.vo.UserInfoVO;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/user/")
public class UserController {

    @Autowired
    private IUserService iUserService;

    /**
     * 登录
     * @param username
     * @param password
     * @param session
     * @return
     */
    @RequestMapping(value = "login", method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<UserInfo> login(String username, String password, HttpSession session) {
        ServerResponse<UserInfo> response =  iUserService.login(username, password);
        if (response.isSuccess()) {
            session.setAttribute(Const.CURRENT_USER, response.getData());
        }
        return response;
    }

    /**
     * 退出
     * @param session
     * @return
     */
    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public ModelAndView logout(HttpSession session) {
        session.removeAttribute(Const.CURRENT_USER);
        return new ModelAndView("redirect:/to_login");
    }

    /**
     * 注册
     * @param userInfo
     * @return
     */
    @RequestMapping(value = "register", method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> register(UserInfo userInfo) {
        return iUserService.register(userInfo);
    }

    /**
     * 校验用户是否已存在
     * @param username
     * @return
     */
    @RequestMapping(value = "checkValid", method = RequestMethod.GET)
    @ResponseBody
    public ServerResponse<String> checkValid(String username) {
        return iUserService.checkValid(username);
    }

    /**
     * 获取用户信息
     * @param session
     * @return
     */
    @RequestMapping(value = "getUserInfo", method = RequestMethod.GET)
    @ResponseBody
    public ServerResponse<UserInfoVO> getUserInfo(HttpSession session) {
        UserInfo userInfo = (UserInfo)session.getAttribute(Const.CURRENT_USER);
        if (userInfo == null) {
            return ServerResponse.createByErrorMessage("用户未登录，无法获取当前用户信息");
        }
        // 转为界面数据
        UserInfoVO userInfoVO = new BaseConverter<UserInfo, UserInfoVO>().convert(userInfo, UserInfoVO.class);
        userInfoVO.setSexCn(Const.SEX_MAP.get(userInfoVO.getSex()));
        userInfoVO.setCategoryCn(Const.ROLE_MAP.get(userInfoVO.getCategory()));
        userInfoVO.setPassword(StringUtils.EMPTY);
        return ServerResponse.createBySuccess(userInfoVO);
    }

    /**
     * 用户修改密码
     * @param session
     * @param password
     * @param passwordNew
     * @return
     */
    @RequestMapping(value = "resetPassword", method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> resetPassword(HttpSession session, String password, String passwordNew) {
        UserInfo userInfo = (UserInfo)session.getAttribute(Const.CURRENT_USER);
        if (userInfo == null) {
            return ServerResponse.createByErrorMessage("用户未登录");
        }
        return iUserService.resetPassword(userInfo, password, passwordNew);
    }

    /**
     * 更新个人信息
     * @param session
     * @param userInfo
     * @return
     */
    @RequestMapping(value = "updateInformation", method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<UserInfo> updateInformation(HttpSession session, UserInfo userInfo) {
        ServerResponse<UserInfo> response = iUserService.updateUserInformation(userInfo);
        return response;
    }

    @RequestMapping(value = "findUserList", method = RequestMethod.POST)
    @ResponseBody
    public UserInfoPageVO findUserList(UserInfoQuery userInfoQuery, HttpSession session) {
        UserInfo userInfo = (UserInfo)session.getAttribute(Const.CURRENT_USER);
        PageInfo<UserInfo> pageInfo = iUserService.findUserList(userInfoQuery, userInfo);
        List<UserInfo> userInfoList = pageInfo.getList();
        List<UserInfoVO> resultList = new ArrayList<>();
        if (userInfoList != null && userInfoList.size() > 0) {
            userInfoList.forEach(item -> {
                UserInfoVO userInfoVO = new BaseConverter<UserInfo, UserInfoVO>().convert(item, UserInfoVO.class);
                userInfoVO.setSexCn(Const.SEX_MAP.get(userInfoVO.getSex()));
                userInfoVO.setCategoryCn(Const.ROLE_MAP.get(userInfoVO.getCategory()));
                userInfoVO.setPassword(StringUtils.EMPTY);
                resultList.add(userInfoVO);
            });
        }
        // 封装返回对象
        UserInfoPageVO pageVO = new UserInfoPageVO();
        pageVO.setStatus(ResponseCode.SUCCESS.getCode());
        pageVO.setTotal(pageInfo.getTotal());
        pageVO.setPageData(resultList);
        return pageVO;
    }

    /**
     * 根据用户ID获取用户信息
     * @param userId
     * @return
     */
    @RequestMapping(value = "getUserInfoById", method = RequestMethod.GET)
    @ResponseBody
    public ServerResponse<UserInfoVO> getUserInfoById(String userId) {
        UserInfo userInfo = iUserService.selectByPrimaryKey(userId);
        if (userInfo == null) {
            return ServerResponse.createByErrorMessage("未查找到用户信息");
        }
        UserInfoVO userInfoVO = new BaseConverter<UserInfo, UserInfoVO>().convert(userInfo, UserInfoVO.class);
        userInfoVO.setSexCn(Const.SEX_MAP.get(userInfoVO.getSex()));
        userInfoVO.setCategoryCn(Const.ROLE_MAP.get(userInfoVO.getCategory()));
        userInfoVO.setPassword(StringUtils.EMPTY);
        return ServerResponse.createBySuccess(userInfoVO);
    }

    /**
     * 重置用户密码
     * @param userInfoQuery
     * @return
     */
    @RequestMapping(value = "resetPwd", method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> resetPwd(UserInfo userInfoQuery, HttpSession session) {
        // 当前登录用户必须为管理员，才能执行操作
        UserInfo userInfoLogin = (UserInfo)session.getAttribute(Const.CURRENT_USER);
        if (!Const.Role.ROLE_ADMIN.equals(userInfoLogin.getCategory())) {
            return ServerResponse.createByErrorMessage("对不起，您没有该权限");
        }
        // 获取用户信息
        UserInfo userInfo = iUserService.selectByPrimaryKey(userInfoQuery.getUserId());
        if (userInfo == null) {
            return ServerResponse.createByErrorMessage("未查找到用户信息");
        }
        return iUserService.resetOriginalPwd(userInfo);
    }

}
