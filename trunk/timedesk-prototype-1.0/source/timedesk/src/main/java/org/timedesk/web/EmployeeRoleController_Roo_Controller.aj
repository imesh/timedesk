// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.web;

import java.io.UnsupportedEncodingException;
import java.lang.Long;
import java.lang.String;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
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
import org.timedesk.entity.EmployeeRole;

privileged aspect EmployeeRoleController_Roo_Controller {
    
    @Autowired
    private GenericConversionService EmployeeRoleController.conversionService;
    
    @RequestMapping(method = RequestMethod.POST)
    public String EmployeeRoleController.create(@Valid EmployeeRole employeeRole, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("employeeRole", employeeRole);
            return "employeeroles/create";
        }
        employeeRole.persist();
        return "redirect:/employeeroles/" + encodeUrlPathSegment(employeeRole.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String EmployeeRoleController.createForm(Model model) {
        model.addAttribute("employeeRole", new EmployeeRole());
        return "employeeroles/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String EmployeeRoleController.show(@PathVariable("id") Long id, Model model) {
        model.addAttribute("employeerole", EmployeeRole.findEmployeeRole(id));
        model.addAttribute("itemId", id);
        return "employeeroles/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String EmployeeRoleController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("employeeroles", EmployeeRole.findEmployeeRoleEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) EmployeeRole.countEmployeeRoles() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("employeeroles", EmployeeRole.findAllEmployeeRoles());
        }
        return "employeeroles/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String EmployeeRoleController.update(@Valid EmployeeRole employeeRole, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("employeeRole", employeeRole);
            return "employeeroles/update";
        }
        employeeRole.merge();
        return "redirect:/employeeroles/" + encodeUrlPathSegment(employeeRole.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String EmployeeRoleController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("employeeRole", EmployeeRole.findEmployeeRole(id));
        return "employeeroles/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String EmployeeRoleController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        EmployeeRole.findEmployeeRole(id).remove();
        model.addAttribute("page", (page == null) ? "1" : page.toString());
        model.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/employeeroles?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    Converter<EmployeeRole, String> EmployeeRoleController.getEmployeeRoleConverter() {
        return new Converter<EmployeeRole, String>() {
            public String convert(EmployeeRole employeeRole) {
                return new StringBuilder().append(employeeRole.getEmployeeRoleId()).append(" ").append(employeeRole.getName()).toString();
            }
        };
    }
    
    @PostConstruct
    void EmployeeRoleController.registerConverters() {
        conversionService.addConverter(getEmployeeRoleConverter());
    }
    
    private String EmployeeRoleController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
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