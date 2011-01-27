// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.web;

import java.io.UnsupportedEncodingException;
import java.lang.Long;
import java.lang.String;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.joda.time.format.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;
import org.timedesk.entity.EmployeeVisa;

privileged aspect EmployeeVisaController_Roo_Controller {
    
    @Autowired
    private GenericConversionService EmployeeVisaController.conversionService;
    
    @RequestMapping(method = RequestMethod.POST)
    public String EmployeeVisaController.create(@Valid EmployeeVisa employeeVisa, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("employeeVisa", employeeVisa);
            addDateTimeFormatPatterns(model);
            return "employeevisas/create";
        }
        employeeVisa.persist();
        return "redirect:/employeevisas/" + encodeUrlPathSegment(employeeVisa.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String EmployeeVisaController.createForm(Model model) {
        model.addAttribute("employeeVisa", new EmployeeVisa());
        addDateTimeFormatPatterns(model);
        return "employeevisas/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String EmployeeVisaController.show(@PathVariable("id") Long id, Model model) {
        addDateTimeFormatPatterns(model);
        model.addAttribute("employeevisa", EmployeeVisa.findEmployeeVisa(id));
        model.addAttribute("itemId", id);
        return "employeevisas/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String EmployeeVisaController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("employeevisas", EmployeeVisa.findEmployeeVisaEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) EmployeeVisa.countEmployeeVisas() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("employeevisas", EmployeeVisa.findAllEmployeeVisas());
        }
        addDateTimeFormatPatterns(model);
        return "employeevisas/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String EmployeeVisaController.update(@Valid EmployeeVisa employeeVisa, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("employeeVisa", employeeVisa);
            addDateTimeFormatPatterns(model);
            return "employeevisas/update";
        }
        employeeVisa.merge();
        return "redirect:/employeevisas/" + encodeUrlPathSegment(employeeVisa.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String EmployeeVisaController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("employeeVisa", EmployeeVisa.findEmployeeVisa(id));
        addDateTimeFormatPatterns(model);
        return "employeevisas/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String EmployeeVisaController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        EmployeeVisa.findEmployeeVisa(id).remove();
        model.addAttribute("page", (page == null) ? "1" : page.toString());
        model.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/employeevisas?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    Converter<EmployeeVisa, String> EmployeeVisaController.getEmployeeVisaConverter() {
        return new Converter<EmployeeVisa, String>() {
            public String convert(EmployeeVisa employeeVisa) {
                return new StringBuilder().append(employeeVisa.getEmployeeVisaId()).append(" ").append(employeeVisa.getValidFrom()).append(" ").append(employeeVisa.getValidTo()).toString();
            }
        };
    }
    
    @PostConstruct
    void EmployeeVisaController.registerConverters() {
        conversionService.addConverter(getEmployeeVisaConverter());
    }
    
    void EmployeeVisaController.addDateTimeFormatPatterns(Model model) {
        model.addAttribute("employeeVisa_validto_date_format", DateTimeFormat.patternForStyle("S-", LocaleContextHolder.getLocale()));
        model.addAttribute("employeeVisa_validfrom_date_format", DateTimeFormat.patternForStyle("S-", LocaleContextHolder.getLocale()));
    }
    
    private String EmployeeVisaController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
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