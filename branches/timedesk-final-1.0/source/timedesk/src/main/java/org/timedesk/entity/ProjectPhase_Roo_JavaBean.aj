// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import java.lang.String;
import java.util.Date;
import java.util.Set;
import org.timedesk.entity.Project;
import org.timedesk.entity.ProjectPhaseMember;

privileged aspect ProjectPhase_Roo_JavaBean {
    
    public Project ProjectPhase.getProject() {
        return this.project;
    }
    
    public void ProjectPhase.setProject(Project project) {
        this.project = project;
    }
    
    public String ProjectPhase.getPhaseId() {
        return this.phaseId;
    }
    
    public void ProjectPhase.setPhaseId(String phaseId) {
        this.phaseId = phaseId;
    }
    
    public String ProjectPhase.getDescription() {
        return this.description;
    }
    
    public void ProjectPhase.setDescription(String description) {
        this.description = description;
    }
    
    public Date ProjectPhase.getStartDate() {
        return this.startDate;
    }
    
    public void ProjectPhase.setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    
    public Date ProjectPhase.getEndDate() {
        return this.endDate;
    }
    
    public void ProjectPhase.setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    
    public Set<ProjectPhaseMember> ProjectPhase.getProjectPhaseMembers() {
        return this.projectPhaseMembers;
    }
    
    public void ProjectPhase.setProjectPhaseMembers(Set<ProjectPhaseMember> projectPhaseMembers) {
        this.projectPhaseMembers = projectPhaseMembers;
    }
    
}
