package org.timedesk.entity;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;
import java.util.Set;
import org.timedesk.entity.Site;
import java.util.HashSet;

import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.CascadeType;

@RooJavaBean
@RooToString
@RooEntity
public class Company 
{
	@Id
    private String companyId;

    private String name;

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<Site> sites = new HashSet<Site>();
}
