// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import java.lang.String;

privileged aspect EmployeeAllocation_Roo_ToString {
    
    public String EmployeeAllocation.toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Id: ").append(getId()).append(", ");
        sb.append("Version: ").append(getVersion()).append(", ");
        sb.append("EmpId: ").append(getEmpId()).append(", ");
        sb.append("EmployeeId: ").append(getEmployeeId()).append(", ");
        sb.append("FirstName: ").append(getFirstName()).append(", ");
        sb.append("LastName: ").append(getLastName()).append(", ");
        sb.append("PhmId: ").append(getPhmId()).append(", ");
        sb.append("StartDate: ").append(getStartDate()).append(", ");
        sb.append("EndDate: ").append(getEndDate()).append(", ");
        sb.append("Allocation: ").append(getAllocation());
        return sb.toString();
    }
    
}
