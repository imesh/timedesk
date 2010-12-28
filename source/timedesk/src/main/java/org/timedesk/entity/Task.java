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

import javax.persistence.Column;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "TASK")
public class Task
{
	@NotNull
	@Column(name = "task_id")
	private String taskId;

	@Column(name = "name")
	private String name;

	@Column(name = "description")
	private String description;
}
