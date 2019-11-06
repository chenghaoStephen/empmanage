package com.bsrl.service;

import com.bsrl.common.Const;
import com.bsrl.mapper.UserRlnMapper;
import com.bsrl.po.UserInfo;
import com.bsrl.po.UserRln;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("iUserRlnService")
public class UserRlnServiceImpl implements IUserRlnService {

    @Autowired
    private UserRlnMapper userRlnMapper;

    @Override
    public Map<String, Object> findByParUserId(UserInfo userInfo) {
        // 根据当前登录用户，获取隶属于其下的所有用户
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("id", userInfo.getUserId());
        resultMap.put("name", Const.ROLE_MAP.get(userInfo.getCategory()));
        resultMap.put("title", userInfo.getRealName());
        resultMap.put("className", Const.CLASS_MAP.get(userInfo.getCategory()));
        Set<String> userIdSet = new HashSet<>();
        userIdSet.add(userInfo.getUserId());
        saveAndFindDownUser(resultMap, userIdSet);
        return resultMap;
    }

    /**
     * 保存当前用户信息，并且查找子用户信息
     * @param resultMap
     * @param userIdSet 已查到的用户，不再查询，避免死循环
     */
    private void saveAndFindDownUser(Map<String, Object> resultMap, Set<String> userIdSet) {
        // 获取用户id，并根据id继续查找
        String userId = (String)resultMap.get("id");
        if (StringUtils.isBlank(userId)) {
            return;
        }
        List<UserRln> userRlnList = userRlnMapper.findByParUserId(userId);
        if (userRlnList != null && userRlnList.size() > 0) {
            List<Map<String, Object>> childrenList = new ArrayList<>();
            for (UserRln userRln:userRlnList) {
                if (StringUtils.isBlank(userRln.getUserId()) || userIdSet.contains(userRln.getUserId())) {
                    // 数据错误，或者已添加，不执行后续操作
                    continue;
                }
                // 保存用户信息
                Map<String, Object> childMap = new HashMap<>();
                childMap.put("id", userRln.getUserId());
                childMap.put("name", Const.ROLE_MAP.get(userRln.getCategory()));
                childMap.put("title", userRln.getRealName());
                childMap.put("className", Const.CLASS_MAP.get(userRln.getCategory()));
                userIdSet.add(userRln.getUserId());
                // 继续查找子用户
                saveAndFindDownUser(childMap, userIdSet);
                childrenList.add(childMap);
            }
            resultMap.put("children", childrenList);
        }

    }
}
