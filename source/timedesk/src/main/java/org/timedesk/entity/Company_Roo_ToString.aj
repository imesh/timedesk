// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import java.lang.String;

privileged aspect Company_Roo_ToString {
    
    public String Company.toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Id: ").append(getId()).append(", ");
        sb.append("Version: ").append(getVersion()).append(", ");
        sb.append("CompanyId: ").append(getCompanyId()).append(", ");
        sb.append("Name: ").append(getName()).append(", ");
        sb.append("CompanySites: ").append(getCompanySites() == null ? "null" : getCompanySites().size()).append(", ");
        sb.append("Projects: ").append(getProjects() == null ? "null" : getProjects().size());
        return sb.toString();
    }
    
}
