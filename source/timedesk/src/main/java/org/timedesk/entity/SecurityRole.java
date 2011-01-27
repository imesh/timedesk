package org.timedesk.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "security_role")
public class SecurityRole 
{
	@NotNull
	@Column(name = "security_role_id")
	private String securityRoleId;
	
	@NotNull
	@Column(name = "name")
    private String name;
	
	@ManyToMany(cascade = CascadeType.ALL)
    private Set<ApplicationFeature> tasks = new HashSet<ApplicationFeature>();

}
