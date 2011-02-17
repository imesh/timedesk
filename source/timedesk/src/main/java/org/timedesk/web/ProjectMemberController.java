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
 *
 */

package org.timedesk.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.timedesk.entity.Project;
import org.timedesk.entity.ProjectMember;
import org.timedesk.web.util.ApplicationTrace;
import org.timedesk.web.util.UrlEncoder;

@RooWebScaffold(path = "projectmembers", formBackingObject = ProjectMember.class)
@RequestMapping("/projectmembers")
@Controller
public class ProjectMemberController 
{
	@RequestMapping(method = RequestMethod.POST)
    public String create(@Valid ProjectMember projectMember, BindingResult result, Model model, HttpServletRequest request) 
	{
        if (result.hasErrors()) 
        {
            model.addAttribute("projectMember", projectMember);
            return "projectmembers/create";
        }
        String memberId = generateMemberId(projectMember);
        if(memberId != null)
        	projectMember.setMemberId(memberId);
        else
        {
        	ObjectError error = new ObjectError("ProjectMember", "Error in generating Member ID, please review below information and try again.");
       	 	result.addError(error);
       	 	model.addAttribute("projectMember", projectMember);
       	 	return "projectmembers/create";
        }
        projectMember.persist();
        return "redirect:/projectmembers/" + UrlEncoder.encodeUrlPathSegment(projectMember.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String createForm(Model model) 
    {
        model.addAttribute("projectMember", new ProjectMember());
        List dependencies = new ArrayList();
        if (Project.countProjects() == 0) {
            dependencies.add(new String[]{"project", "projects"});
        }
        model.addAttribute("dependencies", dependencies);
        return "projectmembers/create";
    }
    
    private String generateMemberId(ProjectMember member)
    {
    	if(member != null)
    	{
    		int i = 1;
    		String memberId = member.getProject().getProjectId().toUpperCase();
    		if(member.getEmployee() != null)
    			memberId += member.getEmployee().getEmployeeId().toUpperCase();
    		else
    			memberId += "MEM" + i;
    		ApplicationTrace.trace(memberId);
    		while(ProjectMember.findProjectMember(memberId) != null)
    		{
    			memberId += "" + (i++);
    			ApplicationTrace.trace("New Member ID: " + memberId);
    		}
    		return memberId;    		
    	}
    	return null;
    }
}
