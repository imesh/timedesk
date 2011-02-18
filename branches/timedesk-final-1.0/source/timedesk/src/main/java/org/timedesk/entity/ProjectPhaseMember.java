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
 *  2011 Jan 29 - Imesh - Created
 *  2011 Feb 16 - Imesh - Changed referenced column names to id.
 *
 */

package org.timedesk.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Query;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "project_phase_member", uniqueConstraints = @UniqueConstraint(columnNames = "phase_id,phase_member_id"))
public class ProjectPhaseMember 
{
	@NotNull
	@ManyToOne
	@JoinColumn(name = "phase_id", referencedColumnName = "id")
	private ProjectPhase projectPhase;
	
	@Column(name = "phase_member_id")
	private String phaseMemberId;
	
	@OneToOne
	@JoinColumn(name = "member_id", referencedColumnName = "id")
	private ProjectMember projectMember;
	
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
	
	@NotNull
	@Column(name = "allocation")
    private Integer allocation;
	
    public String toString() 
    {
        StringBuilder sb = new StringBuilder();        
        sb.append(getPhaseMemberId());
        return sb.toString();
    }
    
    public static ProjectPhaseMember findProjectPhaseMember(Long id) 
    {
        if (id == null) return null;
        ProjectPhaseMember entity = entityManager().find(ProjectPhaseMember.class, id);
        if(entity != null)
        	entity.entityManager().refresh(entity);
        return entity;
    }
    
    public static ProjectPhaseMember findProjectPhaseMember(String phaseMemberId) 
    {        
        if(phaseMemberId != null)
        {
        	Query query = entityManager().createQuery("SELECT ph FROM ProjectPhaseMember ph WHERE ph.phaseMemberId = ?1");    	
        	query.setParameter(1, phaseMemberId);
        	List<ProjectPhaseMember> list = query.getResultList();
        	if((list != null) && (list.size() > 0))
        		return list.get(0);
        }
        return null;
    }
}
