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
 *  2010 Dec 27 - Imesh - Created
 *  2011 Feb 16 - Imesh - Changed referenced column names to id.
 *
 */

package org.timedesk.entity;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Query;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "project_member", uniqueConstraints = @UniqueConstraint(columnNames = "project_id,member_id"))
public class ProjectMember 
{
	@NotNull
	@ManyToOne
	@JoinColumn(name = "project_id", referencedColumnName = "id")
	private Project project;
	
    @Column(name = "member_id")
    private String memberId;
    
    @NotNull
    @OneToOne
    @JoinColumn(name = "employee_id", referencedColumnName = "id")
    private Employee employee;
    
    @ManyToMany
    private Set<ProjectMemberRole> roles = new HashSet<ProjectMemberRole>();
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "projectMember")
    private Set<ProjectMemberFeedback> feedbacks = new HashSet<ProjectMemberFeedback>();
    
    public String toString() 
    {
        StringBuilder sb = new StringBuilder();        
        sb.append(getEmployee().getFirstName() + " " + getEmployee().getLastName());        
        return sb.toString();
    }
    
    public static ProjectMember findProjectMember(Long id) 
    {
        if (id == null) return null;
        ProjectMember entity = entityManager().find(ProjectMember.class, id);
        if(entity != null)
        	entity.entityManager().refresh(entity);
        return entity;
    }
    
    public static ProjectMember findProjectMember(String memberId) 
    {        
        if(memberId != null)
        {
        	Query query = entityManager().createQuery("SELECT m FROM ProjectMember m WHERE m.memberId = ?1");    	
        	query.setParameter(1, memberId);
        	List<ProjectMember> list = query.getResultList();
        	if((list != null) && (list.size() > 0))
        		return list.get(0);
        }
        return null;
    }
    
    public static Collection<ProjectMember> findProjectMemberByProject(Long projectId) 
    {        
        if(projectId != null)
        {
        	Query query = entityManager().createQuery("SELECT m FROM ProjectMember m WHERE m.project.id = ?1");    	
        	query.setParameter(1, projectId);
        	List<ProjectMember> list = query.getResultList();
        	return list;
        }
        return null;
    }
}
