package org.timedesk.web;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.timedesk.entity.Employee;
import org.timedesk.entity.SecurityRole;
import org.timedesk.entity.User;

@RooWebScaffold(path = "users", formBackingObject = User.class)
@RequestMapping("/users")
@Controller
public class UserController
{
	@Autowired
	private GenericConversionService conversionService;

	@RequestMapping(value = "/userprofile", method = RequestMethod.GET)
	public String show(Model model)
	{
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		model.addAttribute("user", User.findUser(username));
		model.addAttribute("itemId", username);
		return "users/show";
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String show(@PathVariable("id") String id, Model model)
	{
		if (isNumber(id))
		{
			Long numberValue = Long.valueOf(id);
			model.addAttribute("user", User.findUser(numberValue));
			model.addAttribute("itemId", id);
			return "users/show";
		}
		else
		{
			model.addAttribute("user", User.findUser(id));
			model.addAttribute("itemId", id);
			return "users/show";
		}
	}

	Converter<User, String> getUserConverter()
	{
		return new Converter<User, String>()
		{
			public String convert(User user)
			{
				return new StringBuilder().append(user.getUsername()).toString();
			}
		};
	}

	Converter<Employee, String> getEmployeeConverter()
	{
		return new Converter<Employee, String>()
		{
			public String convert(Employee employee)
			{
				return new StringBuilder().append(employee.getEmployeeId()).append(" ").append(employee.getFirstName()).append(" ").append(employee.getLastName()).toString();
			}
		};
	}

	Converter<SecurityRole, String> getSecurityRoleConverter()
	{
		return new Converter<SecurityRole, String>()
		{
			public String convert(SecurityRole securityRole)
			{
				return new StringBuilder().append(securityRole.getSecurityRoleId()).append(" ").append(securityRole.getName()).toString();
			}
		};
	}

	@PostConstruct
	void registerConverters()
	{
		conversionService.addConverter(getUserConverter());
		conversionService.addConverter(getEmployeeConverter());
		conversionService.addConverter(getSecurityRoleConverter());
	}

	private boolean isNumber(String value)
	{
		try
		{
			Integer.parseInt(value);
			return true;
		}
		catch (NumberFormatException e)
		{
			return false;
		}
	}
}
