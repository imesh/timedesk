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

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.timedesk.entity.Company;
import org.timedesk.entity.CompanySite;
import org.timedesk.entity.Project;
import org.timedesk.web.util.ErrorHandler;
import org.timedesk.web.util.UrlEncoder;

@RooWebScaffold(path = "companies", formBackingObject = Company.class)
@RequestMapping("/companies")
@Controller
public class CompanyController
{
	@Autowired
	private GenericConversionService conversionService_;
	
	@RequestMapping(method = RequestMethod.POST)
	public String create(@Valid Company company, BindingResult result, Model model, HttpServletRequest request)
	{
		try
		{
			if (!result.hasErrors())
			{
				company.persist();
				return "redirect:/companies/" + UrlEncoder.encodeUrlPathSegment(company.getId().toString(), request);
			}
		}
		catch (Exception e)
		{
			ErrorHandler.addError(company, result, e);
		}
		model.addAttribute("company", company);
		return "companies/create";
	}

	Converter<Company, String> getCompanyConverter()
	{
		return new Converter<Company, String>()
		{
			public String convert(Company company)
			{
				return new StringBuilder().append(company.getName()).toString();
			}
		};
	}

	Converter<CompanySite, String> getCompanySiteConverter()
	{
		return new Converter<CompanySite, String>()
		{
			public String convert(CompanySite companySite)
			{
				return new StringBuilder().append(companySite.getSiteId()).append(" ").append(companySite.getLocation()).append(" ").append(companySite.getCity()).toString();
			}
		};
	}

	Converter<Project, String> getProjectConverter()
	{
		return new Converter<Project, String>()
		{
			public String convert(Project project)
			{
				return new StringBuilder().append(project.getProjectId()).append(" ").append(project.getName()).append(" ").append(project.getDescription()).toString();
			}
		};
	}
	
	@PostConstruct
	void registerConverters()
	{
		conversionService_.addConverter(getCompanyConverter());
		conversionService_.addConverter(getCompanySiteConverter());
		conversionService_.addConverter(getProjectConverter());
	}
}
