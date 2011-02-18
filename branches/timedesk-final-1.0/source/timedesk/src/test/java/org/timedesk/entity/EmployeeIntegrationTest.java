package org.timedesk.entity;

import org.springframework.roo.addon.test.RooIntegrationTest;
import org.timedesk.entity.Employee;
import org.junit.Test;

@RooIntegrationTest(entity = Employee.class)
public class EmployeeIntegrationTest {

    @Test
    public void testMarkerMethod() {
    }
}
