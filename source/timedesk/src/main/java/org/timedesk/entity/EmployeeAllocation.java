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

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "employee_allocation") // This is a database view
public class EmployeeAllocation 
{
	@NotNull
	@Column(name = "emp_id")
    private Long empId;
	
	@NotNull
	@Column(name = "employee_id")
    private String employeeId;
	
	@NotNull
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
	
	@NotNull
	@Column(name = "allocation")
    private Integer allocation;
}
