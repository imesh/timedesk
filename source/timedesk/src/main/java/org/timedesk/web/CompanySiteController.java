package org.timedesk.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.CompanySite;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "companysites", formBackingObject = CompanySite.class)
@RequestMapping("/companysites")
@Controller
public class CompanySiteController {
}
