/*
 *  Timedesk
 *  Project Resource Management System
 *  http://code.google.com/p/timedesk
 *   
 *  Masters in Enterprise Applications Development
 *  Sri Lanka Institute of Information Technology, Sri Lanka
 *  Sheffield Hallam University, United Kingdom
 *  
 *  History:
 *  2010 Jan 27 - Imesh - Created
 *
 */
package org.timedesk.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "employee_leave")
public class EmployeeLeave 
{
	@NotNull
	@Column(name = "leave_seq_no")
	private int leaveSeqNo;
	
	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "from_time")
	private Date fromTime;
	
	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "to_time")
	private Date toTime;
}