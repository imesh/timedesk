package org.timedesk.entity;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Set;
import org.timedesk.entity.ProjectMemberRole;
import java.util.HashSet;
import javax.persistence.ManyToMany;
import javax.persistence.CascadeType;
import javax.validation.constraints.NotNull;
import org.timedesk.entity.Feedback;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "project_member")
public class ProjectMember {

    @NotNull
    @Column(name = "member_id")
    private String memberId;

    @Column(name = "allocation")
    private int allocation;

    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "S-")
    @Column(name = "start_date")
    private Date startDate;

    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "S-")
    @Column(name = "end_date")
    private Date endDate;
    
    @OneToOne
    private Employee employee;

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<ProjectMemberRole> memberRoles = new HashSet<ProjectMemberRole>();

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<Feedback> feedbacks = new HashSet<Feedback>();
}
