package org.timedesk.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TemporalType;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.Employee;
import org.timedesk.entity.EmployeeAllocation;
import org.timedesk.entity.EmployeeWeeklyAllocation;
import org.timedesk.entity.Project;
import org.timedesk.entity.ProjectMember;
import org.timedesk.entity.ProjectPhase;
import org.timedesk.entity.ProjectPhaseMember;
import org.timedesk.web.util.ApplicationTrace;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "employeeweeklyallocations", formBackingObject = EmployeeWeeklyAllocation.class)
@RequestMapping("/employeeweeklyallocations")
@Controller
public class EmployeeWeeklyAllocationController 
{	
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String createForm(Model model) 
    {
    	model.addAttribute("employeeweeklyallocations", null);   
        return "employeeweeklyallocations/create";
    }
    
    @RequestMapping(method = RequestMethod.POST)
    public String create(@Valid EmployeeWeeklyAllocation employeeWeeklyAllocation, BindingResult result, Model model, HttpServletRequest request, @RequestParam(value = "year", required = false) String year, @RequestParam(value = "month", required = false) String month) 
    {
    	ApplicationTrace.trace("Find Employee Weekly Allocation");
    	if((year != null) && (month != null))
    	{    		
			try
			{
				ApplicationTrace.trace("year: " + year + "month: " + month);
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
	    	    Date startDate = formatter.parse(year + "/" + month + "/1");
	    	    Date endDate = formatter.parse(year + "/" + (Integer.parseInt(month) + 2) + "/1");
	    	    ApplicationTrace.trace("State date: " + startDate.toString() + " End date: " + endDate.toString());
	    	    	    	    
	    	    List<Project> projectList = Project.findAllProjects();
	    	    List<Employee>list = Employee.findAllEmployees();
	    	    if((list != null) && (list.size() > 0))
	    	    {
	    	    	Date fromDate = null;
	    	    	Date toDate = null;
	    	    	
	    	    	int id = 1;
	    	    	EmployeeWeeklyAllocation allocation = null;
					Collection<EmployeeWeeklyAllocation> allocationCollection = new ArrayList();
					for (Employee employee : list)
					{
						allocation = new EmployeeWeeklyAllocation();
						allocation.setId((long) id++);
						allocation.setEmployeeName(employee.getFirstName() + " " + employee.getLastName());
						allocationCollection.add(allocation);

						fromDate = formatter.parse(year + "/" + month + "/1");
						toDate = addWeek(fromDate);						
						int remaining = employee.findAllocation(fromDate, toDate);						
						allocation.setWeek1(String.valueOf(remaining));
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						remaining = employee.findAllocation(fromDate, toDate);						
						allocation.setWeek2(String.valueOf(remaining));
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						remaining = employee.findAllocation(fromDate, toDate);						
						allocation.setWeek3(String.valueOf(remaining));
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						remaining = employee.findAllocation(fromDate, toDate);						
						allocation.setWeek4(String.valueOf(remaining));
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						remaining = employee.findAllocation(fromDate, toDate);						
						allocation.setWeek5(String.valueOf(remaining));
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						remaining = employee.findAllocation(fromDate, toDate);						
						allocation.setWeek6(String.valueOf(remaining));
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						remaining = employee.findAllocation(fromDate, toDate);						
						allocation.setWeek7(String.valueOf(remaining));
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						remaining = employee.findAllocation(fromDate, toDate);						
						allocation.setWeek8(String.valueOf(remaining));

					}
					model.addAttribute("year", year);
					model.addAttribute("month", findMonthName(Integer.valueOf(month)) + " ");
					model.addAttribute("employeeweeklyallocations", allocationCollection);
				}
			}
			catch (ParseException e)
			{
				ApplicationTrace.trace(e);
			}   		
    	}
        return "employeeweeklyallocations/create";
    }
    
	private Object findMonthName(int month)
	{
		if(month == 1)
			return "January";
		else if(month == 2)
			return "February";
		else if(month == 3)
			return "March";
		else if(month == 4)
			return "April";
		else if(month == 5)
			return "May";
		else if(month == 6)
			return "June";
		else if(month == 7)
			return "July";
		else if(month == 8)
			return "August";
		else if(month == 9)
			return "September";
		else if(month == 10)
			return "October";
		else if(month == 11)
			return "November";
		else if(month == 12)
			return "December";
		else
			return "";
	}

	private Date addWeek(Date date)
	{
		if (date != null)
		{
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.WEEK_OF_YEAR, 1);
			return cal.getTime();
		}
		return null;
	}
}
