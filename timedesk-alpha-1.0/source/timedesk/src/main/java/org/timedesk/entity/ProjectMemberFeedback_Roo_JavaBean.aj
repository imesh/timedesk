// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import java.lang.Integer;
import java.lang.String;
import org.timedesk.entity.ProjectMember;

privileged aspect ProjectMemberFeedback_Roo_JavaBean {
    
    public ProjectMember ProjectMemberFeedback.getProjectMember() {
        return this.projectMember;
    }
    
    public void ProjectMemberFeedback.setProjectMember(ProjectMember projectMember) {
        this.projectMember = projectMember;
    }
    
    public Integer ProjectMemberFeedback.getFeedbackId() {
        return this.feedbackId;
    }
    
    public void ProjectMemberFeedback.setFeedbackId(Integer feedbackId) {
        this.feedbackId = feedbackId;
    }
    
    public String ProjectMemberFeedback.getDescription() {
        return this.description;
    }
    
    public void ProjectMemberFeedback.setDescription(String description) {
        this.description = description;
    }
    
}
