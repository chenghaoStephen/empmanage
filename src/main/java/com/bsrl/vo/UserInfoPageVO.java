package com.bsrl.vo;

import java.util.List;

public class UserInfoPageVO {

    private int status;

    private long total;

    private List<UserInfoVO> pageData;

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public List<UserInfoVO> getPageData() {
        return pageData;
    }

    public void setPageData(List<UserInfoVO> pageData) {
        this.pageData = pageData;
    }
}
