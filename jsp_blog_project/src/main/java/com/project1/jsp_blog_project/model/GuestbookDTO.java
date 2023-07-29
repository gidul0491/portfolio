package com.project1.jsp_blog_project.model;

public class GuestbookDTO {
    private int guestbookPk;
    private String guestbookContent;
    private String guestbookName;
    private String guestbookPass;
    private String guestbookDatetime;
    private int guestbookDeleted;
    private int guestbookNum;
    private int guestbookReplyCnt;
    private String guestbookEdited;
    private int guestbookManager;

    public int getGuestbookManager() {
        return guestbookManager;
    }

    public void setGuestbookManager(int guestbookManager) {
        this.guestbookManager = guestbookManager;
    }

    public String getGuestbookEdited() {
        return guestbookEdited;
    }

    public void setGuestbookEdited(String guestbookEdited) {
        this.guestbookEdited = guestbookEdited;
    }

    public int getGuestbookPk() {
        return guestbookPk;
    }

    public void setGuestbookPk(int guestbookPk) {
        this.guestbookPk = guestbookPk;
    }

    public String getGuestbookContent() {
        return guestbookContent;
    }

    public void setGuestbookContent(String guestbookContent) {
        this.guestbookContent = guestbookContent;
    }

    public String getGuestbookName() {
        return guestbookName;
    }

    public void setGuestbookName(String guestbookName) {
        this.guestbookName = guestbookName;
    }

    public String getGuestbookPass() {
        return guestbookPass;
    }

    public void setGuestbookPass(String guestbookPass) {
        this.guestbookPass = guestbookPass;
    }

    public String getGuestbookDatetime() {
        return guestbookDatetime;
    }

    public void setGuestbookDatetime(String guestbookDatetime) {
        this.guestbookDatetime = guestbookDatetime;
    }

    public int getGuestbookDeleted() {
        return guestbookDeleted;
    }

    public void setGuestbookDeleted(int guestbookDeleted) {
        this.guestbookDeleted = guestbookDeleted;
    }

    public int getGuestbookNum() {
        return guestbookNum;
    }

    public void setGuestbookNum(int guestbookNum) {
        this.guestbookNum = guestbookNum;
    }

    public int getGuestbookReplyCnt() {
        return guestbookReplyCnt;
    }

    public void setGuestbookReplyCnt(int guestbookReplyCnt) {
        this.guestbookReplyCnt = guestbookReplyCnt;
    }
}
