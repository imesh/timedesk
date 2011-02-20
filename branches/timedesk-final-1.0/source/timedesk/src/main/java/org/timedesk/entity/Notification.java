package org.timedesk.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "notification")
public class Notification 
{	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(style = "MS")
	@Column(name = "sent_time")
	private Date sentTime;
	
	@Column(name = "mail_to")
    private String mailTo;

	@Column(name = "subject")
    private String subject;
	
	@Column(name = "message")
    private String message;
}
