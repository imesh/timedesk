package org.timedesk.entity;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;
import java.util.Date;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Set;
import org.timedesk.entity.ProjectMemberRole;
import java.util.HashSet;
import javax.persistence.ManyToMany;
import javax.persistence.CascadeType;

@RooJavaBean
@RooToString
@RooEntity
public class ProjectMember {

    private int memberId;

    private int allocation;

    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "S-")
    private Date startDate;

    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "S-")
    private Date endDate;

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<ProjectMemberRole> memberRoles = new HashSet<ProjectMemberRole>();
}
