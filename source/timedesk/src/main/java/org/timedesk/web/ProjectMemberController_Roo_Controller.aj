// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.web;

import java.io.UnsupportedEncodingException;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;
import org.timedesk.entity.Employee;
import org.timedesk.entity.Project;
import org.timedesk.entity.ProjectMember;
import org.timedesk.entity.ProjectMemberFeedback;
import org.timedesk.entity.ProjectMemberRole;

privileged aspect ProjectMemberController_Roo_Controller {
    
    
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
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String ProjectMemberController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("projectMember", ProjectMember.findProjectMember(id));
        return "projectmembers/update";
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
    
    @ModelAttribute("employees")
    public Collection<Employee> ProjectMemberController.populateEmployees() {
        return Employee.findAllEmployees();
    }
    
    @ModelAttribute("projects")
    public Collection<Project> ProjectMemberController.populateProjects() {
        return Project.findAllProjects();
    }
    
    @ModelAttribute("projectmemberfeedbacks")
    public Collection<ProjectMemberFeedback> ProjectMemberController.populateProjectMemberFeedbacks() {
        return ProjectMemberFeedback.findAllProjectMemberFeedbacks();
    }
    
    @ModelAttribute("projectmemberroles")
    public Collection<ProjectMemberRole> ProjectMemberController.populateProjectMemberRoles() {
        return ProjectMemberRole.findAllProjectMemberRoles();
    }
    
}
