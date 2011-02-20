package org.timedesk.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.timedesk.entity.Notification;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "notifications", formBackingObject = Notification.class)
@RequestMapping("/notifications")
@Controller
public class NotificationController {
}
