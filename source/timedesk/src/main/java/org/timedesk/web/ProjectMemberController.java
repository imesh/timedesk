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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.timedesk.entity.Employee;
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
        if(projectMember.getEmployee() == null)
        {
        	ObjectError error = new ObjectError("ProjectMember", "Employee should be set to continue.");
       	 	result.addError(error);
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
        return "redirect:/projects/" + UrlEncoder.encodeUrlPathSegment(projectMember.getProject().getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String createForm(Model model, @RequestParam(value = "parentId", required = false) Long parentId) 
    {
    	Project project = null;
    	ProjectMember member = new ProjectMember();
    	if(parentId != null)
    	{
    		project = Project.findProject(parentId);
    		if(project != null)
    			member.setProject(project);    		
    	}
        model.addAttribute("projectMember", member);
        List dependencies = new ArrayList();
        if (Project.countProjects() == 0) 
        {
            dependencies.add(new String[]{"project", "projects"});
        }
        model.addAttribute("dependencies", dependencies);
        return "projectmembers/create";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String update(@Valid ProjectMember projectMember, BindingResult result, Model model, HttpServletRequest request) 
    {
        if (result.hasErrors()) 
        {
            model.addAttribute("projectMember", projectMember);
            return "projectmembers/update";
        }
        projectMember.merge();
        return "redirect:/projects/" + UrlEncoder.encodeUrlPathSegment(projectMember.getProject().getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) 
    {
    	ProjectMember member = ProjectMember.findProjectMember(id);
    	String projectId = member.getProject().getId().toString();
    	
        ProjectMember.findProjectMember(id).remove();        
        return "redirect:/projects/" + projectId;        
    }
    
    private String generateMemberId(ProjectMember member)
    {
    	if(member != null)
    	{
    		int i = 1;    		
    		String memberId = member.getProject().getProjectId().toUpperCase();
    		String memberKey = null;
    		if(member.getEmployee() != null)
    			memberKey = memberId += member.getEmployee().getEmployeeId().toUpperCase();
    		else
    		{
    			memberKey = memberId += "MEM";
    			memberId = memberId + (i++);
    		}
    		ApplicationTrace.trace("New Member ID: " + memberId);
    		while(ProjectMember.findProjectMember(memberId) != null)
    		{
    			memberId = memberKey + (i++);
    			ApplicationTrace.trace("New Member ID: " + memberId);
    		}
    		return memberId;    		
    	}
    	return null;
    }
}
