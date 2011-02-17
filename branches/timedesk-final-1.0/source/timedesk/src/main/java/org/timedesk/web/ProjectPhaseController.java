package org.timedesk.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.Project;
import org.timedesk.entity.ProjectMember;
import org.timedesk.entity.ProjectPhase;
import org.timedesk.web.util.ApplicationTrace;
import org.timedesk.web.util.UrlEncoder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "projectphases", formBackingObject = ProjectPhase.class)
@RequestMapping("/projectphases")
@Controller
public class ProjectPhaseController 
{
	@RequestMapping(method = RequestMethod.POST)
    public String create(@Valid ProjectPhase projectPhase, BindingResult result, Model model, HttpServletRequest request) 
	{
        if (result.hasErrors()) 
        {
            model.addAttribute("projectPhase", projectPhase);
            addDateTimeFormatPatterns(model);
            return "projectphases/create";
        }
        String phaseId = generatePhaseId(projectPhase);
        if(phaseId != null)
        	projectPhase.setPhaseId(phaseId);
        else
        {
        	ObjectError error = new ObjectError("ProjectPhase", "Error in generating Phase ID, please review below information and try again.");
       	 	result.addError(error);
        	model.addAttribute("projectPhase", projectPhase);
            addDateTimeFormatPatterns(model);
            return "projectphases/create";
        }
        projectPhase.persist();
        return "redirect:/projectphases/" + UrlEncoder.encodeUrlPathSegment(projectPhase.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String createForm(Model model) 
    {
        model.addAttribute("projectPhase", new ProjectPhase());
        addDateTimeFormatPatterns(model);
        List dependencies = new ArrayList();
        if (Project.countProjects() == 0) {
            dependencies.add(new String[]{"project", "projects"});
        }
        model.addAttribute("dependencies", dependencies);
        return "projectphases/create";
    }
    
    private String generatePhaseId(ProjectPhase phase)
    {
    	if(phase != null)
    	{
    		int i = 1;
    		String phaseKey = phase.getProject().getProjectId().toUpperCase() + "PH";
    		String phaseId = phaseKey + (i++);
    		
    		ApplicationTrace.trace("New Phase ID: " + phaseId);
    		while(ProjectPhase.findProjectPhase(phaseId) != null)
    		{
    			phaseId = phaseKey + (i++);
    			ApplicationTrace.trace("New Phase ID: " + phaseId);
    		}
    		return phaseId; 
    	}
    	return null;
    }
}
