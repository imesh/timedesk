package org.timedesk.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.Report;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "reports", formBackingObject = Report.class)
@RequestMapping("/reports")
@Controller
public class ReportController {
}
