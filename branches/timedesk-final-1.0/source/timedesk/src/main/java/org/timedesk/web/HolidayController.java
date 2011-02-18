package org.timedesk.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.CompanySite;
import org.timedesk.entity.Holiday;
import org.timedesk.web.util.UrlEncoder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "holidays", formBackingObject = Holiday.class)
@RequestMapping("/holidays")
@Controller
public class HolidayController 
{
	@RequestMapping(method = RequestMethod.POST)
    public String create(@Valid Holiday holiday, BindingResult result, Model model, HttpServletRequest request) 
    {
        if (result.hasErrors()) 
        {
            model.addAttribute("holiday", holiday);
            addDateTimeFormatPatterns(model);
            return "holidays/create";
        }
        holiday.persist();
        return "redirect:/companysites/" + UrlEncoder.encodeUrlPathSegment(holiday.getCompanySite().getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String createForm(Model model, @RequestParam(value = "parentId", required = false) Long parentId) 
    {
    	CompanySite companySite = null;
    	Holiday holiday = new Holiday();
    	if(parentId != null)
    	{
    		companySite = CompanySite.findCompanySite(parentId);
    		if(companySite != null)
    			holiday.setCompanySite(companySite);
    	}
        model.addAttribute("holiday", holiday);
        addDateTimeFormatPatterns(model);
        List dependencies = new ArrayList();
        if (CompanySite.countCompanySites() == 0) 
        {
            dependencies.add(new String[]{"companySite", "companysites"});
        }
        model.addAttribute("dependencies", dependencies);
        return "holidays/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) 
    {
    	Holiday holiday = Holiday.findHoliday(id);
    	String companySiteId = holiday.getCompanySite().getId().toString();
        holiday.remove();        
        return "redirect:/companysites/" + companySiteId;
    }
}
