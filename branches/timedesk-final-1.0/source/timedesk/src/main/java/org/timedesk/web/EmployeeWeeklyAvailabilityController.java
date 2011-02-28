package org.timedesk.web;

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
import org.timedesk.entity.EmployeeWeeklyAvailability;
import org.timedesk.entity.Project;
import org.timedesk.web.util.ApplicationTrace;

@RooWebScaffold(path = "employeeweeklyavailabilitys", formBackingObject = EmployeeWeeklyAvailability.class)
@RequestMapping("/employeeweeklyavailabilitys")
@Controller
public class EmployeeWeeklyAvailabilityController
{
	@RequestMapping(method = RequestMethod.POST)
	public String create(@Valid EmployeeWeeklyAvailability employeeWeeklyAvailability, BindingResult result, Model model, HttpServletRequest request, @RequestParam(value = "year", required = false) String year, @RequestParam(value = "month", required = false) String month)
	{
		ApplicationTrace.trace("Find Employee Weekly Availability");
		if ((year != null) && (month != null))
		{
			try
			{
				ApplicationTrace.trace("year: " + year + "month: " + month);
				SimpleDateFormat headerFormatter = new SimpleDateFormat("MMM d");
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
				Date startDate = formatter.parse(year + "/" + month + "/1");
				Date endDate = formatter.parse(year + "/" + (Integer.parseInt(month) + 2) + "/1");
				ApplicationTrace.trace("State date: " + formatter.format(startDate) + " End date: " + formatter.format(endDate));

				List<Project> projectList = Project.findAllProjects();
				List<Employee> list = Employee.findAllEmployees();
				if ((list != null) && (list.size() > 0))
				{
					Date fromDate = null;
					Date toDate = null;

					int id = 1;
					double totalRemaining = 0;
					EmployeeWeeklyAvailability availability = null;
					Collection<EmployeeWeeklyAvailability> collection = new ArrayList();
					
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
					
					for (Employee employee : list)
					{
						availability = new EmployeeWeeklyAvailability();
						availability.setId((long) id++);
						availability.setEmployeeName(employee.getFirstName() + " " + employee.getLastName());
						if (employee.getCompanySite() != null)
							availability.setLocation(employee.getCompanySite().getCity());

						fromDate = findFirstDayOfMonth(Integer.parseInt(year), Integer.parseInt(month));
						toDate = addWeek(fromDate);
						double remaining = employee.findAvailability(fromDate, toDate);
						availability.setWeek1(String.valueOf(remaining));
						totalRemaining += remaining;

						fromDate = toDate;
						toDate = addWeek(fromDate);
						remaining = employee.findAvailability(fromDate, toDate);
						availability.setWeek2(String.valueOf(remaining));
						totalRemaining += remaining;

						fromDate = toDate;
						toDate = addWeek(fromDate);
						remaining = employee.findAvailability(fromDate, toDate);
						availability.setWeek3(String.valueOf(remaining));
						totalRemaining += remaining;

						fromDate = toDate;
						toDate = addWeek(fromDate);
						remaining = employee.findAvailability(fromDate, toDate);
						availability.setWeek4(String.valueOf(remaining));
						totalRemaining += remaining;

						fromDate = toDate;
						toDate = addWeek(fromDate);
						remaining = employee.findAvailability(fromDate, toDate);
						availability.setWeek5(String.valueOf(remaining));
						totalRemaining += remaining;

						fromDate = toDate;
						toDate = addWeek(fromDate);
						remaining = employee.findAvailability(fromDate, toDate);
						availability.setWeek6(String.valueOf(remaining));
						totalRemaining += remaining;

						fromDate = toDate;
						toDate = addWeek(fromDate);
						remaining = employee.findAvailability(fromDate, toDate);
						availability.setWeek7(String.valueOf(remaining));
						totalRemaining += remaining;

						fromDate = toDate;
						toDate = addWeek(fromDate);
						remaining = employee.findAvailability(fromDate, toDate);
						availability.setWeek8(String.valueOf(remaining));
						totalRemaining += remaining;

						availability.setEffort(String.valueOf(totalRemaining));
						collection.add(availability);
					}
					model.addAttribute("year", year);
					model.addAttribute("month", findMonthName(Integer.valueOf(month)) + " ");
					model.addAttribute("weekOfYear", weekOfYear);
					model.addAttribute("employeeweeklyavailabilitys", collection);
				}
			}
			catch (ParseException e)
			{
				ApplicationTrace.trace(e);
			}
		}
		return "employeeweeklyavailabilitys/create";
	}

	@RequestMapping(params = "form", method = RequestMethod.GET)
	public String createForm(Model model)
	{
		model.addAttribute("employeeWeeklyAvailability", new EmployeeWeeklyAvailability());
		return "employeeweeklyavailabilitys/create";
	}

	@RequestMapping(method = RequestMethod.GET)
	public String list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model)
	{
		model.addAttribute("employeeWeeklyAvailability", new EmployeeWeeklyAvailability());
		return "employeeweeklyavailabilitys/create";
	}

	private Object findMonthName(int month)
	{
		if (month == 1)
			return "January";
		else if (month == 2)
			return "February";
		else if (month == 3)
			return "March";
		else if (month == 4)
			return "April";
		else if (month == 5)
			return "May";
		else if (month == 6)
			return "June";
		else if (month == 7)
			return "July";
		else if (month == 8)
			return "August";
		else if (month == 9)
			return "September";
		else if (month == 10)
			return "October";
		else if (month == 11)
			return "November";
		else if (month == 12)
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
