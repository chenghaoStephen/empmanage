package com.bsrl.common;

import java.util.HashMap;
import java.util.Map;

public class Const {

    // 保存当前登录用户Session的Key
    public static final String CURRENT_USER = "currentUser";

    public static final Map<String, String> SEX_MAP;
    public static final Map<String, String> ROLE_MAP;
    public static final Map<String, String> STATUS_MAP;
    public static final Map<String, String> CLASS_MAP;

    public interface Sex {
        String SEX_MALE = "1";//男
        String SEX_FEMALE = "2";//女
    }

    public interface Role {
        String ROLE_ADMIN = "1";//管理员
        String ROLE_EMPLOYEE = "2"; //员工
        String ROLE_AGENT = "3"; //代理
        String ROLE_CUSTOMER = "4"; //用户
    }

    public interface Status {
        String STATUS_NORMAL = "1";//正常
        String STATUS_RUNNING = "2";//进行中
    }

    static {
        SEX_MAP = new HashMap<>();
        SEX_MAP.put("1", "男");
        SEX_MAP.put("2", "女");

        ROLE_MAP = new HashMap<>();
        ROLE_MAP.put("1", "管理员");
        ROLE_MAP.put("2", "员工");
        ROLE_MAP.put("3", "代理");
        ROLE_MAP.put("4", "客户");

        CLASS_MAP = new HashMap<>();
        CLASS_MAP.put("1", "middle-level");
        CLASS_MAP.put("2", "product-dept");
        CLASS_MAP.put("3", "pipeline1");
        CLASS_MAP.put("4", "frontend1");

        STATUS_MAP = new HashMap<>();
        STATUS_MAP.put("1", "正常");
        STATUS_MAP.put("2", "进行中");
    }

}
