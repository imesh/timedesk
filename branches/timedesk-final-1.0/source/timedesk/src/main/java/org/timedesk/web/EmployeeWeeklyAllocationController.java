package org.timedesk.web;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
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
import org.timedesk.entity.Employee;
import org.timedesk.entity.EmployeeAllocation;
import org.timedesk.entity.EmployeeWeeklyAllocation;
import org.timedesk.web.util.ApplicationTrace;

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
				model.addAttribute("serverInvoked", true);
				ApplicationTrace.trace("year: " + year + "month: " + month);
				SimpleDateFormat headerFormatter = new SimpleDateFormat("MMM d");
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
	    	    Date startDate = formatter.parse(year + "/" + month + "/1");
	    	    Date endDate = formatter.parse(year + "/" + (Integer.parseInt(month) + 2) + "/1");
	    	    ApplicationTrace.trace("State date: " + startDate.toString() + " End date: " + endDate.toString());
	    	        	    
	    	    List<EmployeeAllocation>list = EmployeeAllocation.findAllocationsByEmployeeProject(startDate, endDate);
	    	    	    	    
	    	    if((list != null) && (list.size() > 0))
	    	    {
	    	    	Date fromDate = null;
	    	    	Date toDate = null;	    	    	
	    	    	int id = 1;
	    	    	double totalEffort = 0;
	    	    	EmployeeWeeklyAllocation weeklyAllocation = null;
					Collection<EmployeeWeeklyAllocation> collection = new ArrayList();
										
					fromDate = findFirstDayOfMonth(Integer.parseInt(year), Integer.parseInt(month));
					
					Calendar cal = Calendar.getInstance();
					cal.setTime(fromDate);
					int weekOfYear = cal.get(Calendar.WEEK_OF_YEAR);
					
					toDate = addWeek(fromDate);										
					model.addAttribute("week1", headerFormatter.format(fromDate));										
					fromDate = toDate;
					toDate = addWeek(fromDate);										
					model.addAttribute("week2", headerFormatter.format(fromDate));										
					fromDate = toDate;
					toDate = addWeek(fromDate);												
					model.addAttribute("week3", headerFormatter.format(fromDate));				
					fromDate = toDate;
					toDate = addWeek(fromDate);												
					model.addAttribute("week4", headerFormatter.format(fromDate));										
					fromDate = toDate;
					toDate = addWeek(fromDate);												
					model.addAttribute("week5", headerFormatter.format(fromDate));										
					fromDate = toDate;
					toDate = addWeek(fromDate);										
					model.addAttribute("week6", headerFormatter.format(fromDate));										
					fromDate = toDate;
					toDate = addWeek(fromDate);										
					model.addAttribute("week7", headerFormatter.format(fromDate));										
					fromDate = toDate;
					toDate = addWeek(fromDate);							
					model.addAttribute("week8", headerFormatter.format(fromDate));
										
					for (EmployeeAllocation allocation : list)
					{
						weeklyAllocation = new EmployeeWeeklyAllocation();
						
						weeklyAllocation.setId((long) id++);
						weeklyAllocation.setEmployeeName(allocation.getFirstName() + " " + allocation.getLastName());
						
						Employee employee = Employee.findEmployee(allocation.getEmpId());
						if((employee != null) && (employee.getCompanySite() != null))
							weeklyAllocation.setLocation(employee.getCompanySite().getCity());
						weeklyAllocation.setProjectName(allocation.getProjectName());
												
						Long empId = allocation.getEmpId();
						Long pId = allocation.getPId();
						
						ApplicationTrace.trace("EmpId: " + empId + " Pid: " + pId);
						
						fromDate = findFirstDayOfMonth(Integer.parseInt(year), Integer.parseInt(month));
						toDate = addWeek(fromDate);						
						double allocated = EmployeeAllocation.findAllocation(fromDate, toDate, empId, pId);						
						weeklyAllocation.setWeek1(String.valueOf(allocated));
						ApplicationTrace.trace("Start: " + formatter.format(fromDate) + " End: " + formatter.format(toDate) + " Remaining: " + allocated);						
						totalEffort += allocated;
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						allocated = EmployeeAllocation.findAllocation(fromDate, toDate, empId, pId);						
						weeklyAllocation.setWeek2(String.valueOf(allocated));
						ApplicationTrace.trace("Start: " + formatter.format(fromDate) + " End: " + formatter.format(toDate) + " Remaining: " + allocated);
						totalEffort += allocated;
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						allocated = EmployeeAllocation.findAllocation(fromDate, toDate, empId, pId);							
						weeklyAllocation.setWeek3(String.valueOf(allocated));
						ApplicationTrace.trace("Start: " + formatter.format(fromDate) + " End: " + formatter.format(toDate) + " Remaining: " + allocated);
						totalEffort += allocated;
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						allocated = EmployeeAllocation.findAllocation(fromDate, toDate, empId, pId);							
						weeklyAllocation.setWeek4(String.valueOf(allocated));
						ApplicationTrace.trace("Start: " + formatter.format(fromDate) + " End: " + formatter.format(toDate) + " Remaining: " + allocated);
						totalEffort += allocated;
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						allocated = EmployeeAllocation.findAllocation(fromDate, toDate, empId, pId);							
						weeklyAllocation.setWeek5(String.valueOf(allocated));
						ApplicationTrace.trace("Start: " + formatter.format(fromDate) + " End: " + formatter.format(toDate) + " Remaining: " + allocated);
						totalEffort += allocated;
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						allocated = EmployeeAllocation.findAllocation(fromDate, toDate, empId, pId);						
						weeklyAllocation.setWeek6(String.valueOf(allocated));
						ApplicationTrace.trace("Start: " + formatter.format(fromDate) + " End: " + formatter.format(toDate) + " Remaining: " + allocated);
						totalEffort += allocated;
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						allocated = EmployeeAllocation.findAllocation(fromDate, toDate, empId, pId);						
						weeklyAllocation.setWeek7(String.valueOf(allocated));
						ApplicationTrace.trace("Start: " + formatter.format(fromDate) + " End: " + formatter.format(toDate) + " Remaining: " + allocated);
						totalEffort += allocated;
						
						fromDate = toDate;
						toDate = addWeek(fromDate);						
						allocated = EmployeeAllocation.findAllocation(fromDate, toDate, empId, pId);			
						weeklyAllocation.setWeek8(String.valueOf(allocated));
						ApplicationTrace.trace("Start: " + formatter.format(fromDate) + " End: " + formatter.format(toDate) + " Remaining: " + allocated);
						totalEffort += allocated;
						
						weeklyAllocation.setEffort(String.valueOf(totalEffort));
						collection.add(weeklyAllocation);
						totalEffort = 0;
					}					
					model.addAttribute("year", year);
					model.addAttribute("month", findMonthName(Integer.valueOf(month)) + " ");
					model.addAttribute("weekOfYear", weekOfYear);
					model.addAttribute("employeeweeklyallocations", collection);
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
	
	private Date findFirstDayOfMonth(int year, int month)
	{			
		try
		{
			Date today = null;		
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");		
			Calendar calendar = Calendar.getInstance();
			today = sdf.parse(year + "-" + month + "-01");
			calendar.setTime(today);	
			calendar.set(Calendar.WEEK_OF_MONTH, 1);
			Calendar firstDayOfYear = Calendar.getInstance();
			firstDayOfYear.setTime(sdf.parse(year + "-01-01"));
			calendar.set(Calendar.DAY_OF_WEEK, firstDayOfYear.get(Calendar.DAY_OF_WEEK));	
			Date firstDayOfMonth = calendar.getTime();
			return firstDayOfMonth;
		}
		catch (ParseException e)
		{
			ApplicationTrace.trace(e);
			return null;
		}   
	}
}
