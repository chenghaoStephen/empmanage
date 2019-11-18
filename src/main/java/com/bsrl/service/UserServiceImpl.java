package com.bsrl.service;

import com.bsrl.common.Const;
import com.bsrl.common.ServerResponse;
import com.bsrl.mapper.UserInfoMapper;
import com.bsrl.po.UserInfo;
import com.bsrl.query.UserInfoQuery;
import com.bsrl.util.MD5Util;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service("iUserService")
public class UserServiceImpl implements IUserService {

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Override
    public ServerResponse<UserInfo> login(String username, String password) {
        int resultCount = userInfoMapper.checkUsername(username);
        if (resultCount <= 0) {
            return ServerResponse.createByErrorMessage("用户名不存在");
        }
        // 密码登录MD5
        String md5Password = MD5Util.MD5EncodeUtf8(password);
        UserInfo userInfo = userInfoMapper.selectLogin(username, md5Password);
        if (userInfo == null) {
            return ServerResponse.createByErrorMessage("密码错误");
        }
        // 清空密码
        userInfo.setPassword(StringUtils.EMPTY);
        return ServerResponse.createBySuccess("登录成功", userInfo);
    }

    @Override
    public ServerResponse<String> register(UserInfo userInfo) {
        ServerResponse<String> ServerResponse = checkValid(userInfo.getUserName());
        if (!ServerResponse.isSuccess()) {
            return ServerResponse.createByErrorMessage("用户名已存在");
        }
        // MD5加密
        // 初始密码默认和用户名相同
        userInfo.setPassword(MD5Util.MD5EncodeUtf8(userInfo.getUserName()));
        // 生成用户id
        if (StringUtils.isBlank(userInfo.getUserId())) {
            userInfo.setUserId(UUID.randomUUID().toString().replace("-", ""));
        }
        int resultCount = userInfoMapper.insert(userInfo);
        if (resultCount <= 0) {
            return ServerResponse.createByErrorMessage("注册失败");
        }
        return ServerResponse.createBySuccessMessage("注册成功");
    }

    @Override
    public ServerResponse<String> checkValid(String username) {
        int resultCount = userInfoMapper.checkUsername(username);
        if (resultCount > 0) {
            return ServerResponse.createByErrorMessage("用户名已存在");
        }
        return ServerResponse.createBySuccessMessage("校验成功");
    }

    @Override
    public ServerResponse<String> updatePasswordByUsername(String username, String passwordNew) {
        int rowCount = userInfoMapper.updatePasswordByUsername(username, passwordNew);
        if (rowCount <= 0) {
            return ServerResponse.createByErrorMessage("用户名不存在");
        }
        return ServerResponse.createBySuccessMessage("修改密码成功");
    }

    @Override
    public ServerResponse<String> resetPassword(UserInfo userInfo, String password, String passwordNew) {
        // 防止横向越权，校验用户的id和原password
        int resultCount = userInfoMapper.checkPassword(userInfo.getUserId(), MD5Util.MD5EncodeUtf8(password));
        if (resultCount <= 0) {
            return ServerResponse.createByErrorMessage("原密码错误");
        }
        userInfo.setPassword(MD5Util.MD5EncodeUtf8(passwordNew));
        int updateCount = userInfoMapper.updateByPrimaryKeySelective(userInfo);
        if (updateCount <= 0) {
            return ServerResponse.createByErrorMessage("修改密码失败");
        }
        return ServerResponse.createBySuccessMessage("修改密码成功");
    }

    @Override
    public ServerResponse<UserInfo> updateUserInformation(UserInfo userInfo) {
        // 根据username更新用户信息
        int updateCount = userInfoMapper.updateByUserName(userInfo);
        if (updateCount <= 0) {
            return ServerResponse.createByErrorMessage("更新个人信息失败");
        }
        return ServerResponse.createBySuccess("更新成功", userInfo);

    }

    @Override
    public PageInfo<UserInfo> findUserList(UserInfoQuery userInfoQuery, UserInfo userInfo) {
        int pageNum = userInfoQuery.getStart()/userInfoQuery.getLength() + 1;
        PageHelper.startPage(pageNum, userInfoQuery.getLength());
        userInfoQuery.setCategory(userInfo.getCategory());
        List<UserInfo> userInfoList = new ArrayList<>();
        // 只有管理员和员工可以查看用户列表
        if (Const.Role.ROLE_ADMIN.equals(userInfo.getCategory())
            || Const.Role.ROLE_EMPLOYEE.equals(userInfo.getCategory())) {
            userInfoList = userInfoMapper.findUserList(userInfoQuery);
        }
        PageInfo<UserInfo> pageInfo = new PageInfo<UserInfo>(userInfoList);
        return pageInfo;
    }

    @Override
    public UserInfo selectByPrimaryKey(String userId) {
        return userInfoMapper.selectByPrimaryKey(userId);
    }

}
