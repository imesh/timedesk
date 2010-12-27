package org.timedesk.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.ProjectComponent;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "projectcomponents", formBackingObject = ProjectComponent.class)
@RequestMapping("/projectcomponents")
@Controller
public class ProjectComponentController {
}
