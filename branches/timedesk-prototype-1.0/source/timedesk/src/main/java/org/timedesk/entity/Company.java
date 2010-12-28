package org.timedesk.entity;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.timedesk.entity.CompanySite;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "COMPANY")
public class Company 
{
	@NotNull
	@Column(name = "company_id")
    private String companyId;

    @Column(name = "name")
    private String name;

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<CompanySite> companySites = new HashSet<CompanySite>();
}
