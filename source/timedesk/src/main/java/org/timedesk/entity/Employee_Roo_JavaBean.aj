// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import java.lang.Integer;
import java.lang.String;
import java.util.Set;
import org.timedesk.entity.CompanySite;
import org.timedesk.entity.CountryEnum;
import org.timedesk.entity.EmployeeLeave;
import org.timedesk.entity.EmployeeRole;
import org.timedesk.entity.EmployeeVisa;
import org.timedesk.entity.Skill;
import org.timedesk.entity.User;

privileged aspect Employee_Roo_JavaBean {
    
    public CompanySite Employee.getCompanySite() {
        return this.companySite;
    }
    
    public void Employee.setCompanySite(CompanySite companySite) {
        this.companySite = companySite;
    }
    
    public String Employee.getEmployeeId() {
        return this.employeeId;
    }
    
    public void Employee.setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }
    
    public User Employee.getUser() {
        return this.user;
    }
    
    public void Employee.setUser(User user) {
        this.user = user;
    }
    
    public String Employee.getFirstName() {
        return this.firstName;
    }
    
    public void Employee.setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String Employee.getLastName() {
        return this.lastName;
    }
    
    public void Employee.setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String Employee.getEmail() {
        return this.email;
    }
    
    public void Employee.setEmail(String email) {
        this.email = email;
    }
    
    public String Employee.getAddress() {
        return this.address;
    }
    
    public void Employee.setAddress(String address) {
        this.address = address;
    }
    
    public String Employee.getCity() {
        return this.city;
    }
    
    public void Employee.setCity(String city) {
        this.city = city;
    }
    
    public CountryEnum Employee.getCountry() {
        return this.country;
    }
    
    public void Employee.setCountry(CountryEnum country) {
        this.country = country;
    }
    
    public String Employee.getPostCode() {
        return this.postCode;
    }
    
    public void Employee.setPostCode(String postCode) {
        this.postCode = postCode;
    }
    
    public String Employee.getPhoneResidence() {
        return this.phoneResidence;
    }
    
    public void Employee.setPhoneResidence(String phoneResidence) {
        this.phoneResidence = phoneResidence;
    }
    
    public String Employee.getPhoneMobile() {
        return this.phoneMobile;
    }
    
    public void Employee.setPhoneMobile(String phoneMobile) {
        this.phoneMobile = phoneMobile;
    }
    
    public String Employee.getOfficeExtension() {
        return this.officeExtension;
    }
    
    public void Employee.setOfficeExtension(String officeExtension) {
        this.officeExtension = officeExtension;
    }
    
    public Integer Employee.getMaxAllocation() {
        return this.maxAllocation;
    }
    
    public void Employee.setMaxAllocation(Integer maxAllocation) {
        this.maxAllocation = maxAllocation;
    }
    
    public Integer Employee.getCurrentAllocation() {
        return this.currentAllocation;
    }
    
    public void Employee.setCurrentAllocation(Integer currentAllocation) {
        this.currentAllocation = currentAllocation;
    }
    
    public Set<Skill> Employee.getEmployeeSkills() {
        return this.employeeSkills;
    }
    
    public void Employee.setEmployeeSkills(Set<Skill> employeeSkills) {
        this.employeeSkills = employeeSkills;
    }
    
    public Set<EmployeeRole> Employee.getEmployeeRoles() {
        return this.employeeRoles;
    }
    
    public void Employee.setEmployeeRoles(Set<EmployeeRole> employeeRoles) {
        this.employeeRoles = employeeRoles;
    }
    
    public Set<EmployeeRole> Employee.getPreEmployeeRoles() {
        return this.preEmployeeRoles;
    }
    
    public void Employee.setPreEmployeeRoles(Set<EmployeeRole> preEmployeeRoles) {
        this.preEmployeeRoles = preEmployeeRoles;
    }
    
    public Set<EmployeeVisa> Employee.getVisas() {
        return this.visas;
    }
    
    public void Employee.setVisas(Set<EmployeeVisa> visas) {
        this.visas = visas;
    }
    
    public Set<EmployeeLeave> Employee.getLeaves() {
        return this.leaves;
    }
    
    public void Employee.setLeaves(Set<EmployeeLeave> leaves) {
        this.leaves = leaves;
    }
    
}
