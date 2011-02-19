// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.web;

import java.io.UnsupportedEncodingException;
import java.lang.Long;
import java.lang.String;
import java.util.Arrays;
import java.util.Collection;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
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
import org.timedesk.entity.CompanySite;
import org.timedesk.entity.CountryEnum;
import org.timedesk.entity.Employee;
import org.timedesk.entity.EmployeeLeave;
import org.timedesk.entity.EmployeeRole;
import org.timedesk.entity.EmployeeVisa;
import org.timedesk.entity.Skill;
import org.timedesk.entity.User;

privileged aspect EmployeeController_Roo_Controller {
    
    @Autowired
    private GenericConversionService EmployeeController.conversionService;
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String EmployeeController.show(@PathVariable("id") Long id, Model model) {
        model.addAttribute("employee", Employee.findEmployee(id));
        model.addAttribute("itemId", id);
        return "employees/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String EmployeeController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("employees", Employee.findEmployeeEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Employee.countEmployees() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("employees", Employee.findAllEmployees());
        }
        return "employees/list";
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String EmployeeController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("employee", Employee.findEmployee(id));
        return "employees/update";
    }
    
    @ModelAttribute("companysites")
    public Collection<CompanySite> EmployeeController.populateCompanySites() {
        return CompanySite.findAllCompanySites();
    }
    
    @ModelAttribute("countryenums")
    public Collection<CountryEnum> EmployeeController.populateCountryEnums() {
        return Arrays.asList(CountryEnum.class.getEnumConstants());
    }
    
    @ModelAttribute("employeeleaves")
    public Collection<EmployeeLeave> EmployeeController.populateEmployeeLeaves() {
        return EmployeeLeave.findAllEmployeeLeaves();
    }
    
    @ModelAttribute("employeeroles")
    public Collection<EmployeeRole> EmployeeController.populateEmployeeRoles() {
        return EmployeeRole.findAllEmployeeRoles();
    }
    
    @ModelAttribute("employeevisas")
    public Collection<EmployeeVisa> EmployeeController.populateEmployeeVisas() {
        return EmployeeVisa.findAllEmployeeVisas();
    }
    
    @ModelAttribute("skills")
    public Collection<Skill> EmployeeController.populateSkills() {
        return Skill.findAllSkills();
    }
    
    @ModelAttribute("users")
    public Collection<User> EmployeeController.populateUsers() {
        return User.findAllUsers();
    }
    
    Converter<CompanySite, String> EmployeeController.getCompanySiteConverter() {
        return new Converter<CompanySite, String>() {
            public String convert(CompanySite companySite) {
                return new StringBuilder().append(companySite.getSiteId()).append(" ").append(companySite.getLocation()).append(" ").append(companySite.getCity()).toString();
            }
        };
    }
    
    Converter<Employee, String> EmployeeController.getEmployeeConverter() {
        return new Converter<Employee, String>() {
            public String convert(Employee employee) {
                return new StringBuilder().append(employee.getEmployeeId()).append(" ").append(employee.getFirstName()).append(" ").append(employee.getLastName()).toString();
            }
        };
    }
    
    Converter<EmployeeLeave, String> EmployeeController.getEmployeeLeaveConverter() {
        return new Converter<EmployeeLeave, String>() {
            public String convert(EmployeeLeave employeeLeave) {
                return new StringBuilder().append(employeeLeave.getFromTime()).append(" ").append(employeeLeave.getToTime()).toString();
            }
        };
    }
    
    Converter<EmployeeRole, String> EmployeeController.getEmployeeRoleConverter() {
        return new Converter<EmployeeRole, String>() {
            public String convert(EmployeeRole employeeRole) {
                return new StringBuilder().append(employeeRole.getRoleId()).append(" ").append(employeeRole.getName()).toString();
            }
        };
    }
    
    Converter<EmployeeVisa, String> EmployeeController.getEmployeeVisaConverter() {
        return new Converter<EmployeeVisa, String>() {
            public String convert(EmployeeVisa employeeVisa) {
                return new StringBuilder().append(employeeVisa.getVisaId()).append(" ").append(employeeVisa.getValidFrom()).append(" ").append(employeeVisa.getValidTo()).toString();
            }
        };
    }
    
    Converter<Skill, String> EmployeeController.getSkillConverter() {
        return new Converter<Skill, String>() {
            public String convert(Skill skill) {
                return new StringBuilder().append(skill.getSkillId()).append(" ").append(skill.getDescription()).toString();
            }
        };
    }
            
    @PostConstruct
    void EmployeeController.registerConverters() {
        conversionService.addConverter(getCompanySiteConverter());
        conversionService.addConverter(getEmployeeConverter());
        conversionService.addConverter(getEmployeeLeaveConverter());
        conversionService.addConverter(getEmployeeRoleConverter());
        conversionService.addConverter(getEmployeeVisaConverter());
        conversionService.addConverter(getSkillConverter());
        conversionService.addConverter(getUserConverter());
    }
    
    private String EmployeeController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
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
