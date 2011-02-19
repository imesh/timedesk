package org.timedesk.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;

@RooJavaBean
@RooToString
@Table(name = "project", uniqueConstraints = @UniqueConstraint(columnNames = "company_id,project_id"))
@RooEntity(finders = { "findProjectsByCompany", "findProjectsByName" })
public class Project {

    @NotNull
    @ManyToOne
    @JoinColumn(name = "company_id", referencedColumnName = "id")
    private Company company;

    @NotNull
    @Column(name = "project_id")
    private String projectId;

    @NotNull
    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @NotNull
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "S-")
    @Column(name = "start_date")
    private Date startDate;

    @NotNull
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "S-")
    @Column(name = "end_date")
    private Date endDate;

    @Transient
    private Boolean multiplePhases;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "project")
    private Set<ProjectMember> projectMembers = new HashSet<ProjectMember>();

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "project")
    private Set<ProjectPhase> projectPhases = new HashSet<ProjectPhase>();

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getName());
        return sb.toString();
    }

    public static Project findProject(Long id) {
        if (id == null) return null;
        Project entity = entityManager().find(Project.class, id);
        if (entity != null) entityManager().refresh(entity);
        return entity;
    }
}
