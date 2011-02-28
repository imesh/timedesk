// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.web;

import java.io.UnsupportedEncodingException;
import java.lang.Long;
import java.lang.String;
import java.util.Arrays;
import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;
import org.timedesk.entity.Company;
import org.timedesk.entity.CompanySite;
import org.timedesk.entity.CountryEnum;
import org.timedesk.entity.Employee;
import org.timedesk.entity.Holiday;

privileged aspect CompanySiteController_Roo_Controller {
    
    @Autowired
    private GenericConversionService CompanySiteController.conversionService;
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String CompanySiteController.show(@PathVariable("id") Long id, Model model) {
        model.addAttribute("companysite", CompanySite.findCompanySite(id));
        model.addAttribute("itemId", id);
        return "companysites/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String CompanySiteController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("companysites", CompanySite.findCompanySiteEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) CompanySite.countCompanySites() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("companysites", CompanySite.findAllCompanySites());
        }
        return "companysites/list";
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String CompanySiteController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("companySite", CompanySite.findCompanySite(id));
        return "companysites/update";
    }
    
    @ModelAttribute("companys")
    public Collection<Company> CompanySiteController.populateCompanys() {
        return Company.findAllCompanys();
    }
    
    @ModelAttribute("countryenums")
    public Collection<CountryEnum> CompanySiteController.populateCountryEnums() {
        return Arrays.asList(CountryEnum.class.getEnumConstants());
    }
    
    @ModelAttribute("employees")
    public Collection<Employee> CompanySiteController.populateEmployees() {
        return Employee.findAllEmployees();
    }
    
    @ModelAttribute("holidays")
    public Collection<Holiday> CompanySiteController.populateHolidays() {
        return Holiday.findAllHolidays();
    }
    
    private String CompanySiteController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
        String enc = request.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        }
        catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
