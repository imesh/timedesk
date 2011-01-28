// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.web;

import java.io.UnsupportedEncodingException;
import java.lang.Long;
import java.lang.String;
import java.util.Collection;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;
import org.timedesk.entity.Company;
import org.timedesk.entity.Project;
import org.timedesk.entity.Site;

privileged aspect CompanyController_Roo_Controller {
    
    @Autowired
    private GenericConversionService CompanyController.conversionService;
    
    @RequestMapping(method = RequestMethod.POST)
    public String CompanyController.create(@Valid Company company, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("company", company);
            return "companies/create";
        }
        company.persist();
        return "redirect:/companies/" + encodeUrlPathSegment(company.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String CompanyController.createForm(Model model) {
        model.addAttribute("company", new Company());
        return "companies/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String CompanyController.show(@PathVariable("id") Long id, Model model) {
        model.addAttribute("company", Company.findCompany(id));
        model.addAttribute("itemId", id);
        return "companies/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String CompanyController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("companys", Company.findCompanyEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Company.countCompanys() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("companys", Company.findAllCompanys());
        }
        return "companies/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String CompanyController.update(@Valid Company company, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("company", company);
            return "companies/update";
        }
        company.merge();
        return "redirect:/companies/" + encodeUrlPathSegment(company.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String CompanyController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("company", Company.findCompany(id));
        return "companies/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String CompanyController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        Company.findCompany(id).remove();
        model.addAttribute("page", (page == null) ? "1" : page.toString());
        model.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/companies?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    @ModelAttribute("projects")
    public Collection<Project> CompanyController.populateProjects() {
        return Project.findAllProjects();
    }
    
    @ModelAttribute("sites")
    public Collection<Site> CompanyController.populateSites() {
        return Site.findAllSites();
    }
    
    Converter<Company, String> CompanyController.getCompanyConverter() {
        return new Converter<Company, String>() {
            public String convert(Company company) {
                return new StringBuilder().append(company.getCompanyId()).append(" ").append(company.getName()).toString();
            }
        };
    }
    
    Converter<Project, String> CompanyController.getProjectConverter() {
        return new Converter<Project, String>() {
            public String convert(Project project) {
                return new StringBuilder().append(project.getProjectId()).append(" ").append(project.getName()).append(" ").append(project.getDescription()).toString();
            }
        };
    }
    
    Converter<Site, String> CompanyController.getSiteConverter() {
        return new Converter<Site, String>() {
            public String convert(Site site) {
                return new StringBuilder().append(site.getSiteId()).append(" ").append(site.getLocation()).append(" ").append(site.getCity()).toString();
            }
        };
    }
    
    @PostConstruct
    void CompanyController.registerConverters() {
        conversionService.addConverter(getCompanyConverter());
        conversionService.addConverter(getProjectConverter());
        conversionService.addConverter(getSiteConverter());
    }
    
    private String CompanyController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
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
