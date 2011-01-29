package org.timedesk.entity;

import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "pm_role")
public class ProjectMemberRole 
{	
	@NotNull
	@Column(name = "role_id")
    private String roleId;

	@NotNull
	@Column(name = "name")
    private String name;
}
