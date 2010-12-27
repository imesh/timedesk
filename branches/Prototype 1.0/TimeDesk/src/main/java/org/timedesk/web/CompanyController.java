package org.timedesk.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.Company;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "companys", formBackingObject = Company.class)
@RequestMapping("/companys")
@Controller
public class CompanyController {
}
