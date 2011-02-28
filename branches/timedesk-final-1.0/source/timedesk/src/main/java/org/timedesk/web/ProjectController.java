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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.timedesk.entity.Company;
import org.timedesk.entity.Project;
import org.timedesk.entity.ProjectPhase;
import org.timedesk.web.util.UrlEncoder;

@RooWebScaffold(path = "projects", formBackingObject = Project.class)
@RequestMapping("/projects")
@Controller
public class ProjectController 
{
	@RequestMapping(method = RequestMethod.POST)
    public String create(@Valid Project project, BindingResult result, Model model, HttpServletRequest request) 
	{
        if (result.hasErrors()) 
        {
            model.addAttribute("project", project);
            addDateTimeFormatPatterns(model);
            return "projects/create";
        }        
        project.persist();
        if(!project.getMultiplePhases().booleanValue())
        {
        	// Create Default Project Phase        	
        	ProjectPhase phase = new ProjectPhase();        	
        	phase.setProject(project);
        	phase.setPhaseId("DEFPH");
        	phase.setDescription("Default Project Phase");
        	phase.setStartDate(project.getStartDate());
        	phase.setEndDate(project.getEndDate());
        	phase.persist();
        	
        	project = Project.findProject(project.getId());
        }
        return "redirect:/projects/" + UrlEncoder.encodeUrlPathSegment(project.getId().toString(), request);
    }
	 
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String createForm(Model model, @RequestParam(value = "parentId", required = false) Long parentId) 
    {
    	Project project = new Project();
    	if(parentId != null)
    	{
    		Company company = Company.findCompany(parentId);
    		if(company != null)
    			project.setCompany(company);
    	}
    	project.setMultiplePhases(true);
        model.addAttribute("project", project);
        addDateTimeFormatPatterns(model);
        List dependencies = new ArrayList();
        if (Company.countCompanys() == 0) {
            dependencies.add(new String[]{"company", "companys"});
        }
        model.addAttribute("dependencies", dependencies);
        return "projects/create";
    }
}
