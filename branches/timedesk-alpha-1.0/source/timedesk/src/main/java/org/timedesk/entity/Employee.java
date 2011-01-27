/*
 *  Time Desk
 *  Project Resource Management System
 *  http://code.google.com/p/timedesk
 *   
 *  Masters in Enterprise Applications Development
 *  Sri Lanka Institute of Information Technology, Sri Lanka
 *  Sheffield Hallam University, United Kingdom
 *  
 *  History:
 *  2010 Dec 27 - Imesh - Created
 *
 */

package org.timedesk.entity;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;
import java.util.Set;
import org.timedesk.entity.EmployeeSkill;
import java.util.HashSet;

import javax.persistence.Column;
import javax.persistence.OneToMany;
import javax.persistence.ManyToMany;
import javax.persistence.CascadeType;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.timedesk.entity.EmployeeRole;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "employee")
public class Employee 
{
	@NotNull
	@Column(name = "employee_id")
    private String employeeId;

	@Column(name = "first_name")
    private String firstName;

	@Column(name = "last_name")
    private String lastName;

	@Column(name = "email")
    private String email;

	@Column(name = "address")
    private String address;

	@Column(name = "city")
    private String city;

	@Column(name = "country")
    private String country;

	@Column(name = "post_code")
    private String postCode;

	@Column(name = "phone_residence")
    private String phoneResidence;

	@Column(name = "phone_mobile")
    private String phoneMobile;

	@Column(name = "office_extension")
    private String officeExtension;

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<EmployeeSkill> employeeSkills = new HashSet<EmployeeSkill>();

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<EmployeeRole> employeeRoles = new HashSet<EmployeeRole>();
    
    @ManyToMany(cascade = CascadeType.ALL)
    private Set<EmployeeRole> preEmployeeRoles = new HashSet<EmployeeRole>();
    
    @OneToMany(cascade = CascadeType.ALL)
    private Set<EmployeeVisa> employeeVisas = new HashSet<EmployeeVisa>();
    
    @OneToMany(cascade = CascadeType.ALL)
    private Set<EmployeeLeave> employeeLeaves = new HashSet<EmployeeLeave>();
}
