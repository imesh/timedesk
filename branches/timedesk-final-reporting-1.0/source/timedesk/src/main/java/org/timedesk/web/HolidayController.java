package org.timedesk.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.Holiday;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "holidays", formBackingObject = Holiday.class)
@RequestMapping("/holidays")
@Controller
public class HolidayController {
}
