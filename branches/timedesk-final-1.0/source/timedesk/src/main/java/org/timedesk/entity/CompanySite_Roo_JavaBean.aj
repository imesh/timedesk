// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import java.lang.String;
import java.util.Set;
import org.timedesk.entity.Company;
import org.timedesk.entity.Employee;
import org.timedesk.entity.Holiday;

privileged aspect CompanySite_Roo_JavaBean {
    
    public Company CompanySite.getCompany() {
        return this.company;
    }
    
    public void CompanySite.setCompany(Company company) {
        this.company = company;
    }
    
    public String CompanySite.getSiteId() {
        return this.siteId;
    }
    
    public void CompanySite.setSiteId(String siteId) {
        this.siteId = siteId;
    }
    
    public String CompanySite.getLocation() {
        return this.location;
    }
    
    public void CompanySite.setLocation(String location) {
        this.location = location;
    }
    
    public String CompanySite.getCity() {
        return this.city;
    }
    
    public void CompanySite.setCity(String city) {
        this.city = city;
    }
    
    public String CompanySite.getCountry() {
        return this.country;
    }
    
    public void CompanySite.setCountry(String country) {
        this.country = country;
    }
    
    public Set<Employee> CompanySite.getEmployees() {
        return this.employees;
    }
    
    public void CompanySite.setEmployees(Set<Employee> employees) {
        this.employees = employees;
    }
    
    public Set<Holiday> CompanySite.getHolidays() {
        return this.holidays;
    }
    
    public void CompanySite.setHolidays(Set<Holiday> holidays) {
        this.holidays = holidays;
    }
    
}
