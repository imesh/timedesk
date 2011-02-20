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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
        return "redirect:/projects/" + UrlEncoder.encodeUrlPathSegment(projectPhase.getProject().getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String createForm(Model model, @RequestParam(value = "parentId", required = false) Long parentId) 
    {
		ProjectPhase phase = new ProjectPhase();
    	if(parentId != null)
    	{
    		Project project = Project.findProject(parentId);
    		if(project != null)
    			phase.setProject(project);    		
    	}
        model.addAttribute("projectPhase", phase);
        addDateTimeFormatPatterns(model);
        List dependencies = new ArrayList();
        if (Project.countProjects() == 0) {
            dependencies.add(new String[]{"project", "projects"});
        }
        model.addAttribute("dependencies", dependencies);
        return "projectphases/create";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String update(@Valid ProjectPhase projectPhase, BindingResult result, Model model, HttpServletRequest request) 
    {
        if (result.hasErrors()) {
            model.addAttribute("projectPhase", projectPhase);
            addDateTimeFormatPatterns(model);
            return "projectphases/update";
        }
        projectPhase.merge();
        return "redirect:/projects/" + UrlEncoder.encodeUrlPathSegment(projectPhase.getProject().getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) 
    {
    	ProjectPhase phase = ProjectPhase.findProjectPhase(id);
    	String projectId = phase.getProject().getId().toString();
        ProjectPhase.findProjectPhase(id).remove();        
        return "redirect:/projects/" + projectId;
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
