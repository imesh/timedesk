/*
 *  Timedesk
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

import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "project_member_feedback", uniqueConstraints = @UniqueConstraint(columnNames = "member_id,feedback_id"))
public class ProjectMemberFeedback
{
	@NotNull
	@ManyToOne
	@JoinColumn(name = "member_id", referencedColumnName = "id")
	private ProjectMember projectMember;
	
	@Column(name = "description")
    private String description;
	
    public String toString() 
    {
        StringBuilder sb = new StringBuilder();       
        sb.append(getDescription());
        return sb.toString();
    }
    
    public static ProjectMemberFeedback findProjectMemberFeedback(Long id) 
    {
        if (id == null) return null;
        ProjectMemberFeedback entity = entityManager().find(ProjectMemberFeedback.class, id);
        if(entity != null)
        	entity.entityManager().refresh(entity);
        return entity;
    }
}
