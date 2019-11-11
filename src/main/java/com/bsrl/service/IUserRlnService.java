package com.bsrl.service;

import com.bsrl.common.ServerResponse;
import com.bsrl.po.UserInfo;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public interface IUserRlnService {

    Map<String, Object> findByParUserId(UserInfo userInfo);

    ServerResponse<String> insertUserRln(UserInfo userInfo, String userParId);

    ServerResponse<String> deleteByUserId(String userId);

}
