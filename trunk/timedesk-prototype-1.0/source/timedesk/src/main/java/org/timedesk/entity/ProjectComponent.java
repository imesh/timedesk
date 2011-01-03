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
import org.timedesk.entity.Task;
import java.util.HashSet;

import javax.persistence.Column;
import javax.persistence.ManyToMany;
import javax.persistence.CascadeType;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "project_component")
public class ProjectComponent 
{
	@NotNull
	@Column(name = "component_id")
    private String componentId;

	@Column(name = "name")
    private String name;

	@Column(name = "description")
    private String description;

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<Task> tasks = new HashSet<Task>();
}
