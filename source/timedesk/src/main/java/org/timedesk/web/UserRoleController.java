package org.timedesk.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.UserRole;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "userroles", formBackingObject = UserRole.class)
@RequestMapping("/userroles")
@Controller
public class UserRoleController {
}
