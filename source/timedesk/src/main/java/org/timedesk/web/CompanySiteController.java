package org.timedesk.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.Company;
import org.timedesk.entity.CompanySite;
import org.timedesk.web.util.ErrorHandler;
import org.timedesk.web.util.UrlEncoder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "companysites", formBackingObject = CompanySite.class)
@RequestMapping("/companysites")
@Controller
public class CompanySiteController 
{
	@RequestMapping(params = "form", method = RequestMethod.GET)
    public String createForm(Model model, @RequestParam(value = "parentId", required = false) Long parentId) 
    {
		CompanySite site = new CompanySite();
		if(parentId != null)
		{
			Company company = Company.findCompany(parentId);
			if(company != null)
				site.setCompany(company);
		}
        model.addAttribute("companySite", site);
        List dependencies = new ArrayList();
        if (Company.countCompanys() == 0) {
            dependencies.add(new String[]{"company", "companys"});
        }
        model.addAttribute("dependencies", dependencies);
        return "companysites/create";
    }
	
	@RequestMapping(method = RequestMethod.POST)
    public String create(@Valid CompanySite companySite, BindingResult result, Model model, HttpServletRequest request) 
    {
        try
        {
        	if (!result.hasErrors()) 
        	{
        		companySite.persist();
        		return "redirect:/companysites/" + UrlEncoder.encodeUrlPathSegment(companySite.getId().toString(), request);
        	}
        }
        catch(Exception e)
        {
        	ErrorHandler.addError(companySite, result, e);        	
        }
        model.addAttribute("companySite", companySite);
        return "companysites/create";
    }
}
