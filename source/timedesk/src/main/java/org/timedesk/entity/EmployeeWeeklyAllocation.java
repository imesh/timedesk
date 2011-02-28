package org.timedesk.entity;

import javax.persistence.Column;
import javax.persistence.Table;

import org.eclipse.persistence.annotations.ReadOnly;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;

@RooJavaBean
@RooToString
@RooEntity
@ReadOnly
@Table(name = "employee_weekly_allocation")
public class EmployeeWeeklyAllocation 
{
	@Column(name = "employee_name")
    private String employeeName;

	@Column(name = "location")
	private String location;
	
	@Column(name = "project_name")
    private String projectName;

	@Column(name = "effort")
	private String effort;
	
	@Column(name = "week1")
    private String week1;

	@Column(name = "week2")
    private String week2;

	@Column(name = "week3")
    private String week3;

	@Column(name = "week4")
    private String week4;

	@Column(name = "week5")
    private String week5;

	@Column(name = "week6")
    private String week6;

	@Column(name = "week7")
    private String week7;

	@Column(name = "week8")
    private String week8;
}
