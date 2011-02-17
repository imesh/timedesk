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
 *  2011 Feb 16 - Imesh - Changed referenced column names to id.
 *
 */

package org.timedesk.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Query;
import javax.persistence.Table;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Email;
import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.timedesk.web.util.ApplicationTrace;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "employee")
public class Employee 
{
	@NotNull
	@ManyToOne
    @JoinColumn(name = "site_id", referencedColumnName = "id")
	private CompanySite companySite;

	@Column(name = "employee_id")
    private String employeeId;
	
	@ManyToOne
	@JoinColumn(name = "username", referencedColumnName = "id")
	private User user;

	@Column(name = "first_name")
    private String firstName;

	@Column(name = "last_name")
    private String lastName;

	@Email
	@Column(name = "email")
    private String email;

	@Column(name = "address")
    private String address;

	@Column(name = "city")
    private String city;

	@Enumerated(EnumType.STRING)
	@Column(name = "country")
    private CountryEnum country;

	@Column(name = "post_code")
    private String postCode;

	@Column(name = "phone_residence")
    private String phoneResidence;

	@Column(name = "phone_mobile")
    private String phoneMobile;

	@Column(name = "office_extension")
    private String officeExtension;
	
	@NotNull
	@Column(name = "max_allocation")
	private Integer maxAllocation = 100;
	
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
    
    public static Employee findEmployee(Long id) 
    {
        if (id == null) return null;
        Employee entity = entityManager().find(Employee.class, id);
        if(entity != null)
        	entityManager().refresh(entity);
        return entity;
    }
    
    public static Employee findEmployee(String employeeId) 
    {        
        if(employeeId != null)
        {
        	Query query = entityManager().createQuery("SELECT e FROM Employee e WHERE e.employeeId = ?1");    	
        	query.setParameter(1, employeeId);
        	List<Employee> list = query.getResultList();
        	if((list != null) && (list.size() > 0))
        		return list.get(0);
        }
        return null;
    }
    
    public int findAllocation(Long phmId, Date fromDate, Date toDate)
    {
    	Query query = entityManager().createQuery("SELECT ea FROM EmployeeAllocation ea WHERE ea.empId = ?1 AND ((ea.startDate > ?2 AND ea.startDate < ?3 AND ea.endDate > ?3) OR (ea.startDate <= ?2 AND ea.endDate >= ?3) OR (ea.startDate < ?2 AND ea.endDate < ?3 AND ea.endDate > ?2))");    	
    	query.setParameter(1, getId());
    	query.setParameter(2, fromDate, TemporalType.DATE);
    	query.setParameter(3, toDate, TemporalType.DATE);
    	
    	List<EmployeeAllocation> list = query.getResultList();   	
    	int totalAllocation = 0;
    	EmployeeAllocation allocation = null;   	
    	for(int i = 0; i < list.size(); i++)
    	{ 		
    		allocation = list.get(i);
    		if((phmId == null) || (allocation.getPhmId().intValue() != phmId.intValue()))
    		{
    			totalAllocation += allocation.getAllocation();
    			ApplicationTrace.trace("PhmID: " + allocation.getPhmId() + " - " + phmId);
	    		ApplicationTrace.trace("Allocation: " + allocation.getAllocation());
    		}
    	}
    	return totalAllocation;
    }
}
