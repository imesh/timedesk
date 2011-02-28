package org.timedesk.web;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.mail.MailSender;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.timedesk.entity.Employee;
import org.timedesk.entity.Project;
import org.timedesk.entity.ProjectMember;
import org.timedesk.entity.ProjectMemberFeedback;
import org.timedesk.entity.ProjectMemberRole;
import org.timedesk.web.util.ApplicationTrace;
import org.timedesk.web.util.EmailNotifier;
import org.timedesk.web.util.ErrorHandler;
import org.timedesk.web.util.NotificationEnum;
import org.timedesk.web.util.UrlEncoder;

@RooWebScaffold(path = "projectmembers", formBackingObject = ProjectMember.class)
@RequestMapping("/projectmembers")
@Controller
public class ProjectMemberController
{
	@Autowired
	private transient MailSender mailSender;
    @Autowired
    private GenericConversionService conversionService_;

	@RequestMapping(method = RequestMethod.POST)
	public String create(@Valid ProjectMember projectMember, BindingResult result, Model model, HttpServletRequest request)
	{
		if (result.hasErrors())
		{
			ApplicationTrace.trace("Project member creation has errors!");
			ErrorHandler.printErrors(result.getAllErrors());
			model.addAttribute("projectMember", projectMember);
			return "projectmembers/create";
		}
		if (projectMember.getEmployee() == null)
		{
			ObjectError error = new ObjectError("ProjectMember", "Employee should be set to continue.");
			result.addError(error);
			model.addAttribute("projectMember", projectMember);
			return "projectmembers/create";
		}
		String memberId = generateMemberId(projectMember);
		if (memberId != null)
			projectMember.setMemberId(memberId);
		else
		{
			ObjectError error = new ObjectError("ProjectMember", "Error in generating Member ID, please review below information and try again.");
			result.addError(error);
			model.addAttribute("projectMember", projectMember);
			return "projectmembers/create";
		}
		projectMember.persist();

		EmailNotifier.sendMessage(mailSender, NotificationEnum.AssignedToProject, projectMember.getEmployee().getEmail(), projectMember.getProject().getName());
		return "redirect:/projects/" + UrlEncoder.encodeUrlPathSegment(projectMember.getProject().getId().toString(), request);
	}

	@RequestMapping(params = "form", method = RequestMethod.GET)
	public String createForm(Model model, @RequestParam(value = "parentId", required = false) Long parentId)
	{
		Project project = null;
		ProjectMember member = new ProjectMember();
		if (parentId != null)
		{
			project = Project.findProject(parentId);
			if (project != null)
				member.setProject(project);
		}
		model.addAttribute("projectMember", member);
		List dependencies = new ArrayList();
		if (Project.countProjects() == 0)
		{
			dependencies.add(new String[]
			{ "project", "projects" });
		}
		model.addAttribute("dependencies", dependencies);
		return "projectmembers/create";
	}

	@RequestMapping(method = RequestMethod.PUT)
	public String update(@Valid ProjectMember projectMember, BindingResult result, Model model, HttpServletRequest request)
	{
		if (result.hasErrors())
		{
			model.addAttribute("projectMember", projectMember);
			return "projectmembers/update";
		}
		projectMember.merge();
		return "redirect:/projects/" + UrlEncoder.encodeUrlPathSegment(projectMember.getProject().getId().toString(), request);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public String delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model)
	{
		ProjectMember projectMember = ProjectMember.findProjectMember(id);
		String mailTo = projectMember.getEmployee().getEmail();
		String projectName = projectMember.getProject().getName();
		String projectId = projectMember.getProject().getId().toString();
		projectMember.remove();
		EmailNotifier.sendMessage(mailSender, NotificationEnum.UnAssignedFromProject, mailTo, projectName);
		return "redirect:/projects/" + projectId;
	}

	@ModelAttribute("employees")
	public Collection<Employee> populateEmployees()
	{
		ApplicationTrace.trace("populateEmployees()");
		List<Employee> list = Employee.findAllEmployees();
		if(list != null)
			ApplicationTrace.trace("record count: " + list.size());
		return list;
	}

	@ModelAttribute("projects")
	public Collection<Project> populateProjects()
	{
		ApplicationTrace.trace("populateProjects()");
		List<Project> list = Project.findAllProjects();
		if(list != null)
			ApplicationTrace.trace("record count: " + list.size());
		return list;
	}

	@ModelAttribute("projectmemberfeedbacks")
	public Collection<ProjectMemberFeedback> populateProjectMemberFeedbacks()
	{
		ApplicationTrace.trace("populateProjectMemberFeedbacks()");
		List<ProjectMemberFeedback> list = ProjectMemberFeedback.findAllProjectMemberFeedbacks();
		if(list != null)
			ApplicationTrace.trace("record count: " + list.size());
		return list;
	}

	@ModelAttribute("projectmemberroles")
	public Collection<ProjectMemberRole> populateProjectMemberRoles()
	{
		ApplicationTrace.trace("populateProjectMemberRoles()");
		List<ProjectMemberRole> list = ProjectMemberRole.findAllProjectMemberRoles();
		if(list != null)
			ApplicationTrace.trace("record count: " + list.size());
		return list;
	}

	Converter<ProjectMember, String> getProjectMemberConverter()
	{
		return new Converter<ProjectMember, String>()
		{
			public String convert(ProjectMember projectMember)
			{
				return new StringBuilder().append(projectMember.getEmployee().getFirstName()).append(" ").append(projectMember.getEmployee().getLastName()).toString();
			}
		};
	}

	Converter<Employee, String> getEmployeeConverter()
	{
		return new Converter<Employee, String>()
		{
			public String convert(Employee employee)
			{
				return new StringBuilder().append(employee.getEmployeeId()).append(" ").append(employee.getFirstName()).append(" ").append(employee.getLastName()).toString();
			}
		};
	}

	Converter<Project, String> getProjectConverter()
	{
		return new Converter<Project, String>()
		{
			public String convert(Project project)
			{
				return new StringBuilder().append(project.getProjectId()).append(" ").append(project.getName()).append(" ").append(project.getDescription()).toString();
			}
		};
	}

	Converter<ProjectMemberFeedback, String> getProjectMemberFeedbackConverter()
	{
		return new Converter<ProjectMemberFeedback, String>()
		{
			public String convert(ProjectMemberFeedback projectMemberFeedback)
			{
				return new StringBuilder().append(projectMemberFeedback.getDescription()).toString();
			}
		};
	}

	Converter<ProjectMemberRole, String> getProjectMemberRoleConverter()
	{
		return new Converter<ProjectMemberRole, String>()
		{
			public String convert(ProjectMemberRole projectMemberRole)
			{
				return new StringBuilder().append(projectMemberRole.getRoleId()).append(" ").append(projectMemberRole.getName()).toString();
			}
		};
	}

	@PostConstruct
	void registerConverters()
	{
		conversionService_.addConverter(getProjectMemberConverter());
		conversionService_.addConverter(getEmployeeConverter());
		conversionService_.addConverter(getProjectConverter());
		conversionService_.addConverter(getProjectMemberFeedbackConverter());
		conversionService_.addConverter(getProjectMemberRoleConverter());
	}

	private String generateMemberId(ProjectMember member)
	{
		if (member != null)
		{
			int i = 1;
			String memberId = member.getProject().getProjectId().toUpperCase();
			String memberKey = null;
			if (member.getEmployee() != null)
				memberKey = memberId += member.getEmployee().getEmployeeId().toUpperCase();
			else
			{
				memberKey = memberId += "MEM";
				memberId = memberId + (i++);
			}
			ApplicationTrace.trace("New Member ID: " + memberId);
			while (ProjectMember.findProjectMember(memberId) != null)
			{
				memberId = memberKey + (i++);
				ApplicationTrace.trace("New Member ID: " + memberId);
			}
			return memberId;
		}
		return null;
	}
}
