package org.timedesk.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.timedesk.entity.Employee;
import org.timedesk.entity.ProjectPhaseMember;
import org.timedesk.web.util.ApplicationTrace;
import org.timedesk.web.util.UrlEncoder;

@RooWebScaffold(path = "projectphasemembers", formBackingObject = ProjectPhaseMember.class)
@RequestMapping("/projectphasemembers")
@Controller
public class ProjectPhaseMemberController 
{
	@RequestMapping(method = RequestMethod.POST)
    public String create(@Valid ProjectPhaseMember projectPhaseMember, BindingResult result, Model model, HttpServletRequest request) 
    {
        if (result.hasErrors()) 
        {
            model.addAttribute("projectPhaseMember", projectPhaseMember);
            addDateTimeFormatPatterns(model);
            return "projectphasemembers/create";
        }        
        ObjectError error = validateEmployeeAllocation(projectPhaseMember, result, model);
        if(error != null)
        {
        	result.addError(error);
			model.addAttribute("projectPhaseMember", projectPhaseMember);
			addDateTimeFormatPatterns(model);
			return "projectphasemembers/create";
        }
        projectPhaseMember.persist();        
        return "redirect:/projectphasemembers/" + UrlEncoder.encodeUrlPathSegment(projectPhaseMember.getId().toString(), request);
    }
	
	@RequestMapping(method = RequestMethod.PUT)
    public String update(@Valid ProjectPhaseMember projectPhaseMember, BindingResult result, Model model, HttpServletRequest request) 
    {
        if (result.hasErrors()) 
        {
            model.addAttribute("projectPhaseMember", projectPhaseMember);
            addDateTimeFormatPatterns(model);
            return "projectphasemembers/update";
        }        
        ObjectError error = validateEmployeeAllocation(projectPhaseMember, result, model);
        if(error != null)
        {
        	result.addError(error);
			model.addAttribute("projectPhaseMember", projectPhaseMember);
			addDateTimeFormatPatterns(model);
			return "projectphasemembers/update";
        }        
        projectPhaseMember.merge();        
        return "redirect:/projectphasemembers/" + UrlEncoder.encodeUrlPathSegment(projectPhaseMember.getId().toString(), request);
    }

	private ObjectError validateEmployeeAllocation(ProjectPhaseMember projectPhaseMember, BindingResult result, Model model)
	{
		Employee employee = projectPhaseMember.getProjectMember().getEmployee();
        if(employee != null)
        {       	
        	// Check employee max allocation
	        Integer maxAllocation = employee.getMaxAllocation();
			if (maxAllocation != null)
			{
				if (projectPhaseMember.getAllocation().intValue() > maxAllocation.intValue())
				{
					ObjectError error = new ObjectError(projectPhaseMember.toString(), "Allocation should be less than or equal to Employee Max Allocation " + maxAllocation.intValue() + ".");
					return error;
				}
				// Check current allocation
				int currentAllocation = employee.findAllocation(projectPhaseMember.getId(), projectPhaseMember.getStartDate(), projectPhaseMember.getEndDate());
				int allowed = maxAllocation.intValue() - currentAllocation;
				
				ApplicationTrace.trace("Max Allocation: " +  maxAllocation.intValue());
				ApplicationTrace.trace("Current Allocation: " + currentAllocation);
				
				if (maxAllocation.intValue() == currentAllocation)
				{
					ObjectError error = new ObjectError(projectPhaseMember.toString(), "There is no space to allocate " + employee.getFirstName() + " " + employee.getLastName() + " from " + shortDate(projectPhaseMember.getStartDate()) + " to " + shortDate(projectPhaseMember.getEndDate()) + ".");
					return error;
				}
				else if (projectPhaseMember.getAllocation().intValue() > allowed)
				{
					ObjectError error = new ObjectError(projectPhaseMember.toString(), "Allocation should be less than or equal to remaining allocation " + allowed + "% from " + shortDate(projectPhaseMember.getStartDate()) + " to " + shortDate(projectPhaseMember.getEndDate()) + ".");
					return error;
				}
			}
		}
        return null;
	}
	
	private String shortDate(Date date)
	{
		if(date != null)
		{
			DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");			
			return formatter.format(date);
		}
		return "";
	}
}
