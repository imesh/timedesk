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
import org.timedesk.entity.Employee;
import org.timedesk.entity.Feedback;
import org.timedesk.entity.ProjectMember;
import org.timedesk.entity.ProjectMemberRole;

privileged aspect ProjectMemberController_Roo_Controller {
    
    @Autowired
    private GenericConversionService ProjectMemberController.conversionService;
    
    @RequestMapping(method = RequestMethod.POST)
    public String ProjectMemberController.create(@Valid ProjectMember projectMember, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("projectMember", projectMember);
            return "projectmembers/create";
        }
        projectMember.persist();
        return "redirect:/projectmembers/" + encodeUrlPathSegment(projectMember.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String ProjectMemberController.createForm(Model model) {
        model.addAttribute("projectMember", new ProjectMember());
        return "projectmembers/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String ProjectMemberController.show(@PathVariable("id") Long id, Model model) {
        model.addAttribute("projectmember", ProjectMember.findProjectMember(id));
        model.addAttribute("itemId", id);
        return "projectmembers/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String ProjectMemberController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("projectmembers", ProjectMember.findProjectMemberEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) ProjectMember.countProjectMembers() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("projectmembers", ProjectMember.findAllProjectMembers());
        }
        return "projectmembers/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String ProjectMemberController.update(@Valid ProjectMember projectMember, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("projectMember", projectMember);
            return "projectmembers/update";
        }
        projectMember.merge();
        return "redirect:/projectmembers/" + encodeUrlPathSegment(projectMember.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String ProjectMemberController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("projectMember", ProjectMember.findProjectMember(id));
        return "projectmembers/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String ProjectMemberController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        ProjectMember.findProjectMember(id).remove();
        model.addAttribute("page", (page == null) ? "1" : page.toString());
        model.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/projectmembers?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    @ModelAttribute("employees")
    public Collection<Employee> ProjectMemberController.populateEmployees() {
        return Employee.findAllEmployees();
    }
    
    @ModelAttribute("feedbacks")
    public Collection<Feedback> ProjectMemberController.populateFeedbacks() {
        return Feedback.findAllFeedbacks();
    }
    
    @ModelAttribute("projectmemberroles")
    public Collection<ProjectMemberRole> ProjectMemberController.populateProjectMemberRoles() {
        return ProjectMemberRole.findAllProjectMemberRoles();
    }
    
    Converter<Employee, String> ProjectMemberController.getEmployeeConverter() {
        return new Converter<Employee, String>() {
            public String convert(Employee employee) {
                return new StringBuilder().append(employee.getEmployeeId()).append(" ").append(employee.getFirstName()).append(" ").append(employee.getLastName()).toString();
            }
        };
    }
    
    Converter<Feedback, String> ProjectMemberController.getFeedbackConverter() {
        return new Converter<Feedback, String>() {
            public String convert(Feedback feedback) {
                return new StringBuilder().append(feedback.getFeedbackId()).append(" ").append(feedback.getDescription()).toString();
            }
        };
    }
    
    Converter<ProjectMember, String> ProjectMemberController.getProjectMemberConverter() {
        return new Converter<ProjectMember, String>() {
            public String convert(ProjectMember projectMember) {
                return new StringBuilder().append(projectMember.getMemberId()).toString();
            }
        };
    }
    
    Converter<ProjectMemberRole, String> ProjectMemberController.getProjectMemberRoleConverter() {
        return new Converter<ProjectMemberRole, String>() {
            public String convert(ProjectMemberRole projectMemberRole) {
                return new StringBuilder().append(projectMemberRole.getRoleId()).append(" ").append(projectMemberRole.getName()).toString();
            }
        };
    }
    
    @PostConstruct
    void ProjectMemberController.registerConverters() {
        conversionService.addConverter(getEmployeeConverter());
        conversionService.addConverter(getFeedbackConverter());
        conversionService.addConverter(getProjectMemberConverter());
        conversionService.addConverter(getProjectMemberRoleConverter());
    }
    
    private String ProjectMemberController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
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
