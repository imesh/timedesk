package org.timedesk.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.EmployeeSkill;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "employeeskills", formBackingObject = EmployeeSkill.class)
@RequestMapping("/employeeskills")
@Controller
public class EmployeeSkillController {
}
