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
 *  2011 Feb 17 - Imesh - Created
 *
 */

package org.timedesk.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Query;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import org.eclipse.persistence.annotations.ReadOnly;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;

@RooJavaBean
@RooToString
@RooEntity
@ReadOnly
@Table(name = "employee_allocation") // This is a database view
public class EmployeeAllocation 
{
	@Column(name = "emp_id")
    private Long empId;
	
	@Column(name = "employee_id")
    private String employeeId;
	
	@Column(name = "first_name")
    private String firstName;

	@Column(name = "last_name")
    private String lastName;
	
	@Column(name = "p_id")
    private Long pId;
	
	@Column(name = "name")
    private String projectName;

	@Column(name = "phm_id")
    private Long phmId;
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(style = "S-")
	@Column(name = "start_date")
    private Date startDate;
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(style = "S-")
	@Column(name = "end_date")
    private Date endDate;
	
	@Column(name = "allocation")
    private Integer allocation;
	
    public static List<EmployeeAllocation> findAllocationsByEmployeeProject(Date fromDate, Date toDate)
	{
		Query query = entityManager().createQuery("SELECT ea FROM EmployeeAllocation ea WHERE (ea.startDate >= ?1 AND ea.endDate <= ?2) ORDER BY ea.empId");
		query.setParameter(1, fromDate, TemporalType.DATE);
		query.setParameter(2, toDate, TemporalType.DATE);
		List<EmployeeAllocation> list = query.getResultList();
		
		String key = null;
		List keyList = new ArrayList();
		List<EmployeeAllocation> result = new ArrayList();
		for(EmployeeAllocation allocation : list)
		{
			key = allocation.getEmpId().toString() + allocation.getPId();
			if(!foundInList(keyList, key))
			{
				result.add(allocation);
				keyList.add(key);
			}
		}
		return result;
	}
    
    private static boolean foundInList(List list, String value)
    {
    	for(int i = 0; i < list.size(); i++)
    	{
    		if((value != null) && value.equals(list.get(i).toString()))
    			return true;
    	}
    	return false;
    }
    
	public static double findAllocation(Date fromDate, Date toDate, Long empId, Long pId)
	{
		Query query = entityManager().createQuery("SELECT ea FROM EmployeeAllocation ea WHERE ea.empId = ?1 AND ea.pId = ?2 AND ((ea.startDate >= ?3 AND ea.startDate < ?4 AND ea.endDate > ?4) OR (ea.startDate <= ?3 AND ea.endDate >= ?4) OR (ea.startDate < ?3 AND ea.endDate <= ?4 AND ea.endDate > ?3))");
		query.setParameter(1, empId);
		query.setParameter(2, pId);
		query.setParameter(3, fromDate, TemporalType.DATE);
		query.setParameter(4, toDate, TemporalType.DATE);
		List<EmployeeAllocation> list = query.getResultList();
		int totalAllocation = 0;
		EmployeeAllocation allocation = null;
		for (int i = 0; i < list.size(); i++)
		{
			allocation = list.get(i);
			totalAllocation += allocation.getAllocation();
		}
		return (totalAllocation/20);
	}
}
