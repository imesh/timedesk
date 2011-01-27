package org.timedesk.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "project_phase_member")
public class ProjectPhaseMember 
{
	@NotNull
	@Column(name = "phase_member_id")
	private String phaseMemberId;
	
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
    private int allocation;
}
