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
import org.springframework.web.bind.annotation.RequestParam;
import org.timedesk.entity.CompanySite;
import org.timedesk.entity.Employee;
import org.timedesk.entity.User;
import org.timedesk.web.util.ApplicationTrace;
import org.timedesk.web.util.UrlEncoder;

@RooWebScaffold(path = "employees", formBackingObject = Employee.class)
@RequestMapping("/employees")
@Controller
public class EmployeeController 
{
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String createForm(Model model, @RequestParam(value = "parentId", required = false) Long parentId) 
    {
    	Employee employee = new Employee();
    	if(parentId != null)
    	{
    		User user = User.findUser(parentId);
    		if(user != null)
    			employee.setUser(user);
    	}
    	
        model.addAttribute("employee", employee);
        List dependencies = new ArrayList();
        if (CompanySite.countCompanySites() == 0) 
        {
            dependencies.add(new String[]{"companySite", "companysites"});
        }
        model.addAttribute("dependencies", dependencies);
        return "employees/create";
    }
    
    @RequestMapping(method = RequestMethod.POST)
    public String create(@Valid Employee employee, BindingResult result, Model model, HttpServletRequest request) 
    {
    	ApplicationTrace.trace("EmployeeController.create() hasErrors: " + result.hasErrors());
        if (result.hasErrors()) 
        {        	
            model.addAttribute("employee", employee);
            return "employees/create";
        }
        String employeeId = generateEmployeeId(employee);
        if(employeeId != null)
        	employee.setEmployeeId(employeeId);
        else
        {
        	 ObjectError error = new ObjectError("Employee", "Error in generating Employee ID, please review below information and try again.");
        	 result.addError(error);
        	 model.addAttribute("employee", employee);
             return "employees/create";
        }
        employee.persist();
        return "redirect:/employees/" + UrlEncoder.encodeUrlPathSegment(employee.getId().toString(), request);
    }
    
    private String generateEmployeeId(Employee employee)
    {
    	if(employee != null)
    	{
    		int i = 1;
    		String employeeId = employee.getFirstName().substring(0, 2).toUpperCase() +
    							employee.getLastName().substring(0, 2).toUpperCase() +
    							employee.getCompanySite().getSiteId().substring(0, 3).toUpperCase();
    		ApplicationTrace.trace("New Employee ID: " + employeeId);
    		while(Employee.findEmployee(employeeId) != null)
    		{
    			employeeId += "" + (i++);
    			ApplicationTrace.trace("New Employee ID: " + employeeId);
    		}
    		return employeeId;    		
    	}
    	return null;
    }
}
