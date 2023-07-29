package com.project1.jsp_blog_project.model;

public class ManagerDTO {
    private String managerName;
    private String managerEmail;
    private String managerPass;
    private int managerNumber;
    private String managerDatetime;

    public String getManagerDatetime() {
        return managerDatetime;
    }

    public void setManagerDatetime(String managerDatetime) {
        this.managerDatetime = managerDatetime;
    }

    public int getManagerNumber() {
        return managerNumber;
    }

    public void setManagerNumber(int managerNumber) {
        this.managerNumber = managerNumber;
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getManagerEmail() {
        return managerEmail;
    }

    public void setManagerEmail(String managerEmail) {
        this.managerEmail = managerEmail;
    }

    public String getManagerPass() {
        return managerPass;
    }

    public void setManagerPass(String managerPass) {
        this.managerPass = managerPass;
    }
}
