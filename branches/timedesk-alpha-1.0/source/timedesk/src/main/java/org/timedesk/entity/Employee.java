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

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "employee")
public class Employee 
{
	@NotNull
	@ManyToOne
    @JoinColumn(name = "site_id", referencedColumnName = "site_id")
	private CompanySite companySite;
	
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
    private Set<Skill> employeeSkills = new HashSet<Skill>();

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<EmployeeRole> employeeRoles = new HashSet<EmployeeRole>();
    
    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "employee_pre_em_role")
    private Set<EmployeeRole> preEmployeeRoles = new HashSet<EmployeeRole>();
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "employee")
    private Set<EmployeeVisa> visas = new HashSet<EmployeeVisa>();
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "employee")
    private Set<EmployeeLeave> leaves = new HashSet<EmployeeLeave>();
    
    public String toString() 
    {
        StringBuilder sb = new StringBuilder();        
        sb.append(getFirstName()).append(" ");
        sb.append(getLastName());       
        return sb.toString();
    }
}
