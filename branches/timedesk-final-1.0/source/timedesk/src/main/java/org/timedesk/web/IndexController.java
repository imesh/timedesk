package org.timedesk.web;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.timedesk.entity.EmployeeAllocation;
import org.timedesk.entity.Project;

@RequestMapping("/")
@Controller
public class IndexController
{
	@PersistenceContext
    transient EntityManager entityManager;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(ModelMap modelMap)
	{		
		return "index";
	}
	
	@ModelAttribute("ongoingProjectsText")
	public String ongoingProjectsText()
	{	
		Query query = entityManager.createQuery("SELECT p FROM Project p WHERE p.startDate < ?1 AND p.endDate >= ?1");
        query.setParameter(1, new Date());
        List<Project> list = query.getResultList();
        
        if(list != null)
        {
        	int count = list.size();
        	if(count == 1)
        		return "There is only 1 project on going ";
        	else
        		return "There are " + count + " projects on going ";
        }
        else
        {
        	return "There are no projects on going ";
        }
	}
	
	@ModelAttribute("employeeAllocationText")
	public String employeeAllocationText()
	{	
		Query query = entityManager.createQuery("SELECT e FROM EmployeeAllocation e WHERE e.startDate < ?1 AND e.endDate >= ?1");
        query.setParameter(1, new Date());
        List<EmployeeAllocation> list = query.getResultList();
        
        if(list != null)
        {
        	int count = list.size();
        	if(count == 1)
        		return " with only 1 employee allocated by now.";
        	else
        		return " with " + count + " employees allocated by now.";
        }
        else
        {
        	return " and all employees are available by now.";
        }
	}
	
	@ModelAttribute("projectListHtml")
	public String projectListHtml()
	{	
		Query query = entityManager.createQuery("SELECT p FROM Project p WHERE p.startDate < ?1 AND p.endDate >= ?1");
        query.setParameter(1, new Date());
        List<Project> list = query.getResultList();
        
        String html = "";
        for(Project project : list)
        {
        	html += project.getName() + "\r";
        }        
        html += "";
        if(list.size() > 0)
        	return html;
        else
        	return "";
	}
}
