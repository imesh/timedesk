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
import org.springframework.web.bind.annotation.PathVariable;
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
		Company company = null;
		CompanySite site = new CompanySite();
		if(parentId != null)
		{
			company = Company.findCompany(parentId);
			if(company != null)
				site.setCompany(company);
		}
        model.addAttribute("companySite", site);
        List dependencies = new ArrayList();
        if (Company.countCompanys() == 0) 
        {
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
        return "redirect:/companies/" + UrlEncoder.encodeUrlPathSegment(companySite.getCompany().getId().toString(), request);
    }
	
	@RequestMapping(method = RequestMethod.PUT)
    public String update(@Valid CompanySite companySite, BindingResult result, Model model, HttpServletRequest request) 
	{
        if (result.hasErrors()) 
        {
            model.addAttribute("companySite", companySite);
            return "companysites/update";
        }
        companySite.merge();
        return "redirect:/companies/" + UrlEncoder.encodeUrlPathSegment(companySite.getCompany().getId().toString(), request);
    }
	
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) 
    {
		CompanySite companySite = CompanySite.findCompanySite(id);
		String companyId = companySite.getCompany().getId().toString();		
		companySite.remove();
        return "redirect:/companies/" + companyId;
    }
}
