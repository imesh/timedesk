// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import java.lang.String;

privileged aspect EmployeeWeeklyAllocation_Roo_ToString {
    
    public String EmployeeWeeklyAllocation.toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Id: ").append(getId()).append(", ");
        sb.append("Version: ").append(getVersion()).append(", ");
        sb.append("EmployeeName: ").append(getEmployeeName()).append(", ");
        sb.append("Location: ").append(getLocation()).append(", ");
        sb.append("ProjectName: ").append(getProjectName()).append(", ");
        sb.append("Effort: ").append(getEffort()).append(", ");
        sb.append("Week1: ").append(getWeek1()).append(", ");
        sb.append("Week2: ").append(getWeek2()).append(", ");
        sb.append("Week3: ").append(getWeek3()).append(", ");
        sb.append("Week4: ").append(getWeek4()).append(", ");
        sb.append("Week5: ").append(getWeek5()).append(", ");
        sb.append("Week6: ").append(getWeek6()).append(", ");
        sb.append("Week7: ").append(getWeek7()).append(", ");
        sb.append("Week8: ").append(getWeek8());
        return sb.toString();
    }
    
}
