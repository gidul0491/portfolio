package com.project1.jsp_blog_project.model;

public class CategoryDTO {
    String categoryName;
    int categoryPostCnt;
    int categoryNum;

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getCategoryPostCnt() {
        return categoryPostCnt;
    }

    public void setCategoryPostCnt(int categoryPostCnt) {
        this.categoryPostCnt = categoryPostCnt;
    }

    public int getCategoryNum() {
        return categoryNum;
    }

    public void setCategoryNum(int categoryNum) {
        this.categoryNum = categoryNum;
    }
}
