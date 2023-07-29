package com.project1.jsp_blog_project.model;

public class PostDTO {
    private int postPk;
    private String postCategory;
    private String postTitle;
    private String postContent;
    private String postWriter;
    private String postDatetime;
    private String postOpen;
    private String postOfile;
    private String postSfile;
    private String postPass;
    private String postEdited;
    private int postVisit;
    private int postCommentCnt;
    private int postLike;


    public int getPostLike() {
        return postLike;
    }

    public void setPostLike(int postLike) {
        this.postLike = postLike;
    }

    public int getPostPk() {
        return postPk;
    }

    public void setPostPk(int postPk) {
        this.postPk = postPk;
    }

    public String getPostCategory() {
        return postCategory;
    }

    public void setPostCategory(String postCategory) {
        this.postCategory = postCategory;
    }

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    public String getPostContent() {
        return postContent;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }

    public String getPostWriter() {
        return postWriter;
    }

    public void setPostWriter(String postWriter) {
        this.postWriter = postWriter;
    }

    public String getPostDatetime() {
        return postDatetime;
    }

    public void setPostDatetime(String postDatetime) {
        this.postDatetime = postDatetime;
    }

    public String getPostOpen() {
        return postOpen;
    }

    public void setPostOpen(String postOpen) {
        this.postOpen = postOpen;
    }

    public String getPostOfile() {
        return postOfile;
    }

    public void setPostOfile(String postOfile) {
        this.postOfile = postOfile;
    }

    public String getPostSfile() {
        return postSfile;
    }

    public void setPostSfile(String postSfile) {
        this.postSfile = postSfile;
    }

    public String getPostPass() {
        return postPass;
    }

    public void setPostPass(String postPass) {
        this.postPass = postPass;
    }

    public String getPostEdited() {
        return postEdited;
    }

    public void setPostEdited(String postEdited) {
        this.postEdited = postEdited;
    }

    public int getPostVisit() {
        return postVisit;
    }

    public void setPostVisit(int postVisit) {
        this.postVisit = postVisit;
    }

    public int getPostCommentCnt() {
        return postCommentCnt;
    }

    public void setPostCommentCnt(int postCommentCnt) {
        this.postCommentCnt = postCommentCnt;
    }
}
