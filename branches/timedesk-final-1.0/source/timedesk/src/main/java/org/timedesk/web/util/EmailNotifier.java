package org.timedesk.web.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.timedesk.entity.Notification;

public class EmailNotifier
{
	public static void sendMessage(MailSender mailSender, NotificationEnum notification, String mailTo, String project)
	{
		sendMessage(mailSender, notification, mailTo, project, null, null, null);
	}
	
	public static void sendMessage(MailSender mailSender, NotificationEnum notification, String mailTo, String project, String projectPhase, Date startDate, Date endDate)
	{
		ApplicationTrace.trace("sendMessage() start");
		if(notification == NotificationEnum.AssignedToProject)
		{
			String subject = "[Timedesk] Assigned to project " + project;
			StringBuffer message = new StringBuffer();
			message.append("Notification: You have been assigned to project ").append(project).append(". \nTime: ").append(new Date());
			message.append("\n\n").append("http://www.timedeskonline.com");
			
			sendMessage(mailSender, subject, mailTo, message.toString());
		}
		else if(notification == NotificationEnum.UnAssignedFromProject)
		{
			String subject = "[Timedesk] Unassigned from project " + project;
			StringBuffer message = new StringBuffer();
			message.append("Notification: You have been unassigned from project ").append(project).append(". \nTime: ").append(new Date());
			message.append("\n\n").append("http://www.timedeskonline.com");
			
			sendMessage(mailSender, subject, mailTo, message.toString());
		}		
		else if(notification == NotificationEnum.AllocatedToProject)
		{
			String subject = "[Timedesk] Allocation to project phase " + project + " - " + projectPhase; 
		    StringBuffer message = new StringBuffer();
		    message.append("Notification: You have been allocated to project phase ").append(projectPhase);
		    message.append(" of project ").append(project).append(" from ").append(shortDate(startDate)).append(" to ").append(shortDate(endDate)).append(".\nTime: ").append(new Date());
		    message.append("\n\n").append("http://www.timedeskonline.com");
		    
		    sendMessage(mailSender, subject, mailTo, message.toString());
		}
		else if(notification == NotificationEnum.DeAllocatedFromProject)
		{
			String subject = "[Timedesk] Deallocated from project phase " + project + " - " + projectPhase; 
		    StringBuffer message = new StringBuffer();
		    message.append("Notification: You have been deallocated from project phase ").append(projectPhase);
		    message.append(" of project ").append(project).append(" from ").append(shortDate(startDate)).append(" to ").append(shortDate(endDate)).append(".\nTime: ").append(new Date());
		    message.append("\n\n").append("http://www.timedeskonline.com");
		    
		    sendMessage(mailSender, subject, mailTo, message.toString());
		}
		ApplicationTrace.trace("sendMessage() end");
	}
	
	private static void sendMessage(MailSender mailSender, String subject, String mailTo, String message)
	{
		try
		{
			SimpleMailMessage simpleMailMessage = new SimpleMailMessage();		
			simpleMailMessage.setSubject(subject);
			simpleMailMessage.setTo(mailTo);
			simpleMailMessage.setText(message);
			mailSender.send(simpleMailMessage);
			
			Notification notification = new Notification();
			notification.setSentTime(new Date());
			notification.setMailTo(mailTo);
			notification.setSubject(subject);
			notification.setMessage(message);
			notification.persist();
			ApplicationTrace.trace("Mail sent to " + mailTo);
		}
		catch(Exception e)
		{
			ApplicationTrace.trace(e);
		}
	}
	
	private static String shortDate(Date date)
	{
		if (date != null)
		{
			DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			return formatter.format(date);
		}
		return "";
	}
}
