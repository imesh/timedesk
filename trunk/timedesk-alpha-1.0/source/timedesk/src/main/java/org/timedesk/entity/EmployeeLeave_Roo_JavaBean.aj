// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import java.util.Date;
import org.timedesk.entity.Employee;

privileged aspect EmployeeLeave_Roo_JavaBean {
    
    public Employee EmployeeLeave.getEmployee() {
        return this.employee;
    }
    
    public void EmployeeLeave.setEmployee(Employee employee) {
        this.employee = employee;
    }
    
    public Date EmployeeLeave.getFromTime() {
        return this.fromTime;
    }
    
    public void EmployeeLeave.setFromTime(Date fromTime) {
        this.fromTime = fromTime;
    }
    
    public Date EmployeeLeave.getToTime() {
        return this.toTime;
    }
    
    public void EmployeeLeave.setToTime(Date toTime) {
        this.toTime = toTime;
    }
    
}
