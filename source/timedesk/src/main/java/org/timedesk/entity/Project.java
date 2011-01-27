package org.timedesk.entity;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Set;
import org.timedesk.entity.ProjectMember;
import java.util.HashSet;
import javax.persistence.ManyToMany;
import javax.persistence.CascadeType;
import javax.validation.constraints.NotNull;
import org.timedesk.entity.ProjectPhase;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "project")
public class Project {

    @NotNull
    @Column(name = "project_id")
    private String projectId;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "S-")
    @Column(name = "start_date")
    private Date startDate;

    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "S-")
    @Column(name = "end_date")
    private Date endDate;

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<ProjectMember> members = new HashSet<ProjectMember>();

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<ProjectPhase> components = new HashSet<ProjectPhase>();
}
