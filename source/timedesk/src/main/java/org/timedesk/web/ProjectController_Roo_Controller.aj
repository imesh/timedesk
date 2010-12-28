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
import org.joda.time.format.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
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
import org.timedesk.entity.Project;
import org.timedesk.entity.ProjectMember;

privileged aspect ProjectController_Roo_Controller {
    
    @Autowired
    private GenericConversionService ProjectController.conversionService;
    
    @RequestMapping(method = RequestMethod.POST)
    public String ProjectController.create(@Valid Project project, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("project", project);
            addDateTimeFormatPatterns(model);
            return "projects/create";
        }
        project.persist();
        return "redirect:/projects/" + encodeUrlPathSegment(project.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String ProjectController.createForm(Model model) {
        model.addAttribute("project", new Project());
        addDateTimeFormatPatterns(model);
        return "projects/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String ProjectController.show(@PathVariable("id") Long id, Model model) {
        addDateTimeFormatPatterns(model);
        model.addAttribute("project", Project.findProject(id));
        model.addAttribute("itemId", id);
        return "projects/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String ProjectController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("projects", Project.findProjectEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Project.countProjects() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("projects", Project.findAllProjects());
        }
        addDateTimeFormatPatterns(model);
        return "projects/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String ProjectController.update(@Valid Project project, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("project", project);
            addDateTimeFormatPatterns(model);
            return "projects/update";
        }
        project.merge();
        return "redirect:/projects/" + encodeUrlPathSegment(project.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String ProjectController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("project", Project.findProject(id));
        addDateTimeFormatPatterns(model);
        return "projects/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String ProjectController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        Project.findProject(id).remove();
        model.addAttribute("page", (page == null) ? "1" : page.toString());
        model.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/projects?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    @ModelAttribute("projectmembers")
    public Collection<ProjectMember> ProjectController.populateProjectMembers() {
        return ProjectMember.findAllProjectMembers();
    }
    
    Converter<Project, String> ProjectController.getProjectConverter() {
        return new Converter<Project, String>() {
            public String convert(Project project) {
                return new StringBuilder().append(project.getProjectId()).append(" ").append(project.getName()).append(" ").append(project.getDescription()).toString();
            }
        };
    }
    
    Converter<ProjectMember, String> ProjectController.getProjectMemberConverter() {
        return new Converter<ProjectMember, String>() {
            public String convert(ProjectMember projectMember) {
                return new StringBuilder().append(projectMember.getMemberId()).append(" ").append(projectMember.getAllocation()).append(" ").append(projectMember.getStartDate()).toString();
            }
        };
    }
    
    @PostConstruct
    void ProjectController.registerConverters() {
        conversionService.addConverter(getProjectConverter());
        conversionService.addConverter(getProjectMemberConverter());
    }
    
    void ProjectController.addDateTimeFormatPatterns(Model model) {
        model.addAttribute("project_startdate_date_format", DateTimeFormat.patternForStyle("S-", LocaleContextHolder.getLocale()));
        model.addAttribute("project_enddate_date_format", DateTimeFormat.patternForStyle("S-", LocaleContextHolder.getLocale()));
    }
    
    private String ProjectController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
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