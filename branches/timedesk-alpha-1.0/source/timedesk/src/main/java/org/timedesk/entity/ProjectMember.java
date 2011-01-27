package org.timedesk.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "project_member")
public class ProjectMember 
{
    @NotNull
    @Column(name = "member_id")
    private String memberId;
    
    @OneToOne
    private Employee employee;

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<ProjectMemberRole> memberRoles = new HashSet<ProjectMemberRole>();

    @ManyToMany(cascade = CascadeType.ALL)
    private Set<Feedback> feedbacks = new HashSet<Feedback>();
}
