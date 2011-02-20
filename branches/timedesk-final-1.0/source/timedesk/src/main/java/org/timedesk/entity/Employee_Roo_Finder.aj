// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import java.lang.String;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import org.timedesk.entity.Employee;

privileged aspect Employee_Roo_Finder {
    
    public static TypedQuery<Employee> Employee.findEmployeesByFirstNameLike(String firstName) {
        if (firstName == null || firstName.length() == 0) throw new IllegalArgumentException("The firstName argument is required");
        firstName = firstName.replace('*', '%');
        if (firstName.charAt(0) != '%') {
            firstName = "%" + firstName;
        }
        if (firstName.charAt(firstName.length() -1) != '%') {
            firstName = firstName + "%";
        }
        EntityManager em = Employee.entityManager();
        TypedQuery<Employee> q = em.createQuery("SELECT Employee FROM Employee AS employee WHERE LOWER(employee.firstName) LIKE LOWER(:firstName)", Employee.class);
        q.setParameter("firstName", firstName);
        return q;
    }
    
    public static TypedQuery<Employee> Employee.findEmployeesByEmployeeIdLike(String employeeId) {
        if (employeeId == null || employeeId.length() == 0) throw new IllegalArgumentException("The employeeId argument is required");
        employeeId = employeeId.replace('*', '%');
        if (employeeId.charAt(0) != '%') {
            employeeId = "%" + employeeId;
        }
        if (employeeId.charAt(employeeId.length() -1) != '%') {
            employeeId = employeeId + "%";
        }
        EntityManager em = Employee.entityManager();
        TypedQuery<Employee> q = em.createQuery("SELECT Employee FROM Employee AS employee WHERE LOWER(employee.employeeId) LIKE LOWER(:employeeId)", Employee.class);
        q.setParameter("employeeId", employeeId);
        return q;
    }
    
}
