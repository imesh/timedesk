package org.timedesk.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.CompanySite;
import org.timedesk.entity.Employee;
import org.timedesk.entity.EmployeeLeave;
import org.timedesk.entity.Holiday;
import org.timedesk.web.util.UrlEncoder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "employeeleaves", formBackingObject = EmployeeLeave.class)
@RequestMapping("/employeeleaves")
@Controller
public class EmployeeLeaveController 
{
	@RequestMapping(method = RequestMethod.POST)
    public String create(@Valid EmployeeLeave employeeLeave, BindingResult result, Model model, HttpServletRequest request) 
	{
        if (result.hasErrors()) {
            model.addAttribute("employeeLeave", employeeLeave);
            addDateTimeFormatPatterns(model);
            return "employeeleaves/create";
        }        
        employeeLeave.persist();
        return "redirect:/employees/" + UrlEncoder.encodeUrlPathSegment(employeeLeave.getEmployee().getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String createForm(Model model, @RequestParam(value = "parentId", required = false) Long parentId) 
    {
    	Employee employee = null;
    	EmployeeLeave leave = new EmployeeLeave();
    	if(parentId != null)
    	{
    		employee = Employee.findEmployee(parentId);
    		if(employee != null)
    			leave.setEmployee(employee);
    	}
        model.addAttribute("employeeLeave", leave);
        addDateTimeFormatPatterns(model);
        List dependencies = new ArrayList();
        if (Employee.countEmployees() == 0) {
            dependencies.add(new String[]{"employee", "employees"});
        }
        model.addAttribute("dependencies", dependencies);
        return "employeeleaves/create";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String update(@Valid EmployeeLeave employeeLeave, BindingResult result, Model model, HttpServletRequest request) 
    {
        if (result.hasErrors()) 
        {
            model.addAttribute("employeeLeave", employeeLeave);
            addDateTimeFormatPatterns(model);
            return "employeeleaves/update";
        }
        employeeLeave.merge();
        return "redirect:/employees/" + UrlEncoder.encodeUrlPathSegment(employeeLeave.getEmployee().getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) 
    {
    	EmployeeLeave leave = EmployeeLeave.findEmployeeLeave(id);
    	String employeeId = leave.getEmployee().getId().toString();
        leave.remove();        
        return "redirect:/employees/" + employeeId;
    }
}
