package org.timedesk.entity;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;
import java.util.Set;
import org.timedesk.entity.Employee;
import java.util.HashSet;
import javax.persistence.ManyToMany;
import javax.persistence.CascadeType;

@RooJavaBean
@RooToString
@RooEntity
public class Site {

    private String siteId;

    private String location;

    private String city;

    private String country;

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<Employee> employees = new HashSet<Employee>();
}
