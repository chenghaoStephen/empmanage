package com.bsrl.mapper;

import com.bsrl.po.UserRln;

import java.util.List;

public interface UserRlnMapper {

    int deleteByPrimaryKey(String rlnId);

    int deleteByUserId(String userId);

    int insert(UserRln record);

    UserRln selectByPrimaryKey(String rlnId);

    int updateByPrimaryKeySelective(UserRln record);

    int updateByPrimaryKey(UserRln record);

    List<UserRln> findByParUserId(String parUserId);

    UserRln getRlnByUserId(String userId);
}