package com.project1.jsp_blog_project.model;

public class CommentDTO {
    private int commentPk;
    private String commentContent;
    private String commentName;
    private String commentPass;
    private String commentDatetime;
    private String commentEdited;
    private int commentPost;
    private int commentReplyCnt;
    private int commentManager;
    private int commentNum;
    private int commentDeleted;

    public int getCommentDeleted() {
        return commentDeleted;
    }

    public void setCommentDeleted(int commentDeleted) {
        this.commentDeleted = commentDeleted;
    }

    public int getCommentPk() {
        return commentPk;
    }

    public void setCommentPk(int commentPk) {
        this.commentPk = commentPk;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public String getCommentName() {
        return commentName;
    }

    public void setCommentName(String commentName) {
        this.commentName = commentName;
    }

    public String getCommentPass() {
        return commentPass;
    }

    public void setCommentPass(String commentPass) {
        this.commentPass = commentPass;
    }

    public String getCommentDatetime() {
        return commentDatetime;
    }

    public void setCommentDatetime(String commentDatetime) {
        this.commentDatetime = commentDatetime;
    }

    public String getCommentEdited() {
        return commentEdited;
    }

    public void setCommentEdited(String commentEdited) {
        this.commentEdited = commentEdited;
    }

    public int getCommentPost() {
        return commentPost;
    }

    public void setCommentPost(int commentPost) {
        this.commentPost = commentPost;
    }

    public int getCommentReplyCnt() {
        return commentReplyCnt;
    }

    public void setCommentReplyCnt(int commentReplyCnt) {
        this.commentReplyCnt = commentReplyCnt;
    }

    public int getCommentManager() {
        return commentManager;
    }

    public void setCommentManager(int commentManager) {
        this.commentManager = commentManager;
    }

    public int getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(int commentNum) {
        this.commentNum = commentNum;
    }
}
