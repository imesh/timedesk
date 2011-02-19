package org.timedesk.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.EmployeeAllocation;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "employeeallocations", formBackingObject = EmployeeAllocation.class)
@RequestMapping("/employeeallocations")
@Controller
public class EmployeeAllocationController {
}
