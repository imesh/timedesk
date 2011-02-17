// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.web;

import java.io.UnsupportedEncodingException;
import java.lang.Long;
import java.lang.String;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
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
import org.timedesk.entity.ProjectPhase;
import org.timedesk.entity.ProjectPhaseMember;

privileged aspect ProjectPhaseController_Roo_Controller {
    
    @Autowired
    private GenericConversionService ProjectPhaseController.conversionService;
    
    @RequestMapping(method = RequestMethod.POST)
    public String ProjectPhaseController.create(@Valid ProjectPhase projectPhase, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("projectPhase", projectPhase);
            addDateTimeFormatPatterns(model);
            return "projectphases/create";
        }
        projectPhase.persist();
        return "redirect:/projectphases/" + encodeUrlPathSegment(projectPhase.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String ProjectPhaseController.createForm(Model model) {
        model.addAttribute("projectPhase", new ProjectPhase());
        addDateTimeFormatPatterns(model);
        List dependencies = new ArrayList();
        if (Project.countProjects() == 0) {
            dependencies.add(new String[]{"project", "projects"});
        }
        model.addAttribute("dependencies", dependencies);
        return "projectphases/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String ProjectPhaseController.show(@PathVariable("id") Long id, Model model) {
        addDateTimeFormatPatterns(model);
        model.addAttribute("projectphase", ProjectPhase.findProjectPhase(id));
        model.addAttribute("itemId", id);
        return "projectphases/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String ProjectPhaseController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("projectphases", ProjectPhase.findProjectPhaseEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) ProjectPhase.countProjectPhases() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("projectphases", ProjectPhase.findAllProjectPhases());
        }
        addDateTimeFormatPatterns(model);
        return "projectphases/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String ProjectPhaseController.update(@Valid ProjectPhase projectPhase, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("projectPhase", projectPhase);
            addDateTimeFormatPatterns(model);
            return "projectphases/update";
        }
        projectPhase.merge();
        return "redirect:/projectphases/" + encodeUrlPathSegment(projectPhase.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String ProjectPhaseController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("projectPhase", ProjectPhase.findProjectPhase(id));
        addDateTimeFormatPatterns(model);
        return "projectphases/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String ProjectPhaseController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        ProjectPhase.findProjectPhase(id).remove();
        model.addAttribute("page", (page == null) ? "1" : page.toString());
        model.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/projectphases?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    @ModelAttribute("projects")
    public Collection<Project> ProjectPhaseController.populateProjects() {
        return Project.findAllProjects();
    }
    
    @ModelAttribute("projectphasemembers")
    public Collection<ProjectPhaseMember> ProjectPhaseController.populateProjectPhaseMembers() {
        return ProjectPhaseMember.findAllProjectPhaseMembers();
    }
    
    Converter<Project, String> ProjectPhaseController.getProjectConverter() {
        return new Converter<Project, String>() {
            public String convert(Project project) {
                return new StringBuilder().append(project.getProjectId()).append(" ").append(project.getName()).append(" ").append(project.getDescription()).toString();
            }
        };
    }
    
    Converter<ProjectPhase, String> ProjectPhaseController.getProjectPhaseConverter() {
        return new Converter<ProjectPhase, String>() {
            public String convert(ProjectPhase projectPhase) {
                return new StringBuilder().append(projectPhase.getPhaseId()).append(" ").append(projectPhase.getDescription()).append(" ").append(projectPhase.getStartDate()).toString();
            }
        };
    }
    
    Converter<ProjectPhaseMember, String> ProjectPhaseController.getProjectPhaseMemberConverter() {
        return new Converter<ProjectPhaseMember, String>() {
            public String convert(ProjectPhaseMember projectPhaseMember) {
                return new StringBuilder().append(projectPhaseMember.getPhaseMemberId()).append(" ").append(projectPhaseMember.getStartDate()).append(" ").append(projectPhaseMember.getEndDate()).toString();
            }
        };
    }
    
    @PostConstruct
    void ProjectPhaseController.registerConverters() {
        conversionService.addConverter(getProjectConverter());
        conversionService.addConverter(getProjectPhaseConverter());
        conversionService.addConverter(getProjectPhaseMemberConverter());
    }
    
    void ProjectPhaseController.addDateTimeFormatPatterns(Model model) {
        model.addAttribute("projectPhase_startdate_date_format", DateTimeFormat.patternForStyle("S-", LocaleContextHolder.getLocale()));
        model.addAttribute("projectPhase_enddate_date_format", DateTimeFormat.patternForStyle("S-", LocaleContextHolder.getLocale()));
    }
    
    private String ProjectPhaseController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
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