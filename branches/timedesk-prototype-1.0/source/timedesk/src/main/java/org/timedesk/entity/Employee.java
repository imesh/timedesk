package org.timedesk.entity;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;
import java.util.Set;
import org.timedesk.entity.EmployeeSkill;
import java.util.HashSet;
import javax.persistence.ManyToMany;
import javax.persistence.CascadeType;
import org.timedesk.entity.EmployeeRole;

@RooJavaBean
@RooToString
@RooEntity
public class Employee {

    private String employeeId;

    private String firstName;

    private String lastName;

    private String email;

    private String address;

    private String city;

    private String country;

    private String postCode;

    private String phoneResidence;

    private String phoneMobile;

    private String officeExtension;

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<EmployeeSkill> employeeSkills = new HashSet<EmployeeSkill>();

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<EmployeeRole> employeeRoles = new HashSet<EmployeeRole>();
}
