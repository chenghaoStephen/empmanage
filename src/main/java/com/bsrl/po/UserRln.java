package com.bsrl.po;

public class UserRln {
    private String rlnId;

    private String userId;

    private String parUserId;

    private String realName;

    private String agentId;

    private String status;

    private String category;

    public String getRlnId() {
        return rlnId;
    }

    public void setRlnId(String rlnId) {
        this.rlnId = rlnId == null ? null : rlnId.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getParUserId() {
        return parUserId;
    }

    public void setParUserId(String parUserId) {
        this.parUserId = parUserId == null ? null : parUserId.trim();
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName == null ? null : realName.trim();
    }

    public String getAgentId() {
        return agentId;
    }

    public void setAgentId(String agentId) {
        this.agentId = agentId == null ? null : agentId.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}