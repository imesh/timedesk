// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import java.lang.String;
import java.util.Date;
import java.util.Set;
import org.timedesk.entity.Company;
import org.timedesk.entity.ProjectMember;
import org.timedesk.entity.ProjectPhase;

privileged aspect Project_Roo_JavaBean {
    
    public Company Project.getCompany() {
        return this.company;
    }
    
    public void Project.setCompany(Company company) {
        this.company = company;
    }
    
    public String Project.getProjectId() {
        return this.projectId;
    }
    
    public void Project.setProjectId(String projectId) {
        this.projectId = projectId;
    }
    
    public String Project.getName() {
        return this.name;
    }
    
    public void Project.setName(String name) {
        this.name = name;
    }
    
    public String Project.getDescription() {
        return this.description;
    }
    
    public void Project.setDescription(String description) {
        this.description = description;
    }
    
    public Date Project.getStartDate() {
        return this.startDate;
    }
    
    public void Project.setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    
    public Date Project.getEndDate() {
        return this.endDate;
    }
    
    public void Project.setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    
    public Set<ProjectMember> Project.getProjectMembers() {
        return this.projectMembers;
    }
    
    public void Project.setProjectMembers(Set<ProjectMember> projectMembers) {
        this.projectMembers = projectMembers;
    }
    
    public Set<ProjectPhase> Project.getProjectPhases() {
        return this.projectPhases;
    }
    
    public void Project.setProjectPhases(Set<ProjectPhase> projectPhases) {
        this.projectPhases = projectPhases;
    }
    
}
