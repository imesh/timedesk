package org.timedesk.web;

import java.beans.PropertyEditorSupport;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
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
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.timedesk.entity.Employee;
import org.timedesk.entity.ProjectMember;
import org.timedesk.entity.ProjectPhase;
import org.timedesk.entity.ProjectPhaseMember;
import org.timedesk.web.util.ApplicationTrace;
import org.timedesk.web.util.EmailNotifier;
import org.timedesk.web.util.ErrorHandler;
import org.timedesk.web.util.NotificationEnum;
import org.timedesk.web.util.UrlEncoder;

@RooWebScaffold(path = "projectphasemembers", formBackingObject = ProjectPhaseMember.class)
@RequestMapping("/projectphasemembers")
@Controller
public class ProjectPhaseMemberController
{
	@Autowired
	private transient MailSender mailSender;
	@Autowired
	private GenericConversionService conversionService;

	@RequestMapping(params = "form", method = RequestMethod.GET)
	public String createForm(Model model, @RequestParam(value = "parentId", required = false) Long parentId)
	{
		ProjectPhaseMember phaseMember = new ProjectPhaseMember();
		if (parentId != null)
		{
			ProjectPhase projectPhase = ProjectPhase.findProjectPhase(parentId);
			if (projectPhase != null)
				phaseMember.setProjectPhase(projectPhase);
		}
		model.addAttribute("projectPhaseMember", phaseMember);
		addDateTimeFormatPatterns(model);
		List dependencies = new ArrayList();
		if (ProjectPhase.countProjectPhases() == 0)
		{
			dependencies.add(new String[]
			{ "projectPhase", "projectphases" });
		}
		model.addAttribute("dependencies", dependencies);
		return "projectphasemembers/create";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String create(@Valid ProjectPhaseMember projectPhaseMember, BindingResult result, Model model, HttpServletRequest request)
	{
		if (result.hasErrors())
		{
			ErrorHandler.printErrors(result.getAllErrors());
			model.addAttribute("projectPhaseMember", projectPhaseMember);
			addDateTimeFormatPatterns(model);
			return "projectphasemembers/create";
		}
		if (projectPhaseMember.getProjectPhase() == null)
		{
			ObjectError error = new ObjectError("ProjectPhaseMember", "Project phase is not set.");
			result.addError(error);
			model.addAttribute("projectPhaseMember", projectPhaseMember);
			addDateTimeFormatPatterns(model);
			return "projectphasemembers/create";
		}
		if (projectPhaseMember.getProjectMember() == null)
		{
			ObjectError error = new ObjectError("ProjectPhaseMember", "Project phase member is not set.");
			result.addError(error);
			model.addAttribute("projectPhaseMember", projectPhaseMember);
			addDateTimeFormatPatterns(model);
			return "projectphasemembers/create";
		}
		String phaseMemberId = generatePhaseMemberId(projectPhaseMember);
		if (phaseMemberId != null)
			projectPhaseMember.setPhaseMemberId(phaseMemberId);
		else
		{
			ObjectError error = new ObjectError("ProjectPhaseMember", "Error in generating Phase Member ID, please review below information and try again.");
			result.addError(error);
			model.addAttribute("projectPhaseMember", projectPhaseMember);
			addDateTimeFormatPatterns(model);
			return "projectphasemembers/create";
		}
		ObjectError error = validateEmployeeAllocation(projectPhaseMember, result, model);
		if (error != null)
		{
			result.addError(error);
			model.addAttribute("projectPhaseMember", projectPhaseMember);
			addDateTimeFormatPatterns(model);
			return "projectphasemembers/create";
		}
		projectPhaseMember.persist();
		EmailNotifier.sendMessage(mailSender, NotificationEnum.AllocatedToProject, projectPhaseMember.getProjectMember().getEmployee().getEmail(), projectPhaseMember.getProjectMember().getProject().getName(), projectPhaseMember.getProjectPhase().getDescription(), projectPhaseMember.getStartDate(), projectPhaseMember.getEndDate());
		return "redirect:/projectphasemembers/" + UrlEncoder.encodeUrlPathSegment(projectPhaseMember.getId().toString(), request);
	}

	private String generatePhaseMemberId(ProjectPhaseMember projectPhaseMember)
	{
		if (projectPhaseMember != null)
		{
			int i = 1;
			String phaseMemberKey = projectPhaseMember.getProjectPhase().getPhaseId().toUpperCase() + "MEM";
			String phaseMemberId = phaseMemberKey + (i++);
			ApplicationTrace.trace("New Phase Member ID: " + phaseMemberId);
			while (ProjectPhaseMember.findProjectPhaseMember(phaseMemberId) != null)
			{
				phaseMemberId = phaseMemberKey + (i++);
				ApplicationTrace.trace("New Phase Member ID: " + phaseMemberId);
			}
			return phaseMemberId;
		}
		return null;
	}

	@RequestMapping(method = RequestMethod.PUT)
	public String update(@Valid ProjectPhaseMember projectPhaseMember, BindingResult result, Model model, HttpServletRequest request)
	{
		if (result.hasErrors())
		{
			model.addAttribute("projectPhaseMember", projectPhaseMember);
			addDateTimeFormatPatterns(model);
			return "projectphasemembers/update";
		}
		ObjectError error = validateEmployeeAllocation(projectPhaseMember, result, model);
		if (error != null)
		{
			result.addError(error);
			model.addAttribute("projectPhaseMember", projectPhaseMember);
			addDateTimeFormatPatterns(model);
			return "projectphasemembers/update";
		}
		projectPhaseMember.merge();
		return "redirect:/projectphases/" + UrlEncoder.encodeUrlPathSegment(projectPhaseMember.getProjectPhase().getId().toString(), request);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public String delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model)
	{
		ProjectPhaseMember member = ProjectPhaseMember.findProjectPhaseMember(id);
		String sendTo = member.getProjectMember().getEmployee().getEmail();
		String projectName = member.getProjectMember().getProject().getName();
		String phase = member.getProjectPhase().getDescription();
		Date startDate = member.getStartDate();
		Date endDate = member.getEndDate();
		String phaseId = member.getProjectPhase().getId().toString();
		member.remove();
		EmailNotifier.sendMessage(mailSender, NotificationEnum.DeAllocatedFromProject, sendTo, projectName, phase, startDate, endDate);
		return "redirect:/projectphases/" + phaseId;
	}

	Converter<ProjectMember, String> getProjectMemberConverter()
	{
		return new Converter<ProjectMember, String>()
		{
			public String convert(ProjectMember projectMember)
			{
				return new StringBuilder().append(projectMember.getMemberId()).append(" ").append(projectMember.getEmployee().getFirstName()).append(" ").append(projectMember.getEmployee().getLastName()).toString();
			}
		};
	}

	Converter<ProjectPhase, String> getProjectPhaseConverter()
	{
		return new Converter<ProjectPhase, String>()
		{
			public String convert(ProjectPhase projectPhase)
			{
				return new StringBuilder().append(projectPhase.getPhaseId()).append(" ").append(projectPhase.getDescription()).toString();
			}
		};
	}

	Converter<ProjectPhaseMember, String> getProjectPhaseMemberConverter()
	{
		return new Converter<ProjectPhaseMember, String>()
		{
			public String convert(ProjectPhaseMember projectPhaseMember)
			{
				return new StringBuilder().append(projectPhaseMember.getPhaseMemberId()).append(" ").append(projectPhaseMember.getStartDate()).append(" ").append(projectPhaseMember.getEndDate()).toString();
			}
		};
	}

	@PostConstruct
	void registerConverters()
	{
		conversionService.addConverter(getProjectMemberConverter());
		conversionService.addConverter(getProjectPhaseConverter());
		conversionService.addConverter(getProjectPhaseMemberConverter());
	}
    
	@ModelAttribute("projectmembers")
	public Collection<ProjectMember> populateProjectMembers(@RequestParam(value = "parentId", required = false) Long parentId)
	{
		if (parentId == null)
		{
			ApplicationTrace.trace("populateProjectMembers(): phaseId is null");
			List<ProjectMember> list = ProjectMember.findAllProjectMembers();
			ApplicationTrace.trace("record count: " + list.size());
			return list;
		}
		else
		{
			ApplicationTrace.trace("populateProjectMembers(): phaseId: " + parentId);
			ProjectPhase projectPhase = ProjectPhase.findProjectPhase(parentId);
			if (projectPhase != null)
			{
				ApplicationTrace.trace("phase found");
				return ProjectMember.findProjectMemberByProject(projectPhase.getProject().getId());
			}
			else
			{
				ApplicationTrace.trace("phase not found returning all");
				List<ProjectMember> list = ProjectMember.findAllProjectMembers();
				ApplicationTrace.trace("record count: " + list.size());
				return list;
			}
		}
	}

	@ModelAttribute("projectphases")
	public Collection<ProjectPhase> populateProjectPhases(@RequestParam(value = "parentId", required = false) Long parentId)
	{
		if (parentId == null)
		{
			ApplicationTrace.trace("populateProjectPhases(): phaseId is null");
			return ProjectPhase.findAllProjectPhases();
		}
		else
		{
			ProjectPhase projectPhase = ProjectPhase.findProjectPhase(parentId);
			if(projectPhase != null)
			{
				ApplicationTrace.trace("phase found");
				Collection<ProjectPhase> collection = new ArrayList();
				collection.add(projectPhase);
				return collection;
			}
			else
			{
				ApplicationTrace.trace("phase not found returning all");
				return ProjectPhase.findAllProjectPhases();
			}
		}
	}

	private ObjectError validateEmployeeAllocation(ProjectPhaseMember projectPhaseMember, BindingResult result, Model model)
	{
		Employee employee = projectPhaseMember.getProjectMember().getEmployee();
		if (employee != null)
		{
			Integer maxAllocation = employee.getMaxAllocation();
			if (maxAllocation != null)
			{
				if (projectPhaseMember.getAllocation().intValue() > maxAllocation.intValue())
				{
					ObjectError error = new ObjectError(projectPhaseMember.toString(), "Allocation should be less than or equal to Employee Max Allocation " + maxAllocation.intValue() + ".");
					return error;
				}
				int currentAllocation = employee.findAllocation(projectPhaseMember.getId(), projectPhaseMember.getStartDate(), projectPhaseMember.getEndDate());
				int allowed = maxAllocation.intValue() - currentAllocation;
				ApplicationTrace.trace("Max Allocation: " + maxAllocation.intValue());
				ApplicationTrace.trace("Current Allocation: " + currentAllocation);
				if (maxAllocation.intValue() == currentAllocation)
				{
					ObjectError error = new ObjectError(projectPhaseMember.toString(), "There is no space to allocate " + employee.getFirstName() + " " + employee.getLastName() + " from " + shortDate(projectPhaseMember.getStartDate()) + " to " + shortDate(projectPhaseMember.getEndDate()) + ".");
					return error;
				}
				else if (projectPhaseMember.getAllocation().intValue() > allowed)
				{
					ObjectError error = new ObjectError(projectPhaseMember.toString(), "Allocation should be less than or equal to remaining allocation " + allowed + "% from " + shortDate(projectPhaseMember.getStartDate()) + " to " + shortDate(projectPhaseMember.getEndDate()) + ".");
					return error;
				}
			}
		}
		return null;
	}

	private String shortDate(Date date)
	{
		if (date != null)
		{
			DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			return formatter.format(date);
		}
		return "";
	}
}
