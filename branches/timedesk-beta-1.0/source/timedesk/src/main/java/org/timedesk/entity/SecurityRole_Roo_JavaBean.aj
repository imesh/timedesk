// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import java.lang.String;
import java.util.Set;
import org.timedesk.entity.ApplicationFeature;

privileged aspect SecurityRole_Roo_JavaBean {
    
    public String SecurityRole.getSecurityRoleId() {
        return this.securityRoleId;
    }
    
    public void SecurityRole.setSecurityRoleId(String securityRoleId) {
        this.securityRoleId = securityRoleId;
    }
    
    public String SecurityRole.getName() {
        return this.name;
    }
    
    public void SecurityRole.setName(String name) {
        this.name = name;
    }
    
    public Set<ApplicationFeature> SecurityRole.getApplicationFeatures() {
        return this.applicationFeatures;
    }
    
    public void SecurityRole.setApplicationFeatures(Set<ApplicationFeature> applicationFeatures) {
        this.applicationFeatures = applicationFeatures;
    }
    
}
