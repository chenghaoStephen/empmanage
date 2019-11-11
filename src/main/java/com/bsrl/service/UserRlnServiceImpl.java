package com.bsrl.service;

import com.bsrl.common.Const;
import com.bsrl.common.ServerResponse;
import com.bsrl.mapper.UserInfoMapper;
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
    private UserInfoMapper userInfoMapper;
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
        // 封装结果树和用户id集合
        Map<String, Object> rtnResult = new HashMap<>();
        rtnResult.put("datasource", resultMap);
        rtnResult.put("userIdSet", userIdSet);
        return rtnResult;
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

    /**
     * 根据用户Id查找代理Id
     * @param userId
     * @return
     */
    public String getAgentIdByUserId(String userId) {
        // 先判断用户身份，如果是代理则直接返回id，如果是客户则取其代理id，其他返回null
        UserInfo userInfo = userInfoMapper.selectByPrimaryKey(userId);
        if (userInfo == null || StringUtils.isBlank(userInfo.getCategory())) {
            return null;
        }
        switch (userInfo.getCategory()) {
            case Const.Role.ROLE_CUSTOMER: {
                UserRln userRln = userRlnMapper.getRlnByUserId(userId);
                return userRln.getAgentId();
            }
            case Const.Role.ROLE_AGENT: {
                return userId;
            }
            default: {
                return null;
            }
        }
    }

    /**
     * 为用户绑定关系
     * @param userInfo 用户信息
     * @param userParId 上级用户id
     * @return
     */
    public ServerResponse<String> insertUserRln(UserInfo userInfo, String userParId) {
        // 先查找数据库中有无该用户的关系，如果有，则更新
        String userId = userInfo.getUserId();
        UserRln userRln = userRlnMapper.getRlnByUserId(userId);
        if (userRln != null) {
            // 更新用户关系
            userRln.setParUserId(userParId);
            userRln.setAgentId(getAgentIdByUserId(userParId));
            int updCount = userRlnMapper.updateByPrimaryKey(userRln);
            if (updCount <= 0) {
                return ServerResponse.createByErrorMessage("更新用户关系失败");
            }
        } else {
            // 新增用户关系
            UserRln userRlnNew = new UserRln();
            userRlnNew.setRlnId(UUID.randomUUID().toString().replace("-", ""));
            userRlnNew.setUserId(userInfo.getUserId());
            userRlnNew.setParUserId(userParId);
            userRlnNew.setAgentId(getAgentIdByUserId(userParId));
            userRlnNew.setRealName(userInfo.getRealName());
            userRlnNew.setStatus(Const.Status.STATUS_NORMAL);
            int insertCount = userRlnMapper.insert(userRlnNew);
            if (insertCount <= 0) {
                return ServerResponse.createByErrorMessage("新增用户关系失败");
            }
        }
        // 更新成功，返回用户信息
        return ServerResponse.createBySuccess("操作成功");
    }

    /**
     * 根据用户id删除用户关系
     * @param userId
     * @return
     */
    public ServerResponse<String> deleteByUserId(String userId) {
        int deleteCount = userRlnMapper.deleteByUserId(userId);
        if (deleteCount <= 0) {
            return ServerResponse.createByErrorMessage("删除用户关系失败");
        }
        return ServerResponse.createBySuccessMessage("操作成功");
    }

}
