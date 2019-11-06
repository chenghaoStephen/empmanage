package com.bsrl.service;

import com.bsrl.common.ServerResponse;
import com.bsrl.po.UserInfo;
import com.bsrl.query.UserInfoQuery;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

@Service
public interface IUserService {

    ServerResponse<UserInfo> login(String username, String password);

    ServerResponse<String> register(UserInfo userInfo);

    ServerResponse<String> checkValid(String username);

    ServerResponse<String> updatePasswordByUsername(String username, String passwordNew);

    ServerResponse<String> resetPassword(UserInfo userInfo, String password, String passwordNew);

    ServerResponse<UserInfo> updateUserInformation(UserInfo userInfo);

    PageInfo<UserInfo> findUserList(UserInfoQuery userInfoQuery);

    UserInfo selectByPrimaryKey(String userId);
}
