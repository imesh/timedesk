package org.timedesk.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.ProjectMember;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "projectmembers", formBackingObject = ProjectMember.class)
@RequestMapping("/projectmembers")
@Controller
public class ProjectMemberController {
}
