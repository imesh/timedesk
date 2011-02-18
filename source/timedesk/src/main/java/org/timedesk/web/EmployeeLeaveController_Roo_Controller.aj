// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.web;

import java.io.UnsupportedEncodingException;
import java.lang.Long;
import java.lang.String;
import java.util.Collection;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import org.joda.time.format.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;
import org.timedesk.entity.Employee;
import org.timedesk.entity.EmployeeLeave;

privileged aspect EmployeeLeaveController_Roo_Controller {
    
    @Autowired
    private GenericConversionService EmployeeLeaveController.conversionService;
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String EmployeeLeaveController.show(@PathVariable("id") Long id, Model model) {
        addDateTimeFormatPatterns(model);
        model.addAttribute("employeeleave", EmployeeLeave.findEmployeeLeave(id));
        model.addAttribute("itemId", id);
        return "employeeleaves/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String EmployeeLeaveController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("employeeleaves", EmployeeLeave.findEmployeeLeaveEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) EmployeeLeave.countEmployeeLeaves() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("employeeleaves", EmployeeLeave.findAllEmployeeLeaves());
        }
        addDateTimeFormatPatterns(model);
        return "employeeleaves/list";
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String EmployeeLeaveController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("employeeLeave", EmployeeLeave.findEmployeeLeave(id));
        addDateTimeFormatPatterns(model);
        return "employeeleaves/update";
    }
    
    @ModelAttribute("employees")
    public Collection<Employee> EmployeeLeaveController.populateEmployees() {
        return Employee.findAllEmployees();
    }
    
    Converter<Employee, String> EmployeeLeaveController.getEmployeeConverter() {
        return new Converter<Employee, String>() {
            public String convert(Employee employee) {
                return new StringBuilder().append(employee.getEmployeeId()).append(" ").append(employee.getFirstName()).append(" ").append(employee.getLastName()).toString();
            }
        };
    }
    
    Converter<EmployeeLeave, String> EmployeeLeaveController.getEmployeeLeaveConverter() {
        return new Converter<EmployeeLeave, String>() {
            public String convert(EmployeeLeave employeeLeave) {
                return new StringBuilder().append(employeeLeave.getFromTime()).append(" ").append(employeeLeave.getToTime()).toString();
            }
        };
    }
    
    @PostConstruct
    void EmployeeLeaveController.registerConverters() {
        conversionService.addConverter(getEmployeeConverter());
        conversionService.addConverter(getEmployeeLeaveConverter());
    }
    
    void EmployeeLeaveController.addDateTimeFormatPatterns(Model model) {
        model.addAttribute("employeeLeave_fromtime_date_format", DateTimeFormat.patternForStyle("MS", LocaleContextHolder.getLocale()));
        model.addAttribute("employeeLeave_totime_date_format", DateTimeFormat.patternForStyle("MS", LocaleContextHolder.getLocale()));
    }
    
    private String EmployeeLeaveController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
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
