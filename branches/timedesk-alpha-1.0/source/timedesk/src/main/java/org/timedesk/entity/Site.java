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
 *  2010 Dec 30 - Imesh - Created
 *
 */

package org.timedesk.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;

@RooJavaBean
@RooToString
@RooEntity
@Table(name="site")
public class Site 
{
	@NotNull
	@ManyToOne
    @JoinColumn(name = "company_id", referencedColumnName = "company_id")
    private Company company;
	
	@NotNull
	@Column(name = "site_id")
	private String siteId;

	@Column(name = "location")
    private String location;

	@Column(name = "city")
    private String city;

	@Column(name = "country")
    private String country;

    @OneToMany(cascade = CascadeType.ALL, mappedBy="site")
    private Set<Employee> employees = new HashSet<Employee>();
}
