// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import java.lang.String;

privileged aspect Role_Roo_ToString {
    
    public String Role.toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Id: ").append(getId()).append(", ");
        sb.append("Version: ").append(getVersion()).append(", ");
        sb.append("RoleId: ").append(getRoleId()).append(", ");
        sb.append("Name: ").append(getName()).append(", ");
        sb.append("RoleType: ").append(getRoleType());
        return sb.toString();
    }
    
}