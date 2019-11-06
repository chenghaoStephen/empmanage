package com.bsrl.mapper;

import com.bsrl.po.UserInfo;
import com.bsrl.query.UserInfoQuery;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserInfoMapper {

    int deleteByPrimaryKey(String userId);

    int insert(UserInfo record);

    UserInfo selectByPrimaryKey(String userId);

    int updateByPrimaryKeySelective(UserInfo record);

    int updateByPrimaryKey(UserInfo record);

    int checkUsername(String username);

    UserInfo selectLogin(@Param("username") String username, @Param("password") String password);

    int updatePasswordByUsername(@Param("username") String username, @Param("passwordNew") String passwordNew);

    int checkPassword(@Param("userId") String userId, @Param("password") String password);

    List<UserInfo> findUserList(UserInfoQuery userInfoQuery);

    int updateByUserName(UserInfo record);
}